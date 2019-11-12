package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.CurrentUser;
import com.nfdw.entity.SysRole;
import com.nfdw.entity.SysRoleUser;
import com.nfdw.entity.SysUser;
import com.nfdw.exception.MyException;
import com.nfdw.mapper.SysRoleUserMapper;
import com.nfdw.mapper.SysUserMapper;
import com.nfdw.service.RoleService;
import com.nfdw.service.RoleUserService;
import com.nfdw.service.SysUserService;
import com.nfdw.util.Checkbox;
import com.nfdw.util.JsonUtil;
import com.nfdw.util.Md5Util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 */
@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUser, String> implements SysUserService {

    @Autowired
    SysUserMapper sysUserMapper;

    @Autowired
    SysRoleUserMapper sysRoleUserMapper;

    @Autowired
    RoleService roleService;

    @Autowired
    RoleUserService roleUserService;

    @Override
    public BaseMapper<SysUser, String> getMappser() {
        return sysUserMapper;
    }


    @Override
    public SysUser login(String username) {
        return sysUserMapper.login(username);
    }


    @Override
    public int deleteByPrimaryKey(String id) {
        return sysUserMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(SysUser record) {
        return sysUserMapper.insert(record);
    }

    @Override
    public int insertSelective(SysUser record) {

        String pwd = Md5Util.getMD5(record.getPassword().trim(), record.getUsername().trim());
        record.setPassword(pwd);
        return super.insertSelective(record);
    }

    @Override
    public SysUser selectByPrimaryKey(String id) {
        return sysUserMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(SysUser record) {
        return super.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(SysUser record) {
        return sysUserMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<SysRoleUser> selectByCondition(SysRoleUser sysRoleUser) {
        return sysRoleUserMapper.selectByCondition(sysRoleUser);
    }

    /**
     * 分页查询
     *
     * @param
     * @return
     */
    @Override
    public List<SysUser> selectListByPage(SysUser sysUser) {
        return sysUserMapper.selectListByPage(sysUser);
    }

    @Override
    public int count() {
        return sysUserMapper.count();
    }

    @Override
    public int add(SysUser user) {
        //密码加密
        String pwd = Md5Util.getMD5(user.getPassword().trim(), user.getUsername().trim());
        user.setPassword(pwd);
        return sysUserMapper.add(user);
    }

    @Override
    public JsonUtil delById(String id, boolean flag) {
        if (StringUtils.isEmpty(id)) {
            return JsonUtil.error("获取数据失败");
        }
        JsonUtil j = new JsonUtil();
        try {
            SysUser sysUser = selectByPrimaryKey(id);
            if (!flag) {
                //逻辑
                sysUser.setDelFlag(Byte.parseByte("1"));
                updateByPrimaryKeySelective(sysUser);
            } else {
				/*if ("admin".equals(sysUser.getUsername())) {
					return JsonUtil.error("超管无法删除");
				}*/
                SysRoleUser roleUser = new SysRoleUser();
                roleUser.setUserId(id);
                j.setData(roleUserService.select(roleUser));
                roleUserService.delete(roleUser);
				/*int count = roleUserService.selectCountByCondition(roleUser);
				if (count > 0) {
					return JsonUtil.error("账户已经绑定角色，无法删除");
				}*/
                //物理
                //sysUserMapper.delById(id);
            }
            j.setMsg("删除成功");
        } catch (MyException e) {
            j.setMsg("删除失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;


    }

    @Override
    public int checkUser(String username) {
        return sysUserMapper.checkUser(username);
    }

    @Override
    public List<Checkbox> getUserRoleByJson(String id) {
        List<SysRole> roleList = roleService.selectListByPage(new SysRole());
        SysRoleUser sysRoleUser = new SysRoleUser();
        sysRoleUser.setUserId(id);
        List<SysRoleUser> kList = selectByCondition(sysRoleUser);
        System.out.println(kList.size());
        List<Checkbox> checkboxList = new ArrayList<>();
        Checkbox checkbox = null;
        for (SysRole sysRole : roleList) {
            checkbox = new Checkbox();
            checkbox.setId(sysRole.getId());
            checkbox.setName(sysRole.getRoleName());
            for (SysRoleUser sysRoleUser1 : kList) {
                if (sysRoleUser1.getRoleId().equals(sysRole.getId())) {
                    checkbox.setCheck(true);
                }
            }
            checkboxList.add(checkbox);
        }
        return checkboxList;
    }

    @Override
    public int rePass(SysUser user) {
        return sysUserMapper.rePass(user);
    }

    /**
     * 重置密码
     */
    @Override
    public JsonUtil rePass(String id) {
        JsonUtil jsonUtil = new JsonUtil();
        try {
            SysUser user = selectByPrimaryKey(id);
            if (null == user) {
                jsonUtil.setFlag(false);
                jsonUtil.setMsg("该用户不存在!");
                return jsonUtil;
            }
            String newPwd = Md5Util.getMD5("xzb123456.".trim(), user.getUsername().trim());
            if (newPwd.equals(user.getPassword())) {
                jsonUtil.setFlag(true);
                jsonUtil.setMsg("重置密码成功");
                return jsonUtil;
            }
            user.setPassword(newPwd);
            sysUserMapper.whileUpdateUser(user);
            jsonUtil.setFlag(true);
            jsonUtil.setMsg("重置密码成功");
        } catch (Exception e) {
            jsonUtil.setFlag(false);
            jsonUtil.setMsg("重置密码失败");
            e.printStackTrace();
        }
        return jsonUtil;
    }

    @Override
    public List<SysUser> getUserByRoleId(String roleId, int page, int limit) {
        Map map = new HashMap<>();
        map.put("roleId", roleId);
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);
        return sysUserMapper.getUserByRoleId(map);
    }

    @Override
    public int countUserByRoleId(String roleId, int page, int limit) {
        Map map = new HashMap<>();
        map.put("roleId", roleId);
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);
        return sysUserMapper.countUserByRoleId(map);
    }

    @Override
    public List<SysUser> findBydepartmentId(Integer departmentId) {

        return sysUserMapper.findBydepartmentId(departmentId);


    }

    @Override
    public void updateByIdStatus(String id, int status) {
        int count=sysUserMapper.updateStatus(id, status);
        if(count>0) {
            try {
                throw new Exception("修改状态失败");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    @Override
    public CurrentUser selectUser(String username) {
        CurrentUser  user =sysUserMapper.selectUser(username);
        return user;
    }

    @Override
    public int whileAddUser(SysUser sysUser) {
        String pwd = Md5Util.getMD5(sysUser.getPassword().trim(), sysUser.getUsername().trim());
        sysUser.setPassword(pwd);
        return sysUserMapper.whileAddUser(sysUser);
    }

    @Override
    public int whileUpdateUser(SysUser user) {
        return sysUserMapper.whileUpdateUser(user);
    }

    @Override
    public int onLine() {
        return sysUserMapper.onLine();
    }
}
