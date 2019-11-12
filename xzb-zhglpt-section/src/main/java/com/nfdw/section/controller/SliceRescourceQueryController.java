package com.nfdw.section.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * sjq
 * @author admin
 *
 */
@Controller
@RequestMapping(value = "/sliceRescourceQuery")
public class SliceRescourceQueryController {

	/**
	 * 转发视图
	 * @param model
	 * @return
	 */
	  @GetMapping(value = "showSliceRescourceQuery")
	    @RequiresPermissions("section:show")
	    public String showSliceRescourceQuery(Model model) {
	    	System.out.println("返回切片资源查询View=====>");
	        return "/section/sliceResourceQuery/sliceResourceQueryList";
	    }
	
}
