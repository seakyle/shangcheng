package action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Course;
import entity.StudentInfo;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import service.ICourseService;

@ParentPackage("default")  
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
	
	private String ids;//批量删除

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

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	@Override
	public void prepare() throws Exception {
		if(id == null ||id.equals("")) {
			course = new Course();
		}else {
			course = courseService.findById(Integer.parseInt(id));
		}
	}
	@SuppressWarnings("unchecked")
	@Action(value="list",results = { @Result(name = "list", type="json",params={"root","courseList"})})
	public String list() {
		courseList = new ArrayList<Course>();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setIgnoreDefaultExcludes(false); //设置默认忽略 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);//设置循环策略为忽略    解决json最头疼的问题 死循环
		jsonConfig.setExcludes(new String[] {"course"});//此处是亮点，只要将所需忽略字段加到数组中即可
		JSONArray json=JSONArray.fromObject(courseService.findAll(),jsonConfig);
		for (int i = 0; i < json.size(); i++) { 
			JSONObject jsonObject = json.getJSONObject(i);
			JSONArray student = jsonObject.getJSONArray("student");
			List<StudentInfo> studentList= (List<StudentInfo>) JSONArray.toCollection(student , StudentInfo.class);
			Set<StudentInfo> studentSet= new HashSet<StudentInfo>();
			for(int k = 0;k<studentList.size();k++) {
				studentSet.add(studentList.get(k));
			}
			Course course =  (Course) JSONObject.toBean(jsonObject, Course.class);
			course.setStudent(studentSet);
			courseList.add(course);
		}
		return "list";
	}
	
	@Action(value="save")
	public String save() {
		StudentInfo studentInfo = (StudentInfo) ActionContext.getContext().getSession().get("studentInfo");
		Set<StudentInfo> student = new HashSet<StudentInfo>();
		if(studentInfo != null) {
			student.add(studentInfo);
			course.setStudent(student);
		}
		courseService.saveOrUpdate(course);
		return NONE;
	}
	
	@Action(value="delete")
	public String delete() {
		try {
			if(ids != null) {
				String[] id = ids.split(",");
				for(int i = 0;i<id.length;i++) {
					course = courseService.findById(Integer.parseInt(id[i]));
					courseService.delete(course);
				}
			}
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
	@Action(value="withdrawal")
	public String withdrawal() {
		Set<StudentInfo> studentSet = course.getStudent();
		Iterator<StudentInfo> it = studentSet.iterator();
		while(it.hasNext()) {
			StudentInfo student = it.next();
			studentSet.remove(student);
		}
		course.setStudent(studentSet);
		courseService.saveOrUpdate(course);
		return NONE;
	}
}
