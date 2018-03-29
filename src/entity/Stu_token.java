package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.apache.struts2.json.annotations.JSON;
/*
 * app用户登录表
 */

@Entity(name="t_stu_token")
public class Stu_token {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; //ID
      
	private String user_id; //用户id
	
	private String user_token;//登陆密钥
	
	private long expire_time;//过期时间

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_token() {
		return user_token;
	}

	public void setUser_token(String user_token) {
		this.user_token = user_token;
	}

	public long getExpire_time() {
		return expire_time;
	}

	public void setExpire_time(long expire_time) {
		this.expire_time = expire_time;
	}

	
	
	
}
