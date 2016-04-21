package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Taikhoan;

public interface UserService {
	public void saveUser(Taikhoan user);

	public List<Taikhoan> listUser();

	public Taikhoan getUser(Taikhoan user);

	public void deleteUser(Taikhoan user);
}
