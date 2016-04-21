package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.UserDAO;
import com.springmvc.qlcb.model.Taikhoan;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;

	public void saveUser(Taikhoan user) {
		
	}

	public List<Taikhoan> listUser() {
		return null;
	}

	@Transactional
	public Taikhoan getUser(Taikhoan user) {
		return userDAO.getUser(user);
	}
	public void deleteUser(Taikhoan user) {
		
	}
	
	
}
