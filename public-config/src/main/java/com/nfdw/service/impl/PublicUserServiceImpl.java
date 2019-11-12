package com.nfdw.service.impl;

import com.nfdw.mapper.PublicUserMapper;
import com.nfdw.service.PublicUserService;
import com.nfdw.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class PublicUserServiceImpl implements PublicUserService {

    @Autowired
    PublicUserMapper publicUserMapper;

    @Override
    public JsonUtil updateByUserName(Date lockingDate, String userName) {
        JsonUtil jsonUtil = new JsonUtil();

        try {
            publicUserMapper.updateByUserName(lockingDate, userName);
            jsonUtil.setMsg("解锁成功");
        } catch (Exception ex) {
            jsonUtil.setFlag(false);
            jsonUtil.setMsg("解锁失败");
        }
        return jsonUtil;
    }
}
