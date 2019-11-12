package com.nfdw.service.impl;

import com.nfdw.dto.HomeResult;
import com.nfdw.mapper.HomeMapper;
import com.nfdw.oa.mapper.OAMapper;
import com.nfdw.util.JsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nfdw.base.dao.impl.BaseService;
import com.nfdw.service.HomeService;

@Service
public class HomeServiceImpl extends BaseService implements HomeService {
    private static final Logger LOGGER = LoggerFactory.getLogger(HomeServiceImpl.class);

    @Autowired
    HomeMapper homeMapper;

    //总条数
    /*@Override
    public int getCountTask(PageData pd) {
        int pageData = 0;
        try {
            pageData = (int) dao.findForObject("HomeMapper.getCountTask", pd);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return pageData;
    }

    //待办列表
    @Override
    public List<PageData> findMyworkData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findMyworkData", pd);
        return list;
    }

    //通知公告列表
    @Override
    public List<PageData> findTzggData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findTzggData", pd);
        return list;
    }

    //参阅文件列表
    @Override
    public List<PageData> findCywjData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findCywjData", pd);
        return list;
    }

    //工作安排列表
    @Override
    public List<PageData> findGzapData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findGzapData", pd);
        return list;
    }

    //发文公开列表
    @Override
    public List<PageData> findFwgkData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findFwgkData", pd);
        return list;
    }

    //会议纪要列表
    @Override
    public List<PageData> findHyjyData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findHyjyData", pd);
        return list;
    }

    //文件公开列表
    @Override
    public List<PageData> findWjgkData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findWjgkData", pd);
        return list;
    }

    //每日快报列表
    @Override
    public List<PageData> findMrkbData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findMrkbData", pd);
        return list;
    }

    //穗府信息列表
    @Override
    public List<PageData> findSfxxData(PageData pd) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("HomeMapper.findSfxxData", pd);
        return list;
    }*/

    @Autowired
    OAMapper oaMapper;

    @Override
    public JsonUtil getHomeResult(String userId) {
        JsonUtil jsonUtil = new JsonUtil();
        HomeResult homeResult = homeMapper.getHomeResult(userId);
        homeResult.setProcessResults(oaMapper.getProcessResult(userId));
        homeResult.setProcessesCount(oaMapper.processesCount(userId));
        if (null != homeResult) {
            jsonUtil.setData(homeResult);
        } else {
            jsonUtil.setFlag(false);
            jsonUtil.setMsg("获取首页信息失败");
        }
        return jsonUtil;
    }


}

