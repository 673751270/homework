package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.SysRoleMenu;

import java.util.List;

public interface SysRoleMenuMapper extends BaseMapper<SysRoleMenu, String> {
    List<SysRoleMenu> selectByCondition(SysRoleMenu sysRoleMenu);

    int selectCountByCondition(SysRoleMenu sysRoleMenu);
}