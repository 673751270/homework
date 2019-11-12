package com.nfdw.section.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nfdw.base.controller.BaseController;

/**
 * 用户管理
 */
//@Api(value="user")
@Controller
@RequestMapping(value = "/section")
public class SectionController extends BaseController {

    //private static final Logger

    @GetMapping(value = "showSection")
    @RequiresPermissions("section:show")
    public String showUser(Model model) {
        return "/section/qiepain/sectionList";
    }
    @GetMapping(value = "showHome")
    public String showHome(Model model) {
        return "/section/qiepain/newHomeShow";
    }
}
