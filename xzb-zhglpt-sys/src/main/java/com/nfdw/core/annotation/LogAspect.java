package com.nfdw.core.annotation;

import com.alibaba.fastjson.JSON;
import com.nfdw.core.shiro.ShiroUtil;
import com.nfdw.entity.CurrentUser;
import com.nfdw.entity.SysLog;
import com.nfdw.mapper.SysLogMapper;
import com.nfdw.util.IpUtil;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;


/**

 * 为增删改添加监控
 */
@Aspect
@Component
public class LogAspect {

    @Autowired
    private SysLogMapper logMapper;

    @Pointcut("@annotation(com.nfdw.co" +
            "re.annotation.Log)")
    private void pointcut() {

    }

    @After("pointcut()")
    public void insertLogSuccess(JoinPoint jp) {
        addLog(jp, getDesc(jp));
    }

    private void addLog(JoinPoint jp, String text) {
        Log.LOG_TYPE type = getType(jp);
        MethodSignature methodSignature = (MethodSignature) jp.getSignature();
        SysLog log = new SysLog();
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        //一些系统监控
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            String ip = IpUtil.getIp(request);
            log.setIp(ip);
        }
        log.setCreateTime(new Date());
        log.setType(type.toString());

        Object[] obj = jp.getArgs();
        StringBuffer buffer = new StringBuffer();
        if (obj != null) {
            for (int i = 0; i < obj.length; i++) {
                buffer.append("[参数" + (i + 1) + ":");
                Object o = obj[i];
                if (o instanceof Model) {
                    continue;
                }
                String parameter = null;
                try {
                    parameter = JSON.toJSONString(o);
                } catch (Exception e) {
                    continue;
                }
                buffer.append(parameter);
                buffer.append("]");
            }
        }
        CurrentUser currentUsr = ShiroUtil.getCurrentUse();
        if (currentUsr != null) {
            log.setUserName(currentUsr.getUsername());
        } else {
            log.setUserName("SYS(系统)");
        }
        Subject subject = ShiroUtil.getSubject();
        if (!subject.isAuthenticated() && methodSignature.getMethod().getName().equals("login")) {
            log.setText("登录失败");
            log.setParam(buffer.toString());
            logMapper.insert(log);
        } else if (subject.isAuthenticated() && methodSignature.getMethod().getName().equals("login")) {
            log.setText("登录成功");
            logMapper.insert(log);
        } else {
            log.setText(text);
            log.setParam(buffer.toString());
            logMapper.insert(log);
        }
    }

    /**
     * 记录异常
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(value = "pointcut()", throwing = "e")
    public void afterException(JoinPoint joinPoint, Exception e) {
        System.out.print("-----------afterException:" + e.getMessage());
        addLog(joinPoint, getDesc(joinPoint) + e.getMessage());
    }


    private String getDesc(JoinPoint joinPoint) {
        MethodSignature methodName = (MethodSignature) joinPoint.getSignature();
        Method method = methodName.getMethod();
        return method.getAnnotation(Log.class).desc();
    }

    private Log.LOG_TYPE getType(JoinPoint joinPoint) {
        MethodSignature methodName = (MethodSignature) joinPoint.getSignature();
        Method method = methodName.getMethod();
        return method.getAnnotation(Log.class).type();
    }
}

