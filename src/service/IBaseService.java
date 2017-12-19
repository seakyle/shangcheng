package service;

import java.util.List;

import org.hibernate.Session;

public interface IBaseService<T> {
	
	public void saveOrUpdate(T t);    //�����޸�
	
	public void delete(T t);    //ɾ��
	
	public List<T> findAll();      //��ѯȫ��
	
	public T findById(int id);    //����id��ѯ
	
	public Session getSession();  //��ȡ��ǰ��Session
	
	public List<T> findByKeyWords(String keywords);//�ؼ��ֲ�ѯ
}
