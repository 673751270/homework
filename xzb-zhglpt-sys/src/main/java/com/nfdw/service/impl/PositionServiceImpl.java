package com.nfdw.service.impl;

import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.impl.BaseServiceImpl;
import com.nfdw.entity.SysPosition;
import com.nfdw.mapper.SysPositionMapper;
import com.nfdw.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionServiceImpl extends BaseServiceImpl<SysPosition, String> implements PositionService {

    @Autowired
    private SysPositionMapper positionDao;


    @Override
    public BaseMapper<SysPosition, String> getMappser() {
        return positionDao;
    }

    @Override
    public int insert(SysPosition position) {
        return positionDao.insert(position);
    }


    @Override
    public List<SysPosition> showMenuJsonList() {
        List<SysPosition> sysSysPositions = positionDao.getMenuJsonList();
        return sysSysPositions;
    }

    @Override
    public int checkPosition(String positionname) {
        return  positionDao.checkPosition(positionname);
    }

//    @Override
//    public JSONArray getTreeUtil(String departmentId) {
//        TreeUtil treeUtil = null;
//        List<SysDepartment> sysMenus = selectAll();
//        List<SysDepartment> supers = sysMenus.stream().filter(sysMenu ->
//                StringUtils.isEmpty(sysMenu.getPId()))
//                .collect(Collectors.toList());
//        sysMenus.removeAll(supers);
//        supers.sort(Comparator.comparingInt(SysMenu::getOrderNum));
//        JSONArray jsonArr = new JSONArray();
//        for (SysMenu sysMenu : supers) {
//            treeUtil = getChildByTree(sysMenu, sysMenus, 0, null, roleId);
//            jsonArr.add(treeUtil);
//        }
//        return jsonArr;
//    }
}
