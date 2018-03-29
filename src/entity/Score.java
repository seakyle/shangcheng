package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
/*
 * 学生成绩表
 */
@Entity(name="t_score")
public class Score {
	@Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
	private int id; //ID
	
	private String stu_id;//学生学号
	
	private String stu_name;//学生姓名
	
	private String tch_id;//教师工号
	
	private String tch_name;//教师姓名
	
	private String score;//课程得分
	
	private String course_id;//课程编号
	
	private String course_name;//课程名称

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStu_id() {
		return stu_id;
	}

	public void setStu_id(String stu_id) {
		this.stu_id = stu_id;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getTch_id() {
		return tch_id;
	}

	public void setTch_id(String tch_id) {
		this.tch_id = tch_id;
	}

	public String getTch_name() {
		return tch_name;
	}

	public void setTch_name(String tch_name) {
		this.tch_name = tch_name;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
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
	
	

}
