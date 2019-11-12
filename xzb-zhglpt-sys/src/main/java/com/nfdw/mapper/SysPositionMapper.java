package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.SysPosition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysPositionMapper extends BaseMapper<SysPosition,String> {
    /**获取元节点*/
    List<SysPosition> getMenuNotSuper();

    /**
     * 获取子节点
     * @return
     */
    List<SysPosition> getMenuChildren(String id);

    List<SysPosition> getMenuChildrenAll(String id);

    List<SysPosition> getUserMenu(@Param("id") String id, @Param("defaultUrl") String defaultUrl);
    List<SysPosition> getMenuJsonList();


    int checkPosition(String positionname);
}
