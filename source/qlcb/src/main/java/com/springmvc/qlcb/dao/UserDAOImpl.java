package com.springmvc.qlcb.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Taikhoan;

@Repository
public class UserDAOImpl extends HibernateUtils implements UserDAO {

	@Override
	public void saveUser(Taikhoan tk) {
		 getSession().save(tk);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Taikhoan> listUser() {
		return getSession().createCriteria(Taikhoan.class).list();
	}

	@Override
	public Taikhoan getUser(Taikhoan tk) {
		
		 
		
		List<Taikhoan> v = listUser();
		for (Taikhoan item : v) {
			if(tk.getUsername().equals(item.getUsername()) && tk.getUsername().equals( item.getUsername()))
			{
				return item;
			}
		}
		
		
		
		
		 return null;
	}

	@Override
	public void deleteUser(Taikhoan tk) {

	}

	@Override
	public Taikhoan getUserByName(String username) {
		Criteria criteria = getSession().createCriteria(Taikhoan.class);
		criteria.add(Restrictions.eq("username", username));		
		return (Taikhoan) criteria.uniqueResult();
	}

	@Override
	public void editUser(Taikhoan user) {
		// TODO Auto-generated method stub
		
	}
}
