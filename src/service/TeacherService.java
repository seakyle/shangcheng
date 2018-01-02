package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import entity.Dictionary;
import entity.StudentInfo;
import entity.Teacher;

@Transactional 
@Component(value = "teacherService")
public class TeacherService implements ITeacherService{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void saveOrUpdate(Teacher teacher) {
		getSession().saveOrUpdate(teacher);
	}

	@Override
	public void delete(Teacher teacher) {
		getSession().delete(teacher);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Teacher> findAll() {
		String sql = "select * from t_teacher";
		Query query = getSession().createSQLQuery(sql).addEntity(Teacher.class);
		return query.list();
	}

	@Override
	public Teacher findById(int id) {
		String sql = "select * from t_teacher where id = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Teacher.class).setInteger(0, id);
		return (Teacher) query.uniqueResult();
	}

	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Teacher> findByKeyWords(String keywords) {
		String sql = "select * from t_teacher where tch_name like ? or tch_id like ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Teacher.class).setString(0, keywords);
		return query.list();
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public List<Dictionary> findByPId(int parentId) {
		String sql = "select * from system_dictionary where parentId = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class).setInteger(0, parentId);
		return query.list();
	}

	@Override
	public Teacher checkLogin(String stu_id, String password) {
		String sql = "select * from t_teacher where tch_id = ? and password = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Teacher.class).setString(0, stu_id).setString(1, password);
		return (Teacher) query.uniqueResult();
	}

}
