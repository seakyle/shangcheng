package action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Dictionary;
import entity.StudentInfo;
import service.IDictionaryServcie;
import service.IStudentInfoService;

@InterceptorRef(value="paramsPrepareParamsStack")
@ParentPackage("json-default")  
@Namespace("/studentInfo")
public class StudentInfoAction extends ActionSupport implements Preparable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private IStudentInfoService studentInfoService;
	
	private List<StudentInfo> stuInfo;
	
	private StudentInfo stu;
	
	private String id;
	
	private List<Dictionary> list;
	
	private String parentId;
	
	@Autowired
	private IDictionaryServcie dictionaryService;
	
	private String name;

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public IDictionaryServcie getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(IDictionaryServcie dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public List<Dictionary> getList() {
		return list;
	}

	public void setList(List<Dictionary> list) {
		this.list = list;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public IStudentInfoService getStudentInfoService() {
		return studentInfoService;
	}

	public void setStudentInfoService(IStudentInfoService studentInfoService) {
		this.studentInfoService = studentInfoService;
	}
	
	public List<StudentInfo> getStuInfo() {
		return stuInfo;
	}

	public void setStuInfo(List<StudentInfo> stuInfo) {
		this.stuInfo = stuInfo;
	}

	@Action(value="list",results = { @Result(name = "list", type="json",params={"root","stuInfo"})})
	public String list() {
		stuInfo = studentInfoService.findAll();
		return "list";
	}

	@Action(value="save")
	public String save() {
		studentInfoService.saveOrUpdate(stu);
		return NONE;
	}

	@Action(value="delete")
	public String delete() {
		try {
			if(id != null) {
				StudentInfo stuDelete = studentInfoService.findById(Integer.parseInt(id));
				studentInfoService.delete(stuDelete);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return NONE;
	}

	@Action(value="view",results = {
            @Result(name = "success", location = "/admin/page/studentInfo/studentInfoView.jsp")})
	public String view() {
		stu = studentInfoService.findById(Integer.parseInt(id));
		return "success";
	}

	@Action(value="edit",results = {
            @Result(name = "success", location = "/admin/page/studentInfo/studentInfoAdd.jsp")})
	public String edit() {
		stu = studentInfoService.findById(Integer.parseInt(id));
		return "success";
	}

	@Action(value="listForSelect",results = { @Result(name = "listForSelect", type="json",params={"root","list"})})
	public String listForSelect() {
		list = studentInfoService.findByPId(Integer.parseInt(parentId));
		return "listForSelect";
	}

	@Action(value="listForProvice",results = { @Result(name = "listForSelect", type="json",params={"root","list"})})
	public String listForProvice() {
		list = dictionaryService.findByName(name);
		return "listForSelect";
	}
	public StudentInfo getStu() {
		return stu;
	}

	public void setStu(StudentInfo stu) {
		this.stu = stu;
	}

	@Override
	public void prepare() throws Exception {
		if(id == null ||id.equals("")) {
			stu = new StudentInfo();
		}else {
			stu = studentInfoService.findById(Integer.parseInt(id));
		}
	}
}
