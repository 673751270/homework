package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.Members;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysMembersMapper extends BaseMapper<Members, String> {

    List<Members> getMemberList();


    List<ExcleInfo> getExcelList( @Param("excleInfo") ExcleInfo excleInfo);
}
