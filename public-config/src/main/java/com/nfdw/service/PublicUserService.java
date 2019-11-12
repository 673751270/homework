package com.nfdw.service;

import com.nfdw.util.JsonUtil;

import java.util.Date;

public interface PublicUserService {
    JsonUtil updateByUserName(Date lockingDate,String userName);
}
