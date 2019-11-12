package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.Authentication;

public interface AuthenticationService extends BaseService<Authentication, String> {

    void addAuthentication(Authentication authentication);

    Authentication queryInfoById(String id);

    String getUserName(String id);

    void insertUsernames(String usernames,Integer id);
}
