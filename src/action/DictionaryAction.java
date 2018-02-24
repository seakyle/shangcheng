package action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import entity.Dictionary;
import service.IDictionaryServcie;

@ParentPackage("default") 
@Namespace("/dictionary")
public class DictionaryAction extends ActionSupport implements Preparable{

	
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private IDictionaryServcie dictionaryService;
	
	private String id;
	
	private Dictionary dictionary;
	
	private List<Dictionary> dictionaries;
	
	private  List<Dictionary> result;
	
	public IDictionaryServcie getDictionaryService() {
		return dictionaryService;
	}


	public void setDictionaryService(IDictionaryServcie dictionaryService) {
		this.dictionaryService = dictionaryService;
	}


	public List<Dictionary> getResult() {
		return result;
	}


	public void setResult(List<Dictionary> result) {
		this.result = result;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public Dictionary getDictionary() {
		return dictionary;
	}


	public List<Dictionary> getDictionaries() {
		return dictionaries;
	}


	public void setDictionaries(List<Dictionary> dictionaries) {
		this.dictionaries = dictionaries;
	}


	public void setDictionary(Dictionary dictionary) {
		this.dictionary = dictionary;
	}
	@Action(value="findAll", results = { @Result(name = "dictionary", type="json",params={"root","dictionaries"})})
	public String findAll() {
		dictionaries = dictionaryService.findAll();
		return "dictionary";
	}
	@Action(value="delete")
	public String delete() {
		dictionaryService.delete(dictionary);
		return NONE;
	}
	@Action(value="listForTree", results = { @Result(name = "dictionary", type="json",params={"root","result"})})
	public String listForTree() {
		List<Dictionary> dictionaries1 = dictionaryService.findByParentId("0");
		Iterator<Dictionary> it = dictionaries1.iterator();
		result = new ArrayList<Dictionary>();
		while(it.hasNext()) {
			Dictionary dictionary1 = it.next();
			List<Dictionary> dictionaries2 = dictionaryService.findByParentId(dictionary1.getCode());
			if(!dictionaries2.isEmpty()) {
				Iterator<Dictionary> it2 = dictionaries2.iterator();
				while(it2.hasNext()) {
					Dictionary dictionary3 = it2.next();
					List<Dictionary> dictionaries3 = dictionaryService.findByParentId(dictionary3.getCode());
					if(!dictionaries3.isEmpty()) {
						Iterator<Dictionary> it3 = dictionaries3.iterator();
						while(it3.hasNext()) {
							Dictionary dictionary4 = it3.next();
							List<Dictionary> dictionaries4 = dictionaryService.findByParentId(dictionary4.getCode());
							if(!dictionaries4.isEmpty()) {
								Iterator<Dictionary> it4 = dictionaries4.iterator();
								while(it4.hasNext()) {
									Dictionary dictionary5 = it4.next();
									List<Dictionary> dictionaries5 = dictionaryService.findByParentId(dictionary5.getCode());
									dictionary5.setChildren(dictionaries5);
								}
							}
							dictionary4.setChildren(dictionaries4);
						}
						dictionary3.setChildren(dictionaries3);
					}
				}
				dictionary1.setChildren(dictionaries2);
			}
			
			result.add(dictionary1);
		}
		return "dictionary";
	}
	@Action(value="save")
	public String save() {
		dictionaryService.saveOrUpdate(dictionary);
		return NONE;
	}
	@Override
	public void prepare() throws Exception {
		if(id == null || id.equals("")) {
			dictionary = new Dictionary();
		}else {
			dictionary = dictionaryService.findById(Integer.parseInt(id));
		}
	}
	@Action(value="findMajor", results = { @Result(name = "findMajor", type="json",params={"root","result"})})
	public String findMajor() {
		List<Dictionary> collage = dictionaryService.findByParentId("01");
		List<String> parentId = new ArrayList<String>();
		for(int i = 0;i<collage.size();i++) {
			parentId.add(collage.get(i).getCode());
		}
		result = dictionaryService.findByParentIdList(parentId);
		return "findMajor";
	}

}
