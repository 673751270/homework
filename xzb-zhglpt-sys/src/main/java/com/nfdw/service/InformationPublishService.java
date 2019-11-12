package com.nfdw.service;

import com.nfdw.base.service.BaseService;
import com.nfdw.entity.InformationPublish;

import java.util.List;

/**
信息发布
 */
public interface InformationPublishService extends BaseService<InformationPublish,String> {
	  /**
	   * 分页查询
	   * @param
	   * @return
	   */
	  @Override
	  List<InformationPublish> selectListByPage(InformationPublish informationpublish);

	  /**
	   * 新增

	   */
	  int add(InformationPublish informationpublish);

	  /**
	   * 删除
	   * @param id
	   * @return
	   */
	  int delById(String id, boolean flag);
	  /**
	   * 更新

	   */
	  int update(InformationPublish informationpublish);

	InformationPublish queryInfoById(String id);
}
