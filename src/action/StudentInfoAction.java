package action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Course;
import entity.Dictionary;
import entity.StudentInfo;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import service.IDictionaryServcie;
import service.IStudentInfoService;

@ParentPackage("default")  
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
	
	private Set<Course> course;
	

	private String ids;//批量删除

	
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
	
	public Set<Course> getCourse() {
		return course;
	}

	public void setCourse(Set<Course> course) {
		this.course = course;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	@Action(value="list",results = { @Result(name = "list", type="json",params={"root","stuInfo"})})
	public String list() {
		stuInfo = new ArrayList<StudentInfo>();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setIgnoreDefaultExcludes(false); //设置默认忽略 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);//设置循环策略为忽略    解决json最头疼的问题 死循环
		jsonConfig.setExcludes(new String[] {"studet"});//此处是亮点，只要将所需忽略字段加到数组中即可
		JSONArray json=JSONArray.fromObject(studentInfoService.findAll(),jsonConfig);
		for (int i = 0; i < json.size(); i++) { 
			JSONObject jsonObject = json.getJSONObject(i);
			JSONArray course = jsonObject.getJSONArray("course");
			List<Course> courseList=  (List<Course>) JSONArray.toCollection(course , Course.class);
			Set<Course> courseSet= new HashSet<Course>();
			for(int k = 0;k<courseList.size();k++) {
				courseSet.add(courseList.get(k));
			}
			StudentInfo student =  (StudentInfo) JSONObject.toBean(jsonObject, StudentInfo.class);
			student.setCourse(courseSet);
			stuInfo.add(student);
		}
		
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
			if(ids != null) {
				String[] id = ids.split(",");
				for(int i = 0;i<id.length;i++) {
					StudentInfo stuDelete = studentInfoService.findById(Integer.parseInt(id[i]));
					studentInfoService.delete(stuDelete);
				}
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
	
	@Action(value="perInfoedit",results = {
            @Result(name = "success", location = "/admin/page/studentInfo/studentInfo.jsp")})
	public String perInfoedit() {
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
	@Action(value="courseSelected",results = { @Result(name = "courseSelected", type="json",params={"root","course"})})
	public String courseSelected() {
		course = stu.getCourse();
		return "courseSelected";
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
