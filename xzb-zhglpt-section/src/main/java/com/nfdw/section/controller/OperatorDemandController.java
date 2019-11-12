package com.nfdw.section.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * sj1
 * 2019/01
 * @author admin
 * 运营商行业切片需求表
 */
@Controller
@RequestMapping(value = "/operatorDemand")
public class OperatorDemandController {
	
	    @GetMapping(value = "showOperatorDemandList")
	    @RequiresPermissions("section:show")
	    public String showOperatorDemandList(Model model) {
	    	System.out.println("返回运营商行业切片需求表View=====>");
	        return "/section/operatorDemand/operatorDemandList";
	    }

}
