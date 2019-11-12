package com.nfdw.section.controller;

import lombok.extern.slf4j.Slf4j;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nfdw.base.controller.BaseController;
//import com.nfdw.base.BaseController;
import com.nfdw.section.entity.DepartmentApply;
import com.nfdw.section.service.DepartmentAppayService;
import com.nfdw.util.ReType;


/**
 * 电网业务部门申请表
 * sjq
 */
@Slf4j
@Controller
@RequestMapping(value = "/department_Apply")
public class DepartmentApplyController extends BaseController {
	
	@Autowired
	DepartmentAppayService departmentAppayService;
	   
	    @GetMapping(value = "showDeparApplyList")
	    @RequiresPermissions("section:show")
	    public String showDeparApplyList(Model model) {
	    	log.info("返回电网业务部门申请表查询View=====>");
	        return "/section/departmentApply/deparApplyList";
	    }
	
      /**
       * 
       * @param 查询列表
       * @param departmentApply
       * @param page 1
       * @param limit 0,10
       * @return
       */
	    @GetMapping(value = "DepartmentApply")
	    @ResponseBody
	    @RequiresPermissions("section:show")
	    public ReType departmentApply(Model model, DepartmentApply departmentApply, String page, String limit) {
	    	log.info("正在查询电网业务部门申请表,请稍后");
	        return departmentAppayService.show(departmentApply, Integer.valueOf(page), Integer.valueOf(limit));
	    }
	    
	      
	    
	
}
