package com.nfdw.oa.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.dto.ProcessResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OAMapper{

    List<ProcessResult> getProcessResult(@Param("nowAssign")String userId);

    int processesCount(@Param("nowAssign")String userId);
}
