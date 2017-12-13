package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import entity.Dictionary;

@Transactional 
@Component(value = "dictionaryService")
public class DictionaryService implements IDictionaryServcie{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void saveOrUpdate(Dictionary dictionary) {
		getSession().saveOrUpdate(dictionary);
	}

	@Override
	public void delete(Dictionary dictionary) {
		getSession().delete(dictionary);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dictionary> findAll() {
		String sql = "select * from system_dictionary";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class);
		return query.list();
	}

	@Override
	public Dictionary findById(int id) {
		String sql = "select * from system_dictionary where id = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class).setInteger(0, id);
		Dictionary dictionary = (Dictionary) query.uniqueResult();
		return dictionary;
	}

	
	@Override
	public Session getSession() {
		return getSessionFactory().getCurrentSession();
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dictionary> findByParentId(int parentId) {
		String sql = "select * from system_dictionary where parentId = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class).setInteger(0, parentId);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dictionary> findByName(String name) {
		String sql = "select * from system_dictionary where name like ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class).setString(0, "%"+name+"%");
		return query.list();
		
	}
}
