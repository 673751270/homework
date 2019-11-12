package com.nfdw.controller;

import com.nfdw.base.controller.BaseController;
import com.nfdw.base.service.DictionaryService;
import com.nfdw.core.annotation.Log;
import com.nfdw.core.annotation.Log.LOG_TYPE;
import com.nfdw.core.quartz.JobTask;
import com.nfdw.entity.Dictionary;
import com.nfdw.entity.File;
import com.nfdw.entity.InformationPublish;
import com.nfdw.entity.SysUser;
import com.nfdw.exception.MyException;
import com.nfdw.service.DepartmentService;
import com.nfdw.service.FileService;
import com.nfdw.service.InformationPublishService;
import com.nfdw.util.*;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * 信息发布
 */

@Controller
@RequestMapping(value = "/informationpublish")
public class InformationPublishController extends BaseController {

    //private static final Logger

    @Autowired
    InformationPublishService informationpublishService;

    @Autowired
    DictionaryService dictionaryService;

    @Autowired
    DepartmentService departmentService;

    @Autowired
    FileService fileService;

    @Autowired
    JobTask task;

    @Autowired
    UploadUtil uploadUtil;


    @GetMapping(value = "showInformationPublish")
    @RequiresPermissions("informationpublish:show")
    public String showInformationPublish(Model model) {
        Dictionary dictionary = new Dictionary();
        dictionary.setDgroup("information_Type");
        model.addAttribute("informationTypes", dictionaryService.select(dictionary));

        return "/informationpublish/informationpublishList";
    }

    @GetMapping(value = "showInformationPublishList")
    @ResponseBody
    @RequiresPermissions("informationpublish:show")
    public ReType showInformationPublishList(Model model, InformationPublish informationpublish, String page, String limit) {
        return informationpublishService.show(informationpublish, Integer.valueOf(page), Integer.valueOf(limit));
    }


    @GetMapping(value = "showAddInformationPublish")
    public String goAddSchedule(Model model) {

        Dictionary dictionary = new Dictionary();
        dictionary.setDgroup("important_type");

        model.addAttribute("importantTypes", dictionaryService.select(dictionary));

        dictionary.setDgroup("information_Type");
        model.addAttribute("informationTypes", dictionaryService.select(dictionary));

        return "/informationpublish/add-informationpublish";
    }

    @ApiOperation(value = "/addInformationPublish", httpMethod = "POST", notes = "添加信息发布")
    @Log(desc = "添加信息发布")
    @PostMapping(value = "addInformationPublish")
    @ResponseBody
    public JsonUtil addInformationPublish(InformationPublish informationpublish, @RequestParam("list") String list, HttpServletRequest request) {
        if (informationpublish == null) {
            return JsonUtil.error("获取数据失败");
        }
        JsonUtil j = new JsonUtil();
        SysUser user = (SysUser) request.getSession().getAttribute("user");
        informationpublish.setPublishName(user.getRealName());
        informationpublish.setPublishDepartment(departmentService.selectByPrimaryKey(user.getDepartmentId()).getDepartmentName());
        informationpublish.setPublishTime(new Date());

        try {
            if (list != null && !StringUtils.isEmpty(list)) {
                //json字符串转换list对象
                List<File> files = (List<File>) JSONArray.toCollection(JSONArray.fromObject(list), File.class);

                for (File file : files) {
                    fileService.insert(file);
                    informationpublish.setFileIds(informationpublish.getFileIds() == null ? file.getId() + "," : informationpublish.getFileIds() + file.getId() + ",");
                }
            }

            informationpublishService.insertSelective(informationpublish);

            j.setMsg("保存成功");
        } catch (MyException e) {
            j.setMsg("保存失败");
            j.setFlag(false);
            e.printStackTrace();
        }
        return j;
    }

    @GetMapping(value = "updateInformationPublish")
    public String goUpdateInformationPublish(String id, Model model, boolean detail) {
        if (StringUtils.isNotEmpty(id)) {

            Dictionary dictionary = new Dictionary();
            dictionary.setDgroup("important_type");

            model.addAttribute("importantTypes", dictionaryService.select(dictionary));

            dictionary.setDgroup("information_Type");
            model.addAttribute("informationTypes", dictionaryService.select(dictionary));

            InformationPublish informationpublish = informationpublishService.queryInfoById(id);
            model.addAttribute("informationpublish", informationpublish);
        }
        model.addAttribute("detail", detail);
        return "/informationpublish/update-informationpublish";
    }


