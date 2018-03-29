package entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
/*
 * 课程信息表
 */

@Entity(name="t_course")
public class Course {
	@Id  
    @GeneratedValue(strategy = GenerationType.AUTO) 
	private int id; //ID
	
	private String course_id;//课程编号
	
	private String course_name;//课程名称
	
	private String course_credits;//课程学分
	
	private String course_description;//课程描述
	
	private String image;//课程封面
	
	@ManyToMany(fetch=FetchType.EAGER)
	@OrderBy("id")
	private Set<StudentInfo> student;
	
	@ManyToOne
	private Teacher teacher;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public String getCourse_credits() {
		return course_credits;
	}

	public void setCourse_credits(String course_credits) {
		this.course_credits = course_credits;
	}

	public String getCourse_description() {
		return course_description;
	}

	public void setCourse_description(String course_description) {
		this.course_description = course_description;
	}

	public Set<StudentInfo> getStudent() {
		return student;
	}

	public void setStudent(Set<StudentInfo> student) {
		this.student = student;
	}

	
	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}
