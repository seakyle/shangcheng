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

import entity.Course;
import service.ICourseService;

@InterceptorRef(value="paramsPrepareParamsStack")
@ParentPackage("json-default")  
@Namespace("/course")
public class CourseAction extends ActionSupport implements Preparable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private ICourseService courseService;
	
	private List<Course> courseList;
	
	private Course course;
	
	private String id;

	public ICourseService getCourseService() {
		return courseService;
	}

	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}


	public List<Course> getCourseList() {
		return courseList;
	}

	public void setCourseList(List<Course> courseList) {
		this.courseList = courseList;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public void prepare() throws Exception {
		if(id == null ||id.equals("")) {
			course = new Course();
		}else {
			course = courseService.findById(Integer.parseInt(id));
		}
	}
	@Action(value="list",results = { @Result(name = "list", type="json",params={"root","courseList"})})
	public String list() {
		courseList = courseService.findAll();
		return "list";
	}
	
	@Action(value="save")
	public String save() {
		courseService.saveOrUpdate(course);
		return NONE;
	}
	
	@Action(value="delete")
	public String delete() {
		try {
			courseService.delete(course);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return NONE;
	}
	@Action(value="edit",results = {
            @Result(name = "success", location = "/admin/page/course/courseAdd.jsp")})
	public String edit() {
		return "success";
	}
}
