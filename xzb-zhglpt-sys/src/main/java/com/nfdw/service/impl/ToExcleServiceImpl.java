package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.mapper.ToExcleMapper;
import com.nfdw.service.ToExcleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ToExcleServiceImpl extends BaseServiceImpl<ExcleInfo,String> implements ToExcleService {
    @Autowired
    ToExcleMapper toExcleMapper;
    @Override
    public BaseMapper<ExcleInfo, String> getMappser() {
        return toExcleMapper;
    }

    @Override
    public List<Map<String, Object>> getExcelList(ExcleInfo excleInfo) {

        List<Map<String, Object>> ls = toExcleMapper.getExcelList(excleInfo);
        return null;
    }
}
