package com.nfdw.section.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nfdw.base.controller.BaseController;
import com.nfdw.section.service.DepartmentAppayService;
//import com.nfdw.base.BaseController;


/**
 * 
 * @author admin
 * sjq 
 * 2019/1
 */
@Controller
@RequestMapping(value = "/demandSchedule")
public class DemandScheduleController extends BaseController{
	    @Autowired
	    DepartmentAppayService departmentAppayService;
	   
	    @GetMapping(value = "showDemandScheduleList")
	    @RequiresPermissions("section:show")
	    public String showDemandScheduleList(Model model) {
	    	System.out.println("返回需求明细表View=====>");
	        return "/section/demandSchedule/demandScheduleList";
	    }
	
	
	
	

}
