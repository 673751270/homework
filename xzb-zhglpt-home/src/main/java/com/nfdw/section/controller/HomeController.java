package com.nfdw.section.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.nfdw.dto.CallBack;
import com.nfdw.entity.SysUser;
import com.nfdw.util.VerificationUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.nfdw.base.controller.BaseController;
import com.nfdw.entity.CurrentUser;
import com.nfdw.service.HomeService;

import com.nfdw.util.JsonUtil;

import java.io.IOException;

/**
 * 首页管理
 */
//@Api(value="user")
@Controller
@RequestMapping(value = "/home")
public class HomeController extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(HomeController.class);
    //private static final Logger
    @Resource
    private HomeService homeService;


    @Resource
    private CallBack callBack;

    @RequestMapping(value = "showHomeModel")
    public String showHome(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        CurrentUser user = (CurrentUser) request.getSession().getAttribute("curentUser");
        model.addAttribute("result", homeService.getHomeResult(user.getId()));
        return "/home/newHomeShow";
    }

    //总待办数
    @RequestMapping(value = "/getCountTask")
    public void getCountTask(HttpServletResponse response, HttpServletRequest request) throws Exception {


        //PageData pd = this.getPageData();
        //CurrentUser user = (CurrentUser) request.getSession().getAttribute("curentUser");
        //pd.put("nowAssign", user.getId());
        //int CountTask = homeService.getCountTask(pd);
        //writeJson(response, CountTask);
    }

    @RequestMapping(value = "/openOA")
    @ResponseBody
    public JsonUtil openOA(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        String verificationResult = VerificationUtil.verification(request, response, callBack.getOAPort(), callBack.getOAPath(), user.getUsername(), user.getPassword());
        return JSONObject.toJavaObject((JSON) JSON.parse(verificationResult), JsonUtil.class);
    }

    @RequestMapping(value = "/openWB")
    @ResponseBody
    public JsonUtil openWB(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        String verificationResult = VerificationUtil.verification(request, response, callBack.getWBPort(), callBack.getWBPath(), user.getUsername(), user.getPassword());
        return JSONObject.toJavaObject((JSON) JSON.parse(verificationResult), JsonUtil.class);
    }



    /**
     * 获取待办
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findMyworkData")
    @ResponseBody
    public JsonUtil findMyworkData(HttpServletRequest request) {

        PageData pd = this.getPageData();
        CurrentUser user = (CurrentUser) request.getSession().getAttribute("curentUser");
        pd.put("nowAssign", user.getId());
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> MyworkData = homeService.findMyworkData(pd);

            for (PageData myworkDatum : MyworkData) {
                System.out.println(myworkDatum.getString("fwzh"));
            }

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取待办成功！");
            jsonUtil.setData(MyworkData);
        } catch (Exception e) {
            log.error("获取待办失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取通知公告列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findTzggData")
    @ResponseBody
    public JsonUtil findTzggData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> TzggData = homeService.findTzggData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取待办成功！");
            jsonUtil.setData(TzggData);
        } catch (Exception e) {
            log.error("获取设备告警数量（严重）失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取参阅文件列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findCywjData")
    @ResponseBody
    public JsonUtil findCywjData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> CywjData = homeService.findCywjData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取参阅文件列表成功！");
            jsonUtil.setData(CywjData);
        } catch (Exception e) {
            log.error("获取参阅文件列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取工作安排列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findGzapData")
    @ResponseBody
    public JsonUtil findGzapData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> GzapData = homeService.findGzapData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取工作安排列表成功！");
            jsonUtil.setData(GzapData);
        } catch (Exception e) {
            log.error("获取工作安排列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取发文公开列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findFwgkData")
    @ResponseBody
    public JsonUtil findFwgkData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> FwgkData = homeService.findFwgkData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取发文公开列表成功！");
            jsonUtil.setData(FwgkData);
        } catch (Exception e) {
            log.error("获取发文公开列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取会议纪要列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findHyjyData")
    @ResponseBody
    public JsonUtil findHyjyData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> HyjyData = homeService.findHyjyData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取会议纪要列表成功！");
            jsonUtil.setData(HyjyData);
        } catch (Exception e) {
            log.error("获取会议纪要列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取文件公开列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findWjgkData")
    @ResponseBody
    public JsonUtil findWjgkData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> WjgkData = homeService.findWjgkData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取文件公开列表成功！");
            jsonUtil.setData(WjgkData);
        } catch (Exception e) {
            log.error("获取文件公开列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取每日快报列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findMrkbData")
    @ResponseBody
    public JsonUtil findMrkbData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> MrkbData = homeService.findMrkbData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取每日快报列表成功！");
            jsonUtil.setData(MrkbData);
        } catch (Exception e) {
            log.error("获取每日快报列表失败！", e);
        }

        return jsonUtil;
    }*/

    /**
     * 获取穗府信息列表
     *
     * @param department
     * @param role
     * @return
     */
    /*@RequestMapping(value = "findSfxxData")
    @ResponseBody
    public JsonUtil findSfxxData() {

        PageData pd = this.getPageData();

        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);

        try {
            List<PageData> SfxxData = homeService.findSfxxData(pd);

            jsonUtil.setFlag(true);
            jsonUtil.setMsg("获取穗府信息列表成功！");
            jsonUtil.setData(SfxxData);
        } catch (Exception e) {
            log.error("获取穗府信息列表失败！", e);
        }

        return jsonUtil;
    }*/
}
