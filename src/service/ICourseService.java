package service;

import java.util.List;

import entity.Course;

public interface ICourseService extends IBaseService<Course>{
	public List<Course> findCourseByTeacher(int tch_id);
}
