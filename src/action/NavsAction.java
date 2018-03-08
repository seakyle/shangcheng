package action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Navs;
import service.INavsService;



@ParentPackage("default") 
@Namespace("/Navs")
public class NavsAction extends ActionSupport implements Preparable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired(required = true)
	private INavsService navsService;
	
	private List<Navs> navs;
	
	private List<Navs> result;
	
	private Navs nav;//前台传入的对象
	
	private String parentId;//父模块的ID
	
	private String id;//删除或修改需要的ID
	
	private String type;//登录用户类型
	
	private String ids;//批量删除
	
	private String keywords;//关键字
	
	@Action(value="findAll", results = { @Result(name = "navs", type="json",params={"root","result"})})
	public String findAll() {
		navs = navsService.findByType(type);
		Iterator<Navs> it = navs.iterator();
		result = new ArrayList<Navs>();
		if(navs.size() == 1) {
			result.add(it.next());
		}
		while(it.hasNext()) {
			Navs navsSingle = it.next();
			Iterator<Navs> it2 = navs.iterator();
			List<Navs> navsList = new ArrayList<Navs>();
			while(it2.hasNext()) {
				Navs navsSingle2 = it2.next();
				if(navsSingle.getId() == navsSingle2.getParentId()) {
					navsList.add(navsSingle2);
				}
			}
			navsSingle.setChildren(navsList);
			if(navsSingle.getParentId() == 0) {
				result.add(navsSingle);
			}
		}
		
		return "navs";
	}
	@Action(value="list", results = { @Result(name = "list", type="json",params={"root","navs"})})
	public String list() {
		navs = navsService.findAll();
		return "list";
	}
	@Action(value="view",results = {
            @Result(name = "success", location = "/admin/page/navs/navsView.jsp")})
	public String view() {
		nav = navsService.findById(Integer.parseInt(id));
		return "success";
	}
	@Action(value="edit",results = {
            @Result(name = "success", location = "/admin/page/navs/navsAdd.jsp")})
	public String edit() {
		nav = navsService.findById(Integer.parseInt(id));
		return "success";
	}
	@Action(value="save")
	public String save() {
		if(parentId != null) {
			nav.setParentId(Integer.parseInt(parentId));
		}
		navsService.saveOrUpdate(nav);
		return NONE;
	}
	@Action(value="delete")
	public String delete() {
		try {
			if(ids != null) {
				String[] id = ids.split(",");
				for(int i = 0;i<id.length;i++) {
					Navs navsDelete = navsService.findById(Integer.parseInt(id[i]));
					navsService.delete(navsDelete);
				}
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return NONE;
	}
	@Action(value="findByKeyWords",results = { @Result(name = "findByKeyWords", type="json",params={"root","navs"})})
	public String findByKeyWords() {
		navs = navsService.findByKeyWords(keywords);
		return "findByKeyWords";
	}
	public INavsService getNavsService() {
		return navsService;
	}

	public void setNavsService(INavsService navsService) {
		this.navsService = navsService;
	}

	public List<Navs> getNavs() {
		return navs;
	}

	public void setNavs(List<Navs> navs) {
		this.navs = navs;
	}

	public List<Navs> getResult() {
		return result;
	}

	public void setResult(List<Navs> result) {
		this.result = result;
	}
	public Navs getNav() {
		return nav;
	}
	public void setNav(Navs nav) {
		this.nav = nav;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	@Override
	public void prepare() throws Exception {
		if(id == null || id.equals("")) {
			nav = new Navs();
		}else {
			nav = navsService.findById(Integer.parseInt(id));
		}
	}
}
