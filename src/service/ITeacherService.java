package service;

import java.util.List;

import org.springframework.stereotype.Repository;

import entity.Dictionary;
import entity.Teacher;


@Repository
public interface ITeacherService extends IBaseService<Teacher>{
	public List<Dictionary> findByPId(int parentId);
	
	public Teacher checkLogin(String stu_id,String password);
}
