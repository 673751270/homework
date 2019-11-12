package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.SysUser;
import com.nfdw.mapper.BlackListMapper;
import com.nfdw.service.BlackListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlackListServiceImpl extends BaseServiceImpl<SysUser, String> implements BlackListService {
    @Autowired
    BlackListMapper blackListMapper;

    @Override
    public BaseMapper<SysUser, String> getMappser() {
        return blackListMapper;
    }
}
