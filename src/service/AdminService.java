package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import entity.Admin;

@Transactional 
@Component(value = "adminService")
public class AdminService implements IAdminService{
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void saveOrUpdate(Admin admin) {
		getSession().saveOrUpdate(admin);
	}

	@Override
	public void delete(Admin admin) {
		getSession().delete(admin);
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<Admin> findAll() {
		String hql = "FROM Admin";
		Query query = getSession().createQuery(hql);
		return query.list();
	}

	@Override
	public Admin findById(int id) {
		String sql = "select * from t_admin where id=?";
		Query query = getSession().createSQLQuery(sql).addEntity(Admin.class).setInteger(0, id);
		Admin admin =  (Admin) query.uniqueResult();
		return admin;
	}
 
	@Override
	public Admin checkLogin(Admin admin) {
		String sql = "select * from t_admin where username=? and password=?";
		Query query = getSession().createSQLQuery(sql).addEntity(Admin.class).setString(0, admin.getUsername()).setString(1, admin.getPassword());
		Admin result =  (Admin) query.uniqueResult();
		return result;
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

}
