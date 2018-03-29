package entity;

import java.io.IOException;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import util.MD5Util;
/*
 * 管理员信息表
 */
@Entity(name="t_admin")
public class Admin {
	@Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
	private int id;//ID
	
	private String password;//密码
	
	private String username;//用户名
	
	private String name;//管理员名称
	
	private String realname;//管理员真实名称
	
	private String sex;//性别
	
	private String phonenum;//手机号
	
	private String birthday;//出生日期
	
	private String email;//邮箱
	
	private String appraise;//自我评价
	
	private String type;//管理员类型
	
	private String address;//家庭地址
	
	private String image;//头像
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() throws IOException {
		return  password;
	}

	public void setPassword(String password) throws IOException{
		this.password = MD5Util.md5(password);
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhonenum() {
		return phonenum;
	}

	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAppraise() {
		return appraise;
	}

	public void setAppraise(String appraise) {
		this.appraise = appraise;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}
