package com.nfdw.controller;

import com.nfdw.core.annotation.Log;
import com.nfdw.entity.Authentication;
import com.nfdw.entity.Blacklist;
import com.nfdw.entity.SysDepartment;
import com.nfdw.exception.MyException;
import com.nfdw.service.AuthenticationService;
import com.nfdw.service.BlacklisServic;
import com.nfdw.service.DepartmentService;
import com.nfdw.util.BeanUtil;
import com.nfdw.util.JsonUtil;
import com.nfdw.util.ReType;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/blacklis")
@Controller
public class BlacklistController {



    @Autowired
    BlacklisServic blacklisService;


    @GetMapping("/showBlacklis")
    public String showAuthentication(Model model) {

        return "/system/blacklis/blacklisList";
    }

    @ApiOperation(value = "/showBlacklisList", httpMethod = "GET", notes = "黑名单管理")
    @GetMapping(value = "showBlacklisList")
    @ResponseBody
    @RequiresPermissions("blacklisList:show")
    public ReType showRoleList(Blacklist blacklist, Model model, String page, String limit) {
        ReType show = blacklisService.show(blacklist, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }


    @GetMapping("/showAddBlacklis")
    public String showAddBlacklis(Model model) {

        return "/system/blacklis/add-blacklis";
    }
    /*添加黑名单*/
    @ApiOperation(value = "/addBlacklis", httpMethod = "POST", notes = "添加权利")
    @Log(desc = "添加权利")
    @PostMapping(value = "addBlacklis")
    @ResponseBody
    public JsonUtil addBlacklis(Blacklist blacklist) {
        if (StringUtils.isEmpty(blacklist.getUsername())) {
            JsonUtil.error("用户名称不能为空");
        }
        JsonUtil j = new JsonUtil();
        try {

            blacklisService.insertSelective(blacklist);


            //操作role-menu data
            j.setMsg("保存成功");

        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }


    /*删除黑名单*/
    @Log(desc = "删除黑名单", type = Log.LOG_TYPE.DEL)
    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除黑名单")
    @PostMapping(value = "/del")
    @ResponseBody
    @Transactional
    public JsonUtil del(String id, boolean flag) {
        JsonUtil j = new JsonUtil();

        try {
            Blacklist oldBlacklist = blacklisService.queryInfoById(id);

            System.out.println(oldBlacklist);
            blacklisService.deleteByPrimaryKey(oldBlacklist);
            j.setFlag(true);
            j.setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return j;
    }



    /**
     * 编辑黑名单
     */

    @GetMapping("/showEidtBlacklist")
    public String showEidtBlacklist(Model model, String id, boolean detail) {
        Blacklist blacklist = blacklisService.queryInfoById(id);
        model.addAttribute("blacklist",blacklist);
        model.addAttribute("detail", detail);
        return "/system/blacklis/update-blackLis";
    }

    @ApiOperation(value = "/updateBlacklist", httpMethod = "POST", notes = "更新黑名单")
    @Log(desc = "更新黑名单", type = Log.LOG_TYPE.UPDATE)
    @PostMapping(value = "updateBlacklist")
    @ResponseBody
    public JsonUtil updateBlacklist(Blacklist blacklist) {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        if (blacklist == null) {
            jsonUtil.setMsg("获取数据失败");
            return jsonUtil;
        }
        try {
            Blacklist oldBlacklist = blacklisService.selectByPrimaryKey(blacklist.getId());
            BeanUtil.copyNotNullBean(blacklist, oldBlacklist);

            blacklisService.updateByPrimaryKeySelective(oldBlacklist);
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }
}
