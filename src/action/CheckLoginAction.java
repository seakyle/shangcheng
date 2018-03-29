package action;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionContext;

import entity.Admin;
import entity.Stu_token;
import entity.StudentInfo;
import entity.Teacher;
import service.IAdminService;
import service.IStudentInfoService;
import service.ITeacherService;
import sun.misc.BASE64Encoder;

@ParentPackage("json-default")
@Namespace(value="/checkLogin")
public class CheckLoginAction {

	private static final long serialVersionUID = 1L;

	@Autowired(required = true)
	private IAdminService adminService;

	private Admin admin; //页面上传过来的对象

	private String id;

	private String code;//输入的验证码

	private String userName;//用户名

	private Map<String,Object> msg = new HashMap<String,Object>();//后台返回信息

	private String type;//返回页面的type

	private String name;//名称

	private ActionContext actionContext = ActionContext.getContext();  

	private Map<String,Object> session = actionContext.getSession(); 

	private String image;
	
	private String appUsername;//app中的用户名
	
	private String appPassword;//app中的密码
	
	private String appToken;//密钥
	
	private Map<String, Object> result = new HashMap<>();

	@Autowired
	private IStudentInfoService studentInfoService;

	@Autowired
	private ITeacherService teacherService;



	@Action(value="checkLogin",results = {
			@Result(name = "success", location = "/admin/index.jsp"),
			@Result(name = "error", location = "/admin/login/login.jsp"),
			@Result(name = "input", location = "/admin/login/login.jsp")}
			)
	public String checkLogin() {
		try {
			if(admin != null) {
				Admin adminResult =  adminService.checkLogin(admin);
				StudentInfo studentInfo = studentInfoService.checkLogin(admin.getUsername(), admin.getPassword());
				Teacher teacher = teacherService.checkLogin(admin.getUsername(), admin.getPassword());
				if(adminResult == null || !code.equals(getRand())) {
					if(studentInfo != null && code.equals(getRand())) {
						name = studentInfo.getStu_name();
						type = studentInfo.getType();
						id=Integer.toString(studentInfo.getId());
						userName = studentInfo.getStu_id();
						image = studentInfo.getImage();
						session.put("studentInfo", studentInfo);
						return "success";
					}else if(teacher != null && code.equals(getRand())) {
						name = teacher.getTch_name();
						type = teacher.getType();
						id=Integer.toString(teacher.getId());
						userName = teacher.getTch_id();
						image = teacher.getImage();
						session.put("studentInfo", teacher);
						return "success";
					}else{
						return "error";
					}
				}else {
					name=adminResult.getName();
					type = adminResult.getType();
					id=Integer.toString(adminResult.getId());
					userName = adminResult.getUsername();
					image = adminResult.getImage();
					session.put("admin", adminResult);
					return "success";
				}
			}
			return "input";
		} catch (Exception e) {

			return "input";
		}

	}

	//获取页面生成的验证码
	private String getRand() {
		// TODO Auto-generated method stub
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		String rand = (String) session.get("rand");
		return rand;
	}
	
	
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Map<String, Object> getMsg() {
		return msg;
	}

	public void setMsg(Map<String, Object> msg) {
		this.msg = msg;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public IAdminService getAdminService() {
		return adminService;
	}

	public void setAdminService(IAdminService adminService) {
		this.adminService = adminService;
	}

	public IStudentInfoService getStudentInfoService() {
		return studentInfoService;
	}

	public void setStudentInfoService(IStudentInfoService studentInfoService) {
		this.studentInfoService = studentInfoService;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	public ITeacherService getTeacherService() {
		return teacherService;
	}

	public void setTeacherService(ITeacherService teacherService) {
		this.teacherService = teacherService;
	}

	public String getAppUsername() {
		return appUsername;
	}

	public void setAppUsername(String appUsername) {
		this.appUsername = appUsername;
	}

	public String getAppPassword() {
		return appPassword;
	}

	public void setAppPassword(String appPassword) {
		this.appPassword = appPassword;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

	public String getAppToken() {
		return appToken;
	}

	public void setAppToken(String appToken) {
		this.appToken = appToken;
	}

	

}
