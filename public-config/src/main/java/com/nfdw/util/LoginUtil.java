package com.nfdw.util;

import com.nfdw.entity.SysUser;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.UnknownAccountException;

import java.util.Date;

public class LoginUtil {

    public static boolean Login(SysUser user) {
        if (user == null) {
            throw new UnknownAccountException("账户密码不正确");
        } else if (user.getLockingDate() != null && !user.getLockingDate().before(new Date())) {
            throw new ExcessiveAttemptsException("账号已被锁定，请找管理员解锁或者等待");
        } else {
            return true;
        }
    }
}
