package entity;

import java.io.IOException;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

import org.apache.struts2.json.annotations.JSON;

import com.alibaba.fastjson.annotation.JSONField;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import util.MD5Util;
/*
 * 学生信息表
 */
@Entity(name="t_stuInfo")
public class StudentInfo {
	@Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
	private int id; //ID
	
	@Column(nullable=true)
	private String stu_id;//学号
	
	private String sex; //性别
	
	private String stu_name;//姓名
	
	private String stu_num;//身份证号
	
	private String major;//专业
	
	@Column(nullable=true)
	private String address; //地址
	
	@Column(nullable=true)
	private String password;//密码
	
	private String type;//类型
	
	private String image;//头像
	
	@ManyToMany(mappedBy="student",cascade=CascadeType.PERSIST,fetch=FetchType.EAGER)
	private Set<Course> course;//课程

	@OneToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "user_login")
	private Stu_token stu_token;//学生登陆口令
	
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

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getStu_num() {
		return stu_num;
	}

	public void setStu_num(String stu_num) {
		this.stu_num = stu_num;
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

	public String getPassword() throws IOException {
		return password;
	}

	public void setPassword(String password) throws IOException {
		this.password = MD5Util.md5(password);
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Set<Course> getCourse() {
		return course;
	}

	public void setCourse(Set<Course> course) {
		this.course = course;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	@JSON(serialize=false)
	public Stu_token getStu_token() {
		return stu_token;
	}
	@JSON(serialize=false)
	public void setStu_token(Stu_token stu_token) {
		this.stu_token = stu_token;
	}
	
	
}
