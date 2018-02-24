package service;

import java.util.List;

import entity.Dictionary;

public interface IDictionaryServcie extends IBaseService<Dictionary>{
	
	public List<Dictionary> findByParentId(String parentId); //根据父元素code查询节点
	
	public List<Dictionary> findByName(String name); //根据父元素名称模糊查询
	
	public List<Dictionary> findByParentIdList(List<String> parentIdList); //根据传入的父元素code列表查询
}
