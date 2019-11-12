package com.nfdw.core.shiro;

import java.util.Date;
import java.util.Iterator;
import java.util.concurrent.atomic.AtomicInteger;

import com.nfdw.entity.Locking;
import com.nfdw.service.ConfigService;
import com.nfdw.service.PublicUserService;
import com.nfdw.util.DateUtils;
import lombok.extern.slf4j.Slf4j;
import net.sf.ehcache.config.CacheConfiguration;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;

import cn.hutool.core.util.StrUtil;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 验证器，增加了登录次数校验功能
 * 限制尝试登陆次数,防止暴力破解
 */
@Slf4j
@Component
public class RetryLimitCredentialsMatcher extends HashedCredentialsMatcher {

    @Autowired
    ConfigService configService;

    @Autowired
    PublicUserService publicUserService;

    private Cache<String, AtomicInteger> loginRetryCache;

    private EhCacheManager ehCacheManager;

    private int maxRetryCount = 5;

    private long timeToIdleSeconds;

    public Cache<String, AtomicInteger> getLoginRetryCache() {
        return loginRetryCache;
    }

    public void setLoginRetryCache(Cache<String, AtomicInteger> loginRetryCache) {
        this.loginRetryCache = loginRetryCache;
    }

    public EhCacheManager getEhCacheManager() {
        return ehCacheManager;
    }

    public void setEhCacheManager(EhCacheManager ehCacheManager) {
        this.ehCacheManager = ehCacheManager;
    }

    public int getMaxRetryCount() {
        return maxRetryCount;
    }

    public void setMaxRetryCount(int maxRetryCount) {
        this.maxRetryCount = maxRetryCount;
    }

    public long getTimeToIdleSeconds() {
        return timeToIdleSeconds;
    }

    public void setTimeToIdleSeconds(long timeToIdleSeconds) {
        this.timeToIdleSeconds = timeToIdleSeconds;
    }

    public RetryLimitCredentialsMatcher() {
    }

    public RetryLimitCredentialsMatcher(CacheManager cacheManager) {
        this.ehCacheManager = (EhCacheManager) cacheManager;
        this.loginRetryCache = ehCacheManager.getCache("loginRetryCache");
    }

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        CacheConfiguration configuration = ehCacheManager.getCacheManager().getCache("loginRetryCache").getCacheConfiguration();
        Locking locking = (Locking) configService.getAll(Locking.class);
        configuration.setTimeToIdleSeconds(locking.getLockingMinute() * 60);
        this.timeToIdleSeconds = configuration.getTimeToIdleSeconds();
        this.maxRetryCount = locking.getLockingNumber();

        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String username = (String) token.getPrincipal();
        //retry count + 1
        boolean matches;
        if (null != upToken.getHost() && !"".equals(upToken.getHost())) {
            SimpleCredentialsMatcher simpleCredentialsMatcher = new SimpleCredentialsMatcher();
            matches = simpleCredentialsMatcher.doCredentialsMatch(token, info);
        } else {
            matches = super.doCredentialsMatch(token, info);
        }
        if (matches) {
            if (loginRetryCache.get(username) != null) {
                loginRetryCache.remove(username);
                publicUserService.updateByUserName(null, username);
            }
        } else {
            AtomicInteger retryCount = loginRetryCache.get(username) == null
                    ? new AtomicInteger(0) : loginRetryCache.get(username);
            log.info("retryCount:{}, username:{}", retryCount, username);
            if (retryCount.incrementAndGet() >= this.maxRetryCount) {
                publicUserService.updateByUserName(DateUtils.addSeconds(new Date(), this.timeToIdleSeconds), username);
                log.warn("username: {} tried to login more than {} times in perid", username, this.maxRetryCount);
                throw new ExcessiveAttemptsException(StrUtil.format("账号错误{}次已被锁定，请找管理员解锁或者等待{}分钟!", this.maxRetryCount, this.timeToIdleSeconds / 60));
            }
            loginRetryCache.put(username, retryCount);
            log.info(String.valueOf(retryCount.get()));
        }
        return matches;
    }
}