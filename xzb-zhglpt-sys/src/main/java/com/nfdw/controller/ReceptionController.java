package com.nfdw.controller;

import com.nfdw.base.controller.BaseController;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.Members;
import com.nfdw.mapper.SysMembersMapper;
import com.nfdw.service.ReceptionService;
import com.nfdw.service.ToExcleService;
import com.nfdw.util.DateUtils;
import com.nfdw.util.ExcelUtil;
import com.nfdw.util.ReType;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RequestMapping("/reception")
@Controller
public class ReceptionController extends BaseController {


    @Autowired
    ReceptionService receptionService;

    @Autowired
    ToExcleService toExcleService;

    @Autowired
    SysMembersMapper sysMembersMapper;

    /**
     * 加载会员信息管理页面
     */
    @GetMapping("/showMember")
    public String showMember() {

        return "/system/reception/memberList";
    }

    /**
     * 查询会员信息列表
     */
    @ApiOperation(value = "/showMemberList", httpMethod = "GET", notes = "会员信息")
    @GetMapping(value = "showMemberList")
    @ResponseBody
    @RequiresPermissions("member:show")
    public ReType showMemberList(Members members, Model model, String page, String limit) {
        ReType show = receptionService.show(members, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }

    /**
     * 加载导出excle页面
     */
    @GetMapping("/showToExcle")
    public String showToexcle(Model model) {

        return "/system/reception/toExcle";
    }

    /**
     * 查询导出机构信息列表
     */
    @ApiOperation(value = "/showToExcleList", httpMethod = "GET", notes = "导出excle")
    @GetMapping(value = "showToExcleList")
    @ResponseBody
    @RequiresPermissions("toexcle:show")
    public ReType showToExcleList(ExcleInfo excleInfo, Model model, String page, String limit) {
        ReType show = toExcleService.show(excleInfo, Integer.valueOf(page), Integer.valueOf(limit));
        return show;
    }

    /**
     * 导出excle
     */

    @RequestMapping(value = "/export", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Integer export(HttpServletResponse response, HttpServletRequest request) {
        response.setContentType("text/xml;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");


        String departType = request.getParameter("departType");
        String ismember = request.getParameter("ismember");
        String annals = request.getParameter("annals");
        String state = request.getParameter("state");
        String clubYear = request.getParameter("clubYear");
        ExcleInfo excleInfo = new ExcleInfo();
        excleInfo.setDepartType(departType);
        excleInfo.setIsmember(ismember);
        excleInfo.setAnnals(annals);
        excleInfo.setState(state);
        excleInfo.setClubYear(clubYear);

        return receptionService.export(response, excleInfo);
    }

    /**
     * 检查数据量
     */
    @RequestMapping(value = "/checkMax", produces = "application/json; charset=utf-8")
    @ResponseBody
    public Boolean checkMax(HttpServletResponse response, HttpServletRequest request) {

        String departType = request.getParameter("departType");
        String ismember = request.getParameter("ismember");
        String annals = request.getParameter("annals");
        String state = request.getParameter("state");
        String clubYear = request.getParameter("clubYear");
        ExcleInfo excleInfo = new ExcleInfo();
        excleInfo.setDepartType(departType);
        excleInfo.setIsmember(ismember);
        excleInfo.setAnnals(annals);
        excleInfo.setState(state);
        excleInfo.setClubYear(clubYear);
        List<ExcleInfo> ls = receptionService.getExcelList(excleInfo);
        System.out.println("一共：" + ls.size() + "条");
        if (ls.size() > 65535) {
            return false;
        }
        return true;
    }


}
