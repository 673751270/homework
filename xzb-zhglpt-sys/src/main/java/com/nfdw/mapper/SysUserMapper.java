package com.nfdw.mapper;

import com.nfdw.entity.CurrentUser;
import com.nfdw.entity.SysUser;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysUserMapper extends com.nfdw.base.BaseMapper<SysUser, String> {

    SysUser login(@Param("username") String username);

    int count();

    int add(SysUser user);

    int delById(String id);

    int checkUser(String username);

    /**
     * 更新密码
     *
     * @param user
     * @return
     */
    int rePass(SysUser user);

    List<SysUser> getUserByRoleId(Map map);

    int countUserByRoleId(Map map);

    List<SysUser> findBydepartmentId(Integer departmentName);

    @Insert("call while_insert_user(#{id},#{username},#{password},#{age},#{email},#{photo},#{realName}" +
            ",#{departmentId},#{positionId},#{createBy},#{updateBy},#{createDate}" +
            ",#{updateDate},#{sort})")
    int whileAddUser(SysUser sysUser);

    @Insert("call while_update_user(#{id},#{username},#{password},#{age},#{email},#{photo},#{realName}" +
            ",#{departmentId},#{positionId},#{createBy},#{updateBy},#{createDate}" +
            ",#{updateDate},#{delFlag},#{status},#{sort})")
    int whileUpdateUser(SysUser user);

    int onLine();

    /**
     * 修改状态
     *
     * @param id
     * @param status
     * @return
     */

    int updateStatus(@Param("id") String id, @Param("status") int status);

    List<SysUser> queryUserByRoleIdAndDepartmentId(@Param("roleId") String roleId, @Param("departmentId") Integer departmentId);

    CurrentUser selectUser(String username);
}