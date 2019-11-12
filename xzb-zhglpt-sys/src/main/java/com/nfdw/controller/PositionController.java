package com.nfdw.controller;


import com.nfdw.base.controller.BaseController;
import com.nfdw.core.annotation.Log;
import com.nfdw.core.annotation.Log.LOG_TYPE;
import com.nfdw.entity.CurrentUser;
import com.nfdw.entity.SysPosition;
import com.nfdw.entity.SysUser;
import com.nfdw.exception.MyException;
import com.nfdw.service.PositionService;
import com.nfdw.service.SysUserService;
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

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@RequestMapping("/position")
@Controller
public class PositionController extends BaseController {

    @Autowired
    private PositionService positionService;

    @Autowired
    private SysUserService userService;

    /**
     * 2019/1/3
     * 职务列表
     */

    @GetMapping("/showPosition")
    public String showPosition(Model model) {
        
        return "/system/position/positionList";
    }

    @ApiOperation(value = "/showPositionList", httpMethod = "GET", notes = "展示职务")
    @GetMapping(value = "showPositionList")
    @ResponseBody
    @RequiresPermissions("position:show")
    public ReType showRoleList(SysPosition position, Model model, String page, String limit) {
        ReType show = positionService.show(position, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }

    @GetMapping(value = "showAddPosition")
    public String goAddRole(Model model) {
//        JSONArray jsonArray =positionService.getTreeUtil(null);
//        String s = jsonArray.toString();
//        model.addAttribute("menus", jsonArray.toJSONString());
        return "/system/position/add-position";
    }


    @ApiOperation(value = "/addPosition", httpMethod = "POST", notes = "添加部门")
    @Log(desc = "添加职务")
    @PostMapping(value = "addPosition")
    @ResponseBody
    public JsonUtil addPosition(SysPosition sysPosition,HttpServletRequest request) {
            if (StringUtils.isEmpty(sysPosition.getPositionName())) {
            JsonUtil.error("职务名称不能为空");
        }
        JsonUtil j = new JsonUtil();
        CurrentUser user= (CurrentUser) request.getSession().getAttribute("currentUse");
        try {
        	sysPosition.setCreateTime(new Date());
        	sysPosition.setCreater(user.getRealName());
            positionService.insertSelective(sysPosition);
            //操作role-menu data
            j.setMsg("保存成功");

        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }


    /**
     * 2019/1/9
     * 部门删除，联合查询用户表
     **/
    @PostMapping(value = "del")
    @ResponseBody
    public JsonUtil del(Integer id) {
        if (id == null) {
            return JsonUtil.error("获取数据失败");
        }
        JsonUtil j = new JsonUtil();
        try {
            positionService.deleteByPrimaryKey(id);
            j.setMsg("删除成功");
        } catch (MyException e) {
            j.setMsg("删除失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }

    @GetMapping(value = "updatePosition")
    public String updateRole(Integer id, Model model, boolean detail) {
        if (StringUtils.isNotEmpty(String.valueOf(id))) {
            SysPosition position = positionService.selectByPrimaryKey(id);
            model.addAttribute("position", position);
//            JSONArray jsonArray = menuService.getTreeUtil(id);
//            model.addAttribute("menus", jsonArray.toJSONString());
        }
        model.addAttribute("detail", detail);
        return "system/position/update-position";
    }


    @ApiOperation(value = "/updatePosition", httpMethod = "POST", notes = "更新职务")
    @Log(desc = "更新职务", type = LOG_TYPE.UPDATE)
    @PostMapping(value = "updatePosition")
    @ResponseBody
    public JsonUtil updatePosition(SysPosition position, HttpServletRequest request) {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        if (position == null) {
            jsonUtil.setMsg("获取数据失败");
            return jsonUtil;
        }
        //SysUser user= (SysUser) request.getSession().getAttribute("user");
        try {
            //position.setCreater(user.getRealName());
            SysPosition oldPosition = positionService.selectByPrimaryKey(position.getId());
            BeanUtil.copyNotNullBean(position, oldPosition);
            positionService.updateByPrimaryKeySelective(oldPosition);
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }

    /**
     * 验证职务是否存在
     */
    @GetMapping(value = "checkPosition")
    @ResponseBody
    public JsonUtil checkPosition(String positionname, HttpServletRequest req) {
        JsonUtil j = new JsonUtil();
        j.setFlag(Boolean.FALSE);
        if (StringUtils.isEmpty(positionname)) {
            j.setMsg("获取数据失败");
            return j;
        }
        int result = positionService.checkPosition(positionname);
        if (result > 0) {
            j.setMsg("职务已存在");
            return j;
        }
        j.setFlag(true);
        return j;

    }
    
    /**
     * 获取职务列表
     * @param position
     * @param role
     * @return
     */
    @ApiOperation(value = "/showPositionAllList", httpMethod = "GET", notes = "获取职务列表")
    @Log(desc = "获取职务列表", type = LOG_TYPE.UPDATE)
    @GetMapping(value = "showPositionAllList")
    @ResponseBody
    public JsonUtil showPositionAllList() {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        
        try {
        	List<SysPosition> positions = positionService.showMenuJsonList();
            
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("查询职务 列表成功");
            jsonUtil.setData(positions);
        } catch (MyException e) {
            e.printStackTrace();
        }
        
        return jsonUtil;
    }

}
