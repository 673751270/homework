package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.ExcleInfo;
import com.nfdw.entity.Members;
import com.nfdw.mapper.SysMembersMapper;
import com.nfdw.service.ReceptionService;
import com.nfdw.utils.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import springfox.documentation.annotations.Cacheable;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReceptionServiceIpml extends BaseServiceImpl<Members,String> implements ReceptionService {

    @Autowired
    SysMembersMapper sysMembersMapper;

    @Override
    public BaseMapper<Members, String> getMappser() {
        return sysMembersMapper;
    }


    @Override
    public List<Members> getMemeberList() {

        return sysMembersMapper.getMemberList();
    }


    private List<ExcleInfo> listPcd =null;//excel数据集合
    /**
     * 输出方法
     *
     * @param response
     * @return
     */
    @Cacheable(value = "excel")
    @Override
    public Integer export(HttpServletResponse response, ExcleInfo excleInfo) {
        try {

            System.out.println(listPcd.toString());
            System.out.println("一共："+listPcd.size()+"条");

            String fileName = "机构信息表";
            List<Map<String, Object>> list = createExcelRecord(listPcd);
            String columnNames[] = {"编号", "机构名称", "负责人", "证号", "地址", "电话", "传真", "邮编", "传真", "管理部门", "已年度报告", "已缴纳会费", "是否会员", "状态"};//列名
            String keys[] = {"rownum", "orgName", "principal", "registerNum", "addressArea", "oph", "fax", "zip", "departType", "annals", "clubYear", "ismember", "state"};//map中的key
            ExcelUtil.downloadWorkBook(list, keys, columnNames, fileName, response);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ExcleInfo> getExcelList(ExcleInfo excleInfo) {
        listPcd = sysMembersMapper.getExcelList(excleInfo);
        return listPcd;
    }

    /**
     * 创建Excel表中的记录
     *
     * @param excleInfoList
     * @return
     */
    private List<Map<String, Object>> createExcelRecord(List<ExcleInfo> excleInfoList) {
        List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("sheetName", "sheet1");
            listmap.add(map);
            for (int j = 0; j < excleInfoList.size(); j++) {
                ExcleInfo excleInfo = excleInfoList.get(j);
                Map<String, Object> mapValue = new HashMap<String, Object>();
                mapValue.put("rownum", excleInfo.getRownum());
                mapValue.put("orgName", excleInfo.getOrgName());
                mapValue.put("principal", excleInfo.getPrincipal());
                mapValue.put("registerNum", excleInfo.getRegisterNum());
                mapValue.put("addressArea", excleInfo.getAddressArea());
                mapValue.put("oph", excleInfo.getOph());
                mapValue.put("fax", excleInfo.getFax());
                mapValue.put("zip", excleInfo.getZip());
                mapValue.put("departType", excleInfo.getDepartType());
                mapValue.put("annals", excleInfo.getAnnals());
                mapValue.put("clubYear", excleInfo.getClubYear());
                mapValue.put("ismember", excleInfo.getIsmember());
                mapValue.put("state", excleInfo.getState());
                //mapValue.put("submitTime", DateTimeUtil.dateToStr(projectAuditListVo.getSubmitTime(),"yyyy-MM-dd"));
                //String attachmentURL = projectAuditListVo.getAttachment()==null?"无": FileUtil.getUploadPath()+projectAuditListVo.getAttachment();

                listmap.add(mapValue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listmap;
    }

}
