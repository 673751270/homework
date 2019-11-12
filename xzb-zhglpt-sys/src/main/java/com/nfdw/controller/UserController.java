package com.nfdw.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.nfdw.base.controller.BaseController;
import com.nfdw.core.annotation.Log;
import com.nfdw.core.annotation.Log.LOG_TYPE;
import com.nfdw.core.quartz.JobTask;
import com.nfdw.core.shiro.RetryLimitCredentialsMatcher;
import com.nfdw.core.shiro.ShiroUtil;
import com.nfdw.entity.SysDepartment;
import com.nfdw.entity.SysPosition;
import com.nfdw.entity.SysRoleUser;
import com.nfdw.entity.SysUser;
import com.nfdw.exception.MyException;
import com.nfdw.service.*;
import com.nfdw.util.*;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.UUID;

/**
 * 用户管理
 */
//@Api(value="user")
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

    //private static final Logger

    @Autowired
    SysUserService userService;

    @Autowired
    RoleUserService roleUserService;

    @Autowired
    JobTask task;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    PositionService positionService;

    @GetMapping(value = "mainTest")
    @RequiresPermissions("user:show")
    public String showTest() {
        return "system/user/mainTest";
    }

    @GetMapping(value = "showUser")
    @RequiresPermissions("user:show")
    public String showUser(Model model) {
        return "/system/user/userList";
    }

    @GetMapping(value = "showUserList")
    @ResponseBody
    @RequiresPermissions("user:show")
    public ReType showUser(Model model, SysUser user, String page, String limit) {
        return userService.show(user, Integer.valueOf(page), Integer.valueOf(limit));
    }

    @ApiOperation(value = "/listByRoleId", httpMethod = "GET", notes = "展示角色")
    @GetMapping(value = "listByRoleId")
    @ResponseBody
    @RequiresPermissions("user:show")
    public String showUser(Model model, String roleId, int page, int limit) {
        JSONObject returnValue = new JSONObject();
        List<SysUser> users = userService.getUserByRoleId(roleId, page, limit);
        int counts = userService.countUserByRoleId(roleId, page, limit);
        returnValue.put("users", users);
        returnValue.put("totals", counts);
        return JSON.toJSONString(returnValue);
    }


    @GetMapping(value = "showAddUser")
    public String goAddUser(Model model) {
        List<Checkbox> checkboxList = userService.getUserRoleByJson(null);
        model.addAttribute("boxJson", checkboxList);

        List<SysDepartment> departmentList = departmentService.showMenuJsonList();
        model.addAttribute("departmentList", departmentList);

        List<SysPosition> positions = positionService.showMenuJsonList();
        model.addAttribute("positions", positions);
        return "/system/user/add-user";
    }

    @ApiOperation(value = "/addUser", httpMethod = "POST", notes = "添加用户")
    @Log(desc = "添加用户")
    @PostMapping(value = "addUser")
    @ResponseBody
    public JsonUtil addUser(SysUser user, String[] role, HttpServletRequest request) {
        if (user == null) {
            return JsonUtil.error("获取数据失败");
        }
        if (StringUtils.isBlank(user.getUsername())) {
            return JsonUtil.error("用户名不能为空");
        }
        if (StringUtils.isBlank(user.getPassword())) {
            return JsonUtil.error("密码不能为空");
        }
        if (null == user.getDepartmentId()) {
            return JsonUtil.error("所属部门不能为空");
        }
        if (role == null) {
            return JsonUtil.error("请选择角色");
        }
        int result = userService.checkUser(user.getUsername());
        if (result > 0) {
            return JsonUtil.error("用户名已存在");
        }
        JsonUtil j = new JsonUtil();
        try {
            user.setId(UUID.randomUUID().toString().replaceAll("\\-", ""));
            user.setPhoto("".equals(user.getPhoto()) ? null : user.getPhoto());
            if (StringUtils.isNotEmpty(user.getPhoto())) {
                user.setPhoto(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/images/" + user.getPhoto());
            }

            userService.whileAddUser(user);
            SysRoleUser sysRoleUser = new SysRoleUser();
            sysRoleUser.setUserId(user.getId());
            for (String r : role) {
                sysRoleUser.setRoleId(r);
                roleUserService.insertSelective(sysRoleUser);
            }
            j.setMsg("保存成功");
        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }

    @GetMapping(value = "updateUser")
    public String goUpdateUser(String id, Model model, boolean detail) {
        if (StringUtils.isNotEmpty(id)) {
            //用户-角色
            List<Checkbox> checkboxList = userService.getUserRoleByJson(id);
            SysUser user = userService.selectByPrimaryKey(id);
            model.addAttribute("u", user);
            model.addAttribute("boxJson", checkboxList);

            List<SysDepartment> departmentList = departmentService.showMenuJsonList();
            model.addAttribute("departmentList", departmentList);

        }
        model.addAttribute("detail", detail);
        List<SysPosition> positions = positionService.showMenuJsonList();
        model.addAttribute("positions", positions);
        return "system/user/update-user";
    }

    @ApiOperation(value = "/updateUser", httpMethod = "POST", notes = "更新用户")
    @Log(desc = "更新用户", type = LOG_TYPE.UPDATE)
    @PostMapping(value = "updateUser")
    @ResponseBody
    @Transactional
    public JsonUtil updateUser(SysUser user, String role[], HttpServletRequest request) {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        if (user == null) {
            jsonUtil.setMsg("获取数据失败");
            return jsonUtil;
        }
        try {
            if (StringUtils.isNotEmpty(user.getPhoto())) {
                user.setPhoto(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/images/" + user.getPhoto());
                //user.setPhoto(":" + request.getServerPort() + request.getContextPath() + "/images/" + user.getPhoto());
            }
            SysUser oldUser = userService.selectByPrimaryKey(user.getId());
            BeanUtil.copyNotNullBean(user, oldUser);
            userService.whileUpdateUser(oldUser);
            if (role != null) {
                SysRoleUser sysRoleUser = new SysRoleUser();
                sysRoleUser.setUserId(oldUser.getId());
                List<SysRoleUser> keyList = userService.selectByCondition(sysRoleUser);
                for (SysRoleUser sysRoleUser1 : keyList) {
                    roleUserService.deleteByPrimaryKey(sysRoleUser1);
                }
                for (String r : role) {
                    sysRoleUser.setRoleId(r);
                    roleUserService.insert(sysRoleUser);
                }
            }
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
            //throw  new MyException("错误");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }

    @Log(desc = "删除用户", type = LOG_TYPE.DEL)
    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除用户")
    @PostMapping(value = "/del")
    @ResponseBody
    @RequiresPermissions("user:del")
    public JsonUtil del(SysUser user) {
        JsonUtil jsonUtil = new JsonUtil();
        SysUser oldUser = userService.selectByPrimaryKey(user.getId());
        oldUser.setDelFlag(1);
        userService.whileUpdateUser(oldUser);
        jsonUtil.setMsg("删除成功");
        return jsonUtil;
    }

    @GetMapping(value = "goRePass")
    public String goRePass(String id, Model model) {
        if (StringUtils.isEmpty(id)) {
            return "获取账户信息失败";
        }
        SysUser user = userService.selectByPrimaryKey(id);
//        model.addAttribute("user", user);
        return "/system/user/re-pass";
    }

    @Log(desc = "重置密码", type = LOG_TYPE.UPDATE)
    @GetMapping(value = "resetPassword")
    @ResponseBody
    @RequiresPermissions("user:repass")
    public JsonUtil resetPassword(String id) {
        return userService.rePass(id);
    }


    /**
     * 修改密码
     *
     * @param id
     * @param pass
     * @param newPwd
     * @return
     */
    @Log(desc = "修改密码", type = LOG_TYPE.UPDATE)
    @PostMapping(value = "rePass")
    @ResponseBody
    @RequiresPermissions("user:repass")
    public JsonUtil rePass(String id, String pass, String newPwd) {
        boolean flag = StringUtils.isEmpty(id) || StringUtils.isEmpty(pass) || StringUtils.isEmpty(newPwd);
        //boolean flag = StringUtils.isEmpty(pass) || StringUtils.isEmpty(newPwd);
        JsonUtil j = new JsonUtil();
        j.setFlag(false);
        if (flag) {
            j.setMsg("获取数据失败，修改失败");
            return j;
        }
        SysUser user = userService.selectByPrimaryKey(id);
        newPwd = Md5Util.getMD5(newPwd, user.getUsername());
        pass = Md5Util.getMD5(pass, user.getUsername());
        if (!user.getPassword().equals(pass)) {
            j.setMsg("密码不正确");
            return j;
        }
        if (newPwd.equals(user.getPassword())) {
            j.setMsg("新密码不能与旧密码相同");

            return j;
        }
        user.setPassword(newPwd);
        try {
            userService.whileUpdateUser(user);
            j.setMsg("修改成功");
            j.setFlag(true);
        } catch (MyException e) {
            e.printStackTrace();
        }
        return j;
    }

    @Autowired
    UploadUtil uploadUtil;

    /**
     * 头像上传 目前首先相对路径
     */
    @PostMapping(value = "upload")
    @ResponseBody
    public JsonUtil imgUpload(HttpServletRequest req, @RequestParam("file") MultipartFile file,
                              ModelMap model) {
        String fileName = uploadUtil.upload(file);
        JsonUtil j = new JsonUtil();
        j.setMsg(fileName);
        return j;
    }

    /**
     * 验证用户名是否存在
     */
    @GetMapping(value = "checkUser")
    @ResponseBody
    public JsonUtil checkUser(String uname, HttpServletRequest req) {
        JsonUtil j = new JsonUtil();
        j.setFlag(Boolean.FALSE);
        if (StringUtils.isEmpty(uname)) {
            j.setMsg("获取数据失败");
            return j;
        }
        int result = userService.checkUser(uname);
        if (result > 0) {
            j.setMsg("用户名已存在");
            return j;
        }
        j.setFlag(true);
        return j;

    }

    @Autowired
    BlackListService blackListService;

    @GetMapping("showBlack")
    public String showBlackList(Model model) {
        return "/system/user/blackList";
    }

    @GetMapping(value = "showBlackList")
    @ResponseBody
    @RequiresPermissions("blackList:show")
    public ReType showBlackList(Model model, SysUser user, String page, String limit) {
        return blackListService.show(user, Integer.valueOf(page), Integer.valueOf(limit));
    }

    @Autowired
    @Qualifier("getRetryLimitCredentialsMatcher")
    RetryLimitCredentialsMatcher retryLimitCredentialsMatcher;

    @Autowired
    PublicUserService publicUserService;

    @PostMapping(value = "/unlock")
    @ResponseBody
    @RequiresPermissions("blackList:show")
    public JsonUtil unlock(SysUser user) {
        retryLimitCredentialsMatcher.getLoginRetryCache().remove(user.getUsername());
        user.setLockingDate(null);
        return publicUserService.updateByUserName(user.getLockingDate(), user.getUsername());
    }


}
