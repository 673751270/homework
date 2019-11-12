package com.nfdw.config;


import com.nfdw.core.shiro.RetryLimitCredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.springframework.context.annotation.Bean;

public abstract class BaseShiroConfig {

    @Bean(name = "getRetryLimitCredentialsMatcher")
    public RetryLimitCredentialsMatcher getRetryLimitCredentialsMatcher() {
//    RetryLimitCredentialsMatcher rm = new RetryLimitCredentialsMatcher(getCacheManager(),2);
        RetryLimitCredentialsMatcher rm = new RetryLimitCredentialsMatcher(getCacheManager());
        rm.setHashAlgorithmName("md5");
        rm.setHashIterations(4);
        return rm;

    }

    @Bean
    public EhCacheManager getCacheManager() {
        EhCacheManager ehCacheManager = new EhCacheManager();
        ehCacheManager.setCacheManagerConfigFile("classpath:ehcache/ehcache.xml");
        return ehCacheManager;
    }


}
