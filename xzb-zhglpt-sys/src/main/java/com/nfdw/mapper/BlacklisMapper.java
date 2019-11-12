package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.Authentication;
import com.nfdw.entity.Blacklist;

public interface BlacklisMapper extends BaseMapper<Blacklist,String> {
    Blacklist queryInfoById(String id);
}
