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

@Transactional 
@Component(value = "studentInfoService")
public class StudentInfoService implements IStudentInfoService{

	@Autowired
	private SessionFactory sessionFactory;
	
	

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void saveOrUpdate(StudentInfo studentInfo) {
		getSession().saveOrUpdate(studentInfo);
	}

	@Override
	public void delete(StudentInfo studentInfo) {
		getSession().delete(studentInfo);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<StudentInfo> findAll() {
		String sql="select * from t_stuinfo";
		Query query = getSession().createSQLQuery(sql).addEntity(StudentInfo.class);
		return query.list();
	}

	@Override
	public StudentInfo findById(int id) {
		String sql="select * from t_stuinfo where id=?";
		Query query = getSession().createSQLQuery(sql).addEntity(StudentInfo.class).setInteger(0, id);
		StudentInfo studentinfo = (StudentInfo) query.uniqueResult();
		return studentinfo;
	}

	@Override
	public Session getSession() {
		return getSessionFactory().getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dictionary> findByPId(int parentId) {
		String sql = "select * from system_dictionary where parentId = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Dictionary.class).setInteger(0, parentId);
		return query.list();
	}

	@Override
	public StudentInfo checkLogin(String stu_id, String password) {
		String sql = "select * from t_stuinfo where stu_id = ? and password = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(StudentInfo.class).setString(0, stu_id).setString(1, password);
		return (StudentInfo) query.uniqueResult();
	}


}
