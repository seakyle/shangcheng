package service;

import java.util.List;

import org.springframework.stereotype.Repository;

import entity.Navs;

@Repository
public interface INavsService extends IBaseService<Navs>{
	public List<Navs> findByType(String type);
}
