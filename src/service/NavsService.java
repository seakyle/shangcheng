package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import entity.Navs;

@Transactional 
@Component(value = "navsService")
public class NavsService implements INavsService{
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveOrUpdate(Navs navs) {
		getSession().saveOrUpdate(navs);
	}

	@Override
	public void delete(Navs navs) {
		getSession().delete(navs);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Navs> findAll() {
		String sql="select * from system_navs order by parentId";
		Query query = getSession().createSQLQuery(sql).addEntity(Navs.class);
		return query.list();
	}

	@Override
	public Navs findById(int id) {
		String sql = "select * from system_navs where id=?";
		Query query = getSession().createSQLQuery(sql).addEntity(Navs.class).setInteger(0, id);
		Navs navs = (Navs) query.uniqueResult();
		return navs;
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
	public List<Navs> findByType(String type) {
		String sql="select * from system_navs where type like ? order by parentId";
		Query query = getSession().createSQLQuery(sql).addEntity(Navs.class).setString(0,type);
		return query.list();
	}

}
