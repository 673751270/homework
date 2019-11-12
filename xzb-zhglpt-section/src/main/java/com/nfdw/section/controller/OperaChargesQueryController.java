package com.nfdw.section.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nfdw.base.controller.BaseController;
//import com.nfdw.base.BaseController;

import com.nfdw.util.ReType;
/**
 * 运营商资费查询
 * sjq
 * @author admin
 *
 */
@Controller
@RequestMapping(value = "/dperaChargesQuery")
public class OperaChargesQueryController extends BaseController{
	
   
    @GetMapping(value = "showdperaChargesQuery")
    @RequiresPermissions("section:show")
    public String showdperaChargesQuery(Model model) {
    	System.out.println("返回运营商资费查询View=====>");
        return "/section/operatorChargesQuery/operChargesQueryList";
    }
 
    
	
}
