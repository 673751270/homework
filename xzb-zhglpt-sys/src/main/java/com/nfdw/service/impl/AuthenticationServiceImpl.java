package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.Authentication;
import com.nfdw.mapper.AuthenticationMapper;
import com.nfdw.service.AuthenticationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationServiceImpl extends BaseServiceImpl<Authentication, String> implements AuthenticationService {

    @Autowired
    AuthenticationMapper authenticationMapper;
    @Override
    public BaseMapper<Authentication, String> getMappser() {
        return authenticationMapper;
    }

    @Override
    public void addAuthentication(Authentication authentication) {
        authenticationMapper.addAuthentication(authentication);
    }

    @Override
    public Authentication queryInfoById(String id) {
        return authenticationMapper.queryInfoById(id);
    }

    @Override
    public String getUserName(String id) {

        return authenticationMapper.getUserName(id);
    }

    @Override
    public void insertUsernames(String usernames,Integer id) {
        authenticationMapper.insertUsernames(usernames,id);
    }
}
