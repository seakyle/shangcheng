package service;

import org.springframework.stereotype.Repository;

import entity.Admin;

@Repository
public interface IAdminService extends IBaseService<Admin>{
	
	public Admin checkLogin(Admin admin);
	
}
