package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.SysRoleUser;

import java.util.List;

public interface SysRoleUserMapper extends BaseMapper<SysRoleUser,String> {

    List<SysRoleUser> selectByCondition(SysRoleUser sysRoleUser);

    int selectCountByCondition(SysRoleUser sysRoleUser);
}