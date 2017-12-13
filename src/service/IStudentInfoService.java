package service;

import java.util.List;

import org.springframework.stereotype.Repository;

import entity.Dictionary;
import entity.StudentInfo;

@Repository
public interface IStudentInfoService extends IBaseService<StudentInfo>{
		public List<Dictionary> findByPId(int parentId);
		
		public StudentInfo checkLogin(String stu_id,String password);
}
