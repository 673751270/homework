package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.InformationPublish;
import org.apache.ibatis.annotations.Param;


public interface InformationPublishMapper extends BaseMapper<InformationPublish,String> {
    InformationPublish queryInfoById(@Param("id") String id);
}