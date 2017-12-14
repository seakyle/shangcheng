package entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

/*
 * 模块管理
 */
@Entity(name="system_navs")
public class Navs {
	
	@Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
	private int id;//id
	
	private String title; //标题
	
	private String icon; //图标
	
	private String href;//链接
	
	@Column(nullable=false,columnDefinition="varchar(20) default false")
	private String spread; //是否展开
	
	private int parentId;//父节点的ID
	
	 @Transient
	private List<Navs> children;//子节点
	 
	 private String type;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getSpread() {
		return spread;
	}

	public void setSpread(String spread) {
		this.spread = spread;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public List<Navs> getChildren() {
		return children;
	}

	public void setChildren(List<Navs> children) {
		this.children = children;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
