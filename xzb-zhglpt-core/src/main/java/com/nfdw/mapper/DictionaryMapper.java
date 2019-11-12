package com.nfdw.mapper;

import com.nfdw.base.BaseMapper;
import com.nfdw.entity.Dictionary;
import com.nfdw.entity.PageData;

import java.util.List;


public interface DictionaryMapper extends BaseMapper<Dictionary, String> {
	public List<Dictionary> selectDictionary(Dictionary dictionary);

	public boolean addDictionary(Dictionary dictionary);

	public boolean editDictionary(Dictionary dictionary);

	public boolean delDictionary(int id);

	public List<Dictionary> selectDictionaryPage(Dictionary dictionary);

	public int getPage(Dictionary dictionary);
	
	public List<PageData> selectItemsByGroup(PageData group);

	public PageData selectDictionaryView(PageData pd);

	public void editDictionaryInfo(PageData pd);

	public void addDictionaryInfo(PageData pd);

	public List<PageData> findDictionaryList(PageData pd);
}
