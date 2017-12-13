package service;

import java.util.List;

import entity.Dictionary;

public interface IDictionaryServcie extends IBaseService<Dictionary>{
	
	public List<Dictionary> findByParentId(int parentId);
	
	public List<Dictionary> findByName(String name);
}
