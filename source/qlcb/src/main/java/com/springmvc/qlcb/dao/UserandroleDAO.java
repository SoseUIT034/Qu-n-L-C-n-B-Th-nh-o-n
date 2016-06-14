package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.usersandroles;


public interface UserandroleDAO {
	public void saveUser(usersandroles user);

	public List<usersandroles> listUser();

	public usersandroles getUser(usersandroles user);

	public void deleteUser(int id);
	
	public usersandroles getUserByIdCanBo(int id);
	
	public void editUser(usersandroles user);
}
