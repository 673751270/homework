package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.SysRoleMenu;

import java.util.List;

/**

 */
public interface RoleMenuService extends BaseService<SysRoleMenu,String> {

    List<SysRoleMenu> selectByCondition(SysRoleMenu sysRoleMenu);

    int  selectCountByCondition(SysRoleMenu sysRoleMenu);

    int deleteByPrimaryKey(SysRoleMenu sysRoleMenu);

    int insertRoleAndMenu(SysRoleMenu sysRoleMenu);
}