    @ApiOperation(value = "/updateInformationPublish", httpMethod = "POST", notes = "更新信息发布")
    @Log(desc = "更新信息发布", type = LOG_TYPE.UPDATE)
    @PostMapping(value = "updateInformationPublish")
    @ResponseBody
    public JsonUtil updateSchedule(InformationPublish informationpublish, @RequestParam("list") String list) {
        JsonUtil jsonUtil = new JsonUtil();
        jsonUtil.setFlag(false);
        if (informationpublish == null) {
            jsonUtil.setMsg("获取数据失败");
            return jsonUtil;
        }
        try {
            InformationPublish oldInformationPublish = informationpublishService.selectByPrimaryKey(informationpublish.getId());
            BeanUtil.copyNotNullBean(informationpublish, oldInformationPublish);

            if (list != null && !StringUtils.isEmpty(list)) {
                //json字符串转换list对象
                List<File> files = (List<File>) JSONArray.toCollection(JSONArray.fromObject(list), File.class);

                for (File file : files) {
                    fileService.insert(file);
                    oldInformationPublish.setFileIds(oldInformationPublish.getFileIds() == null ? file.getId() + "," : oldInformationPublish.getFileIds() + file.getId() + ",");
                }
            }

            informationpublishService.updateByPrimaryKeySelective(oldInformationPublish);


            jsonUtil.setFlag(true);
            jsonUtil.setMsg("修改成功");
        } catch (MyException e) {
            e.printStackTrace();
        }
        return jsonUtil;
    }

    @Log(desc = "删除信息发布", type = LOG_TYPE.DEL)
    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除信息发布")
    @PostMapping(value = "/del")
    @ResponseBody
    @RequiresPermissions("informationpublish:del")
    @Transactional
    public JsonUtil del(String id, boolean flag) {
        JsonUtil j = new JsonUtil();

        try {
            InformationPublish oldInformationPublish = informationpublishService.queryInfoById(id);

            informationpublishService.deleteByPrimaryKey(oldInformationPublish);

            if (null != oldInformationPublish && null != oldInformationPublish.getFiles()) {
                for (File file : oldInformationPublish.getFiles()) {
                    fileService.delete(file);
                    uploadUtil.deleteFile(file.getFilePath(), Path.MAIL_PATH);
                }
            }
            j.setFlag(true);
            j.setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return j;
    }


    /**
     * 上传 目前首先相对路径
     */
    @PostMapping(value = "upload", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public JsonUtil upload(@RequestParam(required = false) MultipartFile file) {
        JsonUtil j = new JsonUtil();
        j.setData(uploadUtil.upload(file, Path.INFO_PATH));
        j.setFlag(true);
        return j;

    }

    /**
     * 下载
     *
     * @param
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "download")
    public String download(File file, HttpServletResponse response) throws IOException {
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);

        response.addHeader("Content-Disposition", "attachment;fileName=" + new String(file.getFileName().getBytes("UTF-8"), "ISO-8859-1"));

        response.getOutputStream().write(uploadUtil.download(file, Path.INFO_PATH));
        return null;
    }

    @Log(desc = "删除信息文件", type = LOG_TYPE.DEL)
    @ApiOperation(value = "/del", httpMethod = "POST", notes = "删除信息文件")
    @PostMapping(value = "/delFile")
    @ResponseBody
    @Transactional
    public JsonUtil deleteFile(@RequestParam("fileId") String fileId, @RequestParam("filePath") String filePath, InformationPublish informationPublish) {
        JsonUtil j = new JsonUtil();

        try {

            fileService.deleteByIds(fileId);

            InformationPublish nowInformationPublish = informationpublishService.selectByPrimaryKey(informationPublish);

            nowInformationPublish.setFileIds(nowInformationPublish.getFileIds().replace(fileId + ",", ""));

            informationpublishService.updateByPrimaryKeySelective(nowInformationPublish);

            uploadUtil.deleteFile(filePath, Path.SHEDULE_PATH);
            j.setFlag(true);
            j.setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return j;
    }

    @PostMapping(value = "/delUpFile")
    @ResponseBody
    public JsonUtil deleteFile(@RequestParam("list") String list) {
        JsonUtil j = new JsonUtil();

        if (list != null && !StringUtils.isEmpty(list)) {
            //json字符串转换list对象
            List<com.nfdw.entity.File> files = (List<com.nfdw.entity.File>) JSONArray.toCollection(JSONArray.fromObject(list), com.nfdw.entity.File.class);

            for (File file : files) {
                uploadUtil.deleteFile(file.getFilePath(), Path.INFO_PATH);
            }
        }
        j.setFlag(true);
        j.setMsg("删除上传文件成功");
        return j;
    }

}
