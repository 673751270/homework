package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.SysRole;

import java.util.List;

/**

 */
public interface RoleService extends BaseService<SysRole,String> {


  int deleteByPrimaryKey(String id);

  @Override
  int insert(SysRole record);

  @Override
  int insertSelective(SysRole record);


  SysRole selectByPrimaryKey(String id);

  @Override
  int updateByPrimaryKeySelective(SysRole record);

  @Override
  int updateByPrimaryKey(SysRole record);

  @Override
  List<SysRole> selectListByPage(SysRole sysRole);
}
