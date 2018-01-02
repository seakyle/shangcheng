package action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Course;
import entity.Dictionary;
import entity.StudentInfo;
import entity.Teacher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import service.IDictionaryServcie;
import service.ITeacherService;

@ParentPackage("default")  
@Namespace("/teacher")
public class TeacherAction extends ActionSupport implements Preparable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	
	private Teacher tch;
	
	private List<Teacher> teacher;
	
	private String keywords;
	
	private String parentId;
	
	@Autowired
	private ITeacherService teacherService;
	
	private Map<String,Object> msg = new HashMap<String,Object>();
	
	private String ids;
	
	private String name;
	
	private List<Dictionary> list;
	
	private Set<Course> course;
	
	@Autowired
	private IDictionaryServcie dictionaryService;
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public Teacher getTch() {
		return tch;
	}


	public void setTch(Teacher tch) {
		this.tch = tch;
	}

	public List<Teacher> getTeacher() {
		return teacher;
	}


	public void setTeacher(List<Teacher> teacher) {
		this.teacher = teacher;
	}

	public Map<String, Object> getMsg() {
		return msg;
	}


	public void setMsg(Map<String, Object> msg) {
		this.msg = msg;
	}

	public String getIds() {
		return ids;
	}


	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getKeywords() {
		return keywords;
	}


	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}


	public String getParentId() {
		return parentId;
	}


	public void setParentId(String parentId) {
		this.parentId = parentId;
	}


	public ITeacherService getTeacherService() {
		return teacherService;
	}


	public void setTeacherService(ITeacherService teacherService) {
		this.teacherService = teacherService;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public List<Dictionary> getList() {
		return list;
	}


	public void setList(List<Dictionary> list) {
		this.list = list;
	}


	public Set<Course> getCourse() {
		return course;
	}


	public void setCourse(Set<Course> course) {
		this.course = course;
	}


	public IDictionaryServcie getDictionaryService() {
		return dictionaryService;
	}


	public void setDictionaryService(IDictionaryServcie dictionaryService) {
		this.dictionaryService = dictionaryService;
	}


	@Override
	public void prepare() throws Exception {
		if(id == null ||id.equals("")) {
			tch = new Teacher();
		}else {
			tch = teacherService.findById(Integer.parseInt(id));
		}
	}
	@SuppressWarnings("unchecked")
	@Action(value="list",results = { @Result(name = "list", type="json",params={"root","teacher"})})
	public String list() {
		teacher = new ArrayList<Teacher>();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setIgnoreDefaultExcludes(false); //设置默认忽略 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);//设置循环策略为忽略    解决json最头疼的问题 死循环
		jsonConfig.setExcludes(new String[] {"teacher"});//此处是亮点，只要将所需忽略字段加到数组中即可
		JSONArray json=JSONArray.fromObject(teacherService.findAll(),jsonConfig);
		for (int i = 0; i < json.size(); i++) { 
			JSONObject jsonObject = json.getJSONObject(i);
			JSONArray course = jsonObject.getJSONArray("course");
			List<Course> courseList=  (List<Course>) JSONArray.toCollection(course , Course.class);
			Set<Course> courseSet= new HashSet<Course>();
			for(int k = 0;k<courseList.size();k++) {
				courseSet.add(courseList.get(k));
			}
			Teacher teacherSingle =  (Teacher) JSONObject.toBean(jsonObject, Teacher.class);
			teacherSingle.setCourse(courseSet);
			teacher.add(teacherSingle);
		}
		
		return "list";
	}
	
	@Action(value="save",results = { @Result(name = "save", type="json",params={"root","msg"})})
	public String save() {
		try {
			teacherService.saveOrUpdate(tch);
			msg.put("state", true);
			msg.put("msg", "保存成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg.put("state", true);
			msg.put("msg", "保存失败");
		}
		return "save";
	}
	@Action(value="delete")
	public String delete() {
		try {
			if(ids != null) {
				String[] id = ids.split(",");
				for(int i = 0;i<id.length;i++) {
					Teacher tchDelete = teacherService.findById(Integer.parseInt(id[i]));
					teacherService.delete(tchDelete);
				}
			}
			msg.put("state", true);
			msg.put("msg", "删除成功");
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg.put("state", false);
			msg.put("msg", "删除失败");
		}
		return NONE;
	}
	@Action(value="view",results = {
            @Result(name = "success", location = "/admin/page/teacher/teacherView.jsp")})
	public String view() {
		tch = teacherService.findById(Integer.parseInt(id));
		return "success";
	}

	@Action(value="edit",results = {
            @Result(name = "success", location = "/admin/page/teacher/teacherAdd.jsp")})
	public String edit() {
		tch = teacherService.findById(Integer.parseInt(id));
		return "success";
	}
	
	@Action(value="perInfoedit",results = {
            @Result(name = "success", location = "/admin/page/teacher/teacher.jsp")})
	public String perInfoedit() {
		tch = teacherService.findById(Integer.parseInt(id));
		return "success";
	}



	@Action(value="listForSelect",results = { @Result(name = "listForSelect", type="json",params={"root","list"})})
	public String listForSelect() {
		list = teacherService.findByPId(Integer.parseInt(parentId));
		return "listForSelect";
	}

	@Action(value="listForProvice",results = { @Result(name = "listForSelect", type="json",params={"root","list"})})
	public String listForProvice() {
		list = dictionaryService.findByName(name);
		return "listForSelect";
	}
	@Action(value="courseSelected",results = { @Result(name = "courseSelected", type="json",params={"root","course"})})
	public String courseSelected() {
		course = tch.getCourse();
		return "courseSelected";
	}
	@Action(value="findByKeyWords",results = { @Result(name = "findByKeyWords", type="json",params={"root","stuInfo"})})
	public String findByKeyWords() {
		teacher = teacherService.findByKeyWords(keywords);
		return "findByKeyWords";
	}
}
