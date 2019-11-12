package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.SysDepartment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ToExcleMapper extends BaseMapper<ExcleInfo,String> {

    List<Map<String, Object>> getExcelList(@Param("excleInfo") ExcleInfo excleInfo);
}
