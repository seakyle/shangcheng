package service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import entity.Score;

@Transactional 
@Component(value = "scoreService")
public class ScoreService implements IScoreService{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void saveOrUpdate(Score score ) {
		getSession().saveOrUpdate(score);
	}

	@Override
	public void delete(Score score) {
		getSession().delete(score);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Score> findAll() {
		String sql = "select * from t_score";
		Query query = getSession().createSQLQuery(sql).addEntity(Score.class);
		return query.list();
	}

	@Override
	public Score findById(int id) {
		String sql = "select * from t_score where id = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Score.class).setInteger(0, id);
		return (Score) query.uniqueResult();
	}

	@Override
	public Session getSession() {
		return getSessionFactory().getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Score> findByKeyWords(String keywords) {
		String sql = "select * from t_score where stu_name = ? or tch_name = ?";
		Query query = getSession().createSQLQuery(sql).addEntity(Score.class).
				setString(0, keywords).setString(1, keywords);
		return query.list();
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

}
