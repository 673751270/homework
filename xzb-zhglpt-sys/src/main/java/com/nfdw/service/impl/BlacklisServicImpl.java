package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.Blacklist;
import com.nfdw.mapper.BlacklisMapper;
import com.nfdw.service.BlacklisServic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlacklisServicImpl extends BaseServiceImpl<Blacklist, String> implements BlacklisServic {
    @Autowired
    BlacklisMapper blacklisMapper;
    @Override
    public BaseMapper<Blacklist, String> getMappser() {
      return   blacklisMapper ;
    }

    @Override
    public Blacklist queryInfoById(String id) {

        return blacklisMapper.queryInfoById(id);
    }
}
