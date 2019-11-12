package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.SysPosition;

import java.util.List;

public interface PositionService extends BaseService<SysPosition,String> {


	List<SysPosition> showMenuJsonList();

//    JSONArray getTreeUtil(String PositionId);
     @Override
     int insertSelective(SysPosition record);

     int checkPosition(String positionname);
}
