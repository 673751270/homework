package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.SysRoleUser;

import java.util.List;

/**

 */
public interface RoleUserService  extends BaseService<SysRoleUser,String> {

  int deleteByPrimaryKey(SysRoleUser sysRoleUser);

  int insert(SysRoleUser sysRoleUser);

  int selectCountByCondition(SysRoleUser sysRoleUser);

  List<SysRoleUser> selectByCondition(SysRoleUser sysRoleUser);

   String findRoleIdByUserId(String userId);
}
