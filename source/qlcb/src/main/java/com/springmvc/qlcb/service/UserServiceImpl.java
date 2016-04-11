package com.springmvc.qlcb.service;

import com.springmvc.qlcb.dao.UserDAO;
import com.springmvc.qlcb.dao.UserDAOImpl;
import com.springmvc.qlcb.model.User;

public class UserServiceImpl implements UserService {

	private UserDAOImpl userdao = new UserDAOImpl() ;
	
	@Override
	public boolean CheckUser(User user) {
		 
		if(null!= user)
		{
			User res = userdao.getUser(user.getUsername());
			 if(res!=null)
			 {
				 if(res.getPassword()==user.getPassword())
				 {
					 return true;
				 }
			 }
			 else 
			 {
				return false;
			 }
		}
		else
		{
			return false;
		}
		
		return false;
	}

}
