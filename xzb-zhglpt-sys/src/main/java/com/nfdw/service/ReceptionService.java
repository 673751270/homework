package com.nfdw.service;


import com.nfdw.base.service.BaseService;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.Members;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface ReceptionService extends BaseService<Members,String> {

    List<Members> getMemeberList();

    Integer export(HttpServletResponse response, ExcleInfo excleInfo);


    List<ExcleInfo> getExcelList(ExcleInfo excleInfo);
}
