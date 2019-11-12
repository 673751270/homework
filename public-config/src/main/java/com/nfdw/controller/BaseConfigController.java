package com.nfdw.controller;

import com.nfdw.entity.Locking;
import com.nfdw.entity.PasswordComplexity;
import com.nfdw.service.ConfigService;
import com.nfdw.util.JsonUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public abstract class BaseConfigController {

    @Autowired
    ConfigService configService;

    @GetMapping("showConfig")
    @RequiresPermissions("config:show")
    public String showConfig(Model model) {
        model.addAttribute("complexitys", configService.getAll(PasswordComplexity.class));
        model.addAttribute("locking", configService.getAll(Locking.class));
        return "/system/config/config";
    }

    @PostMapping("complexityApplication")
    @ResponseBody
    @RequiresPermissions("config:show")
    @Transactional(rollbackFor = Exception.class)
    public JsonUtil complexityApplication(PasswordComplexity passwordComplexity) {
        PasswordComplexity passwordComplexity1 = new PasswordComplexity();
        passwordComplexity1.setIsUse(1);
        configService.update(PasswordComplexity.class.getSimpleName(), passwordComplexity1);
        passwordComplexity.setIsUse(2);
        return configService.updateBykey(PasswordComplexity.class.getSimpleName(), passwordComplexity);
    }

    @PostMapping("saveConfig")
    @ResponseBody
    @RequiresPermissions("config:show")
    public JsonUtil saveConfig(Locking locking) {
        return configService.update(Locking.class.getSimpleName(), locking);
    }


}
