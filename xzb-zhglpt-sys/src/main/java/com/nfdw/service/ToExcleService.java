package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.Members;

import java.util.List;
import java.util.Map;

public interface ToExcleService extends BaseService<ExcleInfo,String> {

    List<Map<String, Object>> getExcelList(ExcleInfo excleInfo);
}
