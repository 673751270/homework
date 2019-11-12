package com.nfdw.controller;


import com.nfdw.core.annotation.Log;
import com.nfdw.entity.Authentication;
import com.nfdw.entity.File;
import com.nfdw.entity.InformationPublish;
import com.nfdw.entity.SysDepartment;
import com.nfdw.exception.MyException;
import com.nfdw.service.AuthenticationService;
import com.nfdw.service.DepartmentService;
import com.nfdw.util.BeanUtil;
import com.nfdw.util.JsonUtil;
import com.nfdw.util.ReType;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/authentication")
@Controller
public class AuthenticationController {

    @Autowired
    DepartmentService departmentService;

    @Autowired
    AuthenticationService authenticationService;


    @GetMapping("/showAuthentication")
    public String showAuthentication(Model model) {
        List<SysDepartment> ls = departmentService.queryAll();
        model.addAttribute("department", ls);
        return "/system/authentication/authenticationlist";
    }

    @ApiOperation(value = "/showAuthenticationlist", httpMethod = "GET", notes = "鉴权列表")
    @GetMapping(value = "showAuthenticationlist")
    @ResponseBody
    @RequiresPermissions("authentication:show")
    public ReType showRoleList(Authentication authentication, Model model, String page, String limit) {
        ReType show = authenticationService.show(authentication, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }


    @GetMapping("/showAddauthentication")
    public String showAddauthentication(Model model) {
        List<SysDepartment> ls = departmentService.queryAll();
        model.addAttribute("department", ls);
        return "/system/authentication/add-authentication";
    }


    /**
     * 添加权利
     */
    @ApiOperation(value = "/addAuthentication", httpMethod = "POST", notes = "添加权利")
    @Log(desc = "添加权利")
    @PostMapping(value = "addAuthentication")
    @ResponseBody
    public JsonUtil addAuthentication(Authentication authentication) {
        if (StringUtils.isEmpty(authentication.getRightName())) {
            JsonUtil.error("权利名称不能为空");
        }
        JsonUtil j = new JsonUtil();
        try {

            authenticationService.insertSelective(authentication);
            String idsList = authentication.getUserIds();
            String[] arrIds = idsList.split(",");
            System.out.println(idsList + "/" + arrIds.toString());

            String usernames = "";
            for (String id : arrIds) {
                String name = authenticationService.getUserName(id);
                usernames = usernames.concat(name + ",");
            }
            usernames = usernames.substring(0, usernames.lastIndexOf(","));
            authenticationService.insertUsernames(usernames, authentication.getId());

            //操作role-menu data
            j.setMsg("保存成功");

        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }


    @Log(desc = "删除权利", type = Log.LOG_TYPE.DEL)
    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除权利")
    @PostMapping(value = "/del")
    @ResponseBody
    @Transactional
    public JsonUtil del(String id, boolean flag) {
        JsonUtil j = new JsonUtil();

        try {
            Authentication oldAuthentication = authenticationService.queryInfoById(id);

            authenticationService.deleteByPrimaryKey(oldAuthentication);
            j.setFlag(true);
            j.setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return j;
    }


    /**
     * 编辑权利
     */

    @GetMapping("/showEidtauthentication")
    public String showEidtauthentication(Model model, String id, boolean detail) {
        Authentication authentication = authenticationService.queryInfoById(id);
        model.addAttribute("authentication", authentication);
        model.addAttribute("detail", detail);

        List<SysDepartment> ls = departmentService.queryAll();
        model.addAttribute("department", ls);
        return "/system/authentication/update-authentication";
    }

    @ApiOperation(value = "/updateAuthentication", httpMethod = "POST", notes = "更新权利")
    @Log(desc = "更新权利", type = Log.LOG_TYPE.UPDATE)
    @PostMapping(value = "updateAuthentication")
    @ResponseBody
    public JsonUtil updateAuthentication(Authentication authentication) {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        if (authentication == null) {
            jsonUtil.setMsg("获取数据失败");
            return jsonUtil;
        }
        try {
            Authentication oldAuthentication = authenticationService.selectByPrimaryKey(authentication.getId());
            BeanUtil.copyNotNullBean(authentication, oldAuthentication);

            authenticationService.updateByPrimaryKeySelective(oldAuthentication);

            String idsList = authentication.getUserIds();
            String[] arrIds = idsList.split(",");
            System.out.println(idsList + "/" + arrIds.toString());

            String usernames = "";
            for (String id : arrIds) {
                String name = authenticationService.getUserName(id);
                usernames = usernames.concat(name + ",");
            }
            usernames = usernames.substring(0, usernames.lastIndexOf(","));
            authenticationService.insertUsernames(usernames, authentication.getId());

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }

}
