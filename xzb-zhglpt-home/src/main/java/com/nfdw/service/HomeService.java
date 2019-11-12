package com.nfdw.service;

import com.nfdw.entity.PageData;
import com.nfdw.pojo.EchartsBasicBean;
import com.nfdw.pojo.EchartsMapBean;
import com.nfdw.util.JsonUtil;

import java.util.List;

public interface HomeService {
    //获取待办总条数
    //int getCountTask(PageData pd);

    //待办列表
    //List<PageData> findMyworkData(PageData pd) throws Exception;

    //通知公告列表
    //List<PageData> findTzggData(PageData pd) throws Exception;

    //参阅文件列表
    //List<PageData> findCywjData(PageData pd) throws Exception;

    //工作安排列表
    //List<PageData> findGzapData(PageData pd) throws Exception;

    //发文公开列表
    //List<PageData> findFwgkData(PageData pd) throws Exception;

    //会议纪要列表
    //List<PageData> findHyjyData(PageData pd) throws Exception;

    //文件公开列表
    //List<PageData> findWjgkData(PageData pd) throws Exception;

    //每日快报列表
    //List<PageData> findMrkbData(PageData pd) throws Exception;

    //穗府信息列表
    //List<PageData> findSfxxData(PageData pd) throws Exception;

    JsonUtil getHomeResult(String userId);

}
