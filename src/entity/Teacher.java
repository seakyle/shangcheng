package entity;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import util.MD5Util;
/*
 * 教师信息表
 */
@Entity(name="t_teacher")
public class Teacher {
	@Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
	private int id; //ID
	
	@Column(nullable=true)
	private String tch_id;//工号
	
	private String sex; //性别
	
	private String tch_name;//姓名
	
	private String tch_num;//身份证号
	
	private String major;//专业
	
	@Column(nullable=true)
	private String address; //地址
	
	@Column(nullable=true)
	private String password;//密码
	
	private String type;//类型
	
	private String image;//头像
	
	@ManyToMany(mappedBy="teacher",cascade=CascadeType.PERSIST,fetch=FetchType.EAGER)
	private Set<Course> course;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTch_id() {
		return tch_id;
	}

	public void setTch_id(String tch_id) {
		this.tch_id = tch_id;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTch_name() {
		return tch_name;
	}

	public void setTch_name(String tch_name) {
		this.tch_name = tch_name;
	}

	public String getTch_num() {
		return tch_num;
	}

	public void setTch_num(String tch_num) {
		this.tch_num = tch_num;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return  password;
	}

	public void setPassword(String password) {
		this.password = MD5Util.md5(password);
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Set<Course> getCourse() {
		return course;
	}

	public void setCourse(Set<Course> course) {
		this.course = course;
	}
	
	
}
