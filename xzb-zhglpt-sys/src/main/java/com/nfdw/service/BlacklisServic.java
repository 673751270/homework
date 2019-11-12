package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.Authentication;
import com.nfdw.entity.Blacklist;

public interface BlacklisServic extends BaseService<Blacklist, String> {
    Blacklist queryInfoById(String id);
}
