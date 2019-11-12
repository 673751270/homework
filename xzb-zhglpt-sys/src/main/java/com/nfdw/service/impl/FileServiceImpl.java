package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.File;
import com.nfdw.mapper.FileMapper;
import com.nfdw.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileServiceImpl extends BaseServiceImpl<File,String> implements FileService {

	@Autowired
	FileMapper fileMapper;
	
	@Override
	public BaseMapper<File, String> getMappser() {
		return fileMapper;
	}


}
