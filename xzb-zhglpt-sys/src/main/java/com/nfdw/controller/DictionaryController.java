package com.nfdw.controller;

import com.nfdw.base.service.DictionaryService;
import com.nfdw.core.annotation.Log;

import com.nfdw.entity.Dictionary;
import com.nfdw.exception.MyException;
import com.nfdw.util.BeanUtil;
import com.nfdw.util.JsonUtil;
import com.nfdw.util.ReType;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping("/dictionary")
public class DictionaryController {

    @Autowired
    DictionaryService dictionaryService;

    @GetMapping("showDictionary")
    public String showDictionary() {
        return "/system/dictionary/dictionaryList";
    }

    @ApiOperation(value = "/showDictionaryList", httpMethod = "GET", notes = "展示角色")
    @GetMapping(value = "showDictionaryList")
    @ResponseBody
    @RequiresPermissions("dictionary:show")
    public ReType showRoleList(Dictionary dictionaryt, Model model, String page, String limit) {
        ReType show = dictionaryService.show(dictionaryt, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }

    @GetMapping(value = "showAddDictionary")
    public String goAddRole(Model model) {
        return "/system/dictionary/add-dictionary";
    }

    @ApiOperation(value = "/addDictionary", httpMethod = "POST", notes = "添加字典")
    @Log(desc = "添加字典")
    @PostMapping(value = "addDictionary")
    @ResponseBody
    public JsonUtil addDepartment(Dictionary dictionary) {
        if (StringUtils.isEmpty(dictionary.getDgroup())) {
            JsonUtil.error("代码组不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getCode())) {
            JsonUtil.error("代码不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getDvalue())) {
            JsonUtil.error("代码值不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getName())) {
            JsonUtil.error("代码类型不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getSort().toString())) {
            JsonUtil.error("序列不能为空");
        }
        JsonUtil j = new JsonUtil();
        dictionary.setUpdateTime(new Date());
        try {
            dictionaryService.insertSelective(dictionary);
            //操作role-menu data
            j.setMsg("保存成功");

        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }

    @GetMapping(value = "updateDictionary")
    public String updateRole(String id, Model model, boolean detail) {
        if (StringUtils.isNotEmpty(String.valueOf(id))) {
            model.addAttribute("dictionary", dictionaryService.selectByPrimaryKey(id));
        }
        model.addAttribute("detail", detail);
        return "system/dictionary/update-dictionary";
    }

    @ApiOperation(value = "/updateDictionary", httpMethod = "POST", notes = "更新字典")
    @Log(desc = "更新字典", type = Log.LOG_TYPE.UPDATE)
    @PostMapping(value = "updateDictionary")
    @ResponseBody
    public JsonUtil updateDictionary(Dictionary dictionary) {
        if (StringUtils.isEmpty(dictionary.getDgroup())) {
            JsonUtil.error("代码组不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getCode())) {
            JsonUtil.error("代码不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getDvalue())) {
            JsonUtil.error("代码值不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getName())) {
            JsonUtil.error("代码类型不能为空");
        }
        if (StringUtils.isEmpty(dictionary.getSort().toString())) {
            JsonUtil.error("序列不能为空");
        }
        JsonUtil jsonUtil = new JsonUtil();
        dictionary.setUpdateTime(new Date());
        try {
            Dictionary oldDictionary = dictionaryService.selectByPrimaryKey(dictionary.getId());
            BeanUtil.copyNotNullBean(dictionary, oldDictionary);
            dictionaryService.updateByPrimaryKeySelective(oldDictionary);
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }

    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除字典")
    @Log(desc = "删除字典", type = Log.LOG_TYPE.DEL)
    @PostMapping(value = "del")
    @ResponseBody
    @RequiresPermissions("dictionary:del")
    public JsonUtil del(String id) {
        if (StringUtils.isEmpty(id)) {
            return JsonUtil.error("获取数据失败");
        }

        JsonUtil j = new JsonUtil();
        try {

            dictionaryService.deleteByPrimaryKey(id);
            j.setMsg("删除成功");
        } catch (MyException e) {
            j.setMsg("删除失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }
}
