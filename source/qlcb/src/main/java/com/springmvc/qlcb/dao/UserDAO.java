package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.Trinhdochuyenmon;


public interface UserDAO {
	public void saveUser(Taikhoan user);

	public List<Taikhoan> listUser();

	public Taikhoan getUser(Taikhoan user);
	
	public Taikhoan getTKById(int id);

	public void deleteUser(Taikhoan user);
	
	public Taikhoan getUserByName(String tenDangNhap);
	
	public void editUser(Taikhoan user);
}
