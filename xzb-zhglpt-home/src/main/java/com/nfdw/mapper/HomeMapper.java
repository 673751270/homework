package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.dto.HomeResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface HomeMapper {

    HomeResult getHomeResult(@Param("nowAssign") String userId);
}
