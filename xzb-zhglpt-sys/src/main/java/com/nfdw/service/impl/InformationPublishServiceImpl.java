package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.InformationPublish;
import com.nfdw.mapper.InformationPublishMapper;
import com.nfdw.service.InformationPublishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 */
@Service
public class InformationPublishServiceImpl extends BaseServiceImpl<InformationPublish,String> implements InformationPublishService {

  @Autowired
  private InformationPublishMapper informationpublishMapper;

  @Override
  public BaseMapper<InformationPublish, String> getMappser() {
    return informationpublishMapper;
  }

@Override
public int add(InformationPublish informationpublish) {
	return informationpublishMapper.insert(informationpublish);
}

@Override
public int delById(String id, boolean flag) {
	 return informationpublishMapper.deleteByPrimaryKey(id);
}

@Override
public int update(InformationPublish informationpublish) {
	// TODO Auto-generated method stub
	return informationpublishMapper.updateByPrimaryKey(informationpublish);
}

    @Override
    public InformationPublish queryInfoById(String id) {
        return informationpublishMapper.queryInfoById(id);
    }


}
