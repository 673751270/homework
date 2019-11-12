package com.nfdw.section.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
//import com.nfdw.base.impl.BaseServiceImpl;
import com.nfdw.section.entity.DepartmentApply;
import com.nfdw.section.mapper.DepartmentApplyMapper;
import com.nfdw.section.service.DepartmentAppayService;
@Service
public class DepartmentAppayServiceImpl extends BaseServiceImpl<DepartmentApply,String>  implements DepartmentAppayService {

	 @Autowired
	 DepartmentApplyMapper departmentApplyMapper;
	 
	@Override
	public BaseMapper<DepartmentApply, String> getMappser() {
		// TODO Auto-generated method stub
		return departmentApplyMapper;
	}


}
