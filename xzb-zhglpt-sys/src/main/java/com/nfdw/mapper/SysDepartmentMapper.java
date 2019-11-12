package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.SysDepartment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysDepartmentMapper extends BaseMapper<SysDepartment,String> {
    /**获取元节点*/
    List<SysDepartment> getMenuNotSuper();

    /**
     * 获取子节点
     * @return
     */
    List<SysDepartment> getMenuChildren(String id);

    List<SysDepartment> getMenuChildrenAll(String id);

    List<SysDepartment> getUserMenu(@Param("id") String id, @Param("defaultUrl") String defaultUrl);
    List<SysDepartment> getMenuJsonList();


    int checkDepartment(String departmentname);

    List<SysDepartment> queryAll();
}
