package com.springmvc.qlcb.dao;

import java.util.ArrayList;

import com.springmvc.qlcb.model.User;
 

public interface UserDAO {

	 public void saveUser(User user);  
	 
     public ArrayList<User> listUsers();
     
     public User getUser(String username);
     
     public void deleteUser(String username);
}
