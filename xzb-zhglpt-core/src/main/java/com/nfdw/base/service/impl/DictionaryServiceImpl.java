package com.nfdw.base.service.impl;

import com.github.pagehelper.PageHelper;
import com.nfdw.base.BaseMapper;
import com.nfdw.base.service.DictionaryService;
import com.nfdw.entity.Dictionary;
import com.nfdw.entity.PageData;
import com.nfdw.mapper.DictionaryMapper;
import com.nfdw.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DictionaryServiceImpl extends BaseServiceImpl<Dictionary,String> implements DictionaryService {
    
    @Autowired
    private DictionaryMapper dictionaryMapper;
    
    @Override
    public List<Dictionary> selectDictionary(Dictionary dictionary) {
        // TODO Auto-generated method stub
        return dictionaryMapper.selectDictionary(dictionary);
    }
    
    @Override
    public boolean addDictionary(Dictionary dictionary) {
        // TODO Auto-generated method stub
        return dictionaryMapper.addDictionary(dictionary);
    }
    
    @Override
    public boolean editDictionary(Dictionary dictionary) {
        // TODO Auto-generated method stub
        return dictionaryMapper.editDictionary(dictionary);
    }
    
    @Override
    public boolean delDictionary(int id) {
        // TODO Auto-generated method stub
        return dictionaryMapper.delDictionary(id);
    }
    
    @Override
    public List<Dictionary> selectDictionaryPage(Dictionary dictionary) {
        // TODO Auto-generated method stub
        return dictionaryMapper.selectDictionaryPage(dictionary);
    }
    
    @Override
    public int getPage(Dictionary dictionary) {
        // TODO Auto-generated method stub
        return dictionaryMapper.getPage(dictionary);
    }
    
    @Override
    public List<PageData> selectItemsByGroup(PageData group) {
        // TODO Auto-generated method stub
        List<PageData> dictlist = dictionaryMapper.selectItemsByGroup(group);
        return dictlist;
    }

	@Override
	public PageData selectDictionaryView(PageData pd) {
		// TODO Auto-generated method stub
		PageData pds= dictionaryMapper.selectDictionaryView(pd);
		return pds;
	}

	@Override
	public void editDictionaryInfo(PageData pd) {
		// TODO Auto-generated method stub
		dictionaryMapper.editDictionaryInfo(pd);
	}

	@Override
	public void addDictionaryInfo(PageData pd) {
		// TODO Auto-generated method stub
		dictionaryMapper.addDictionaryInfo(pd);
	}

	@Override
	public List<PageData> findDictionaryList(PageData pd) {
		// TODO Auto-generated method stub
		String pageNum ="1";
		if (Tools.notEmpty(pd.getString("pageNum"))) {
			pageNum =  pd.getString("pageNum");
		}
		Integer pagenums =Integer.valueOf(pageNum);
		int pageSize = 10;
		if (Tools.notEmpty(pd.getString("pageSize"))) {
			pageSize =  Integer.parseInt(pd.getString("pageSize"));
		}
		PageHelper.startPage(pagenums, pageSize,true);
		List<PageData> list= dictionaryMapper.findDictionaryList(pd);
		
		return list;
	}

    @Override
    public BaseMapper<Dictionary, String> getMappser() {
        return dictionaryMapper;
    }
}
