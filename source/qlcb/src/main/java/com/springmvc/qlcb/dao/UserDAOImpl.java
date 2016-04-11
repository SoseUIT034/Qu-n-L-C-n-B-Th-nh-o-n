package com.springmvc.qlcb.dao;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.springmvc.qlcb.model.User;

public class UserDAOImpl  implements UserDAO{

	private SessionFactory sessionFactory;
	
	@Override
	public void saveUser(User user) {
		 
		getSession().merge(user);
	}

	@Override
	public ArrayList<User> listUsers() {
		 
		return   (ArrayList<User>) getSession().createCriteria(User.class).list(); 
	}

	@Override
	public User getUser(String username) {
		 
		return  getSession().get(User.class, username);

	}

	@Override
	public void deleteUser(String username) {
		
		User user = getUser(username);
		
		if(null!= user)
		{
			getSession().delete(user);
		}
 
	}
	
	 private Session getSession() {
		 if(getSessionFactory()== null)
		 {
			 Session sess = getSessionFactory().openSession();
			 return sess;
		 }
		 else
		 {
			 Session sess = getSessionFactory().getCurrentSession();
			 return sess;
		 }
          
	  }
	
	  private SessionFactory getSessionFactory() {
	         return sessionFactory;
	  }

}
