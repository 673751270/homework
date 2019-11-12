package com.nfdw.controller;

import com.nfdw.entity.SysUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;

public abstract class BaseLoginController {

    @PostMapping(value = "/login")
    public String login(SysUser user, String code, Model model, HttpServletRequest request) {
        String codeMsg = (String) request.getSession().getAttribute("_code");
        if (null != code && !code.toLowerCase().equals(codeMsg)) {
            model.addAttribute("message", "验证码错误");
            return "/login";
        }
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername().trim(),
                user.getPassword());
        Subject subject = SecurityUtils.getSubject();
        String msg = null;
        try {
            subject.login(token);
            //subject.hasRole("admin");
            if (subject.isAuthenticated()) {
                return "redirect:/main";
            }
        } catch (UnknownAccountException e) {
            msg = e.getMessage();
        } catch (IncorrectCredentialsException e) {
            msg = "用户名/密码错误";
        } catch (ExcessiveAttemptsException e) {
            msg = e.getMessage();
        }
        if (msg != null) {
            model.addAttribute("message", msg);
        }
        return "/login";
    }
}
