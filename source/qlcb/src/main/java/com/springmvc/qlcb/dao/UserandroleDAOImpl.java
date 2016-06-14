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
import com.springmvc.qlcb.model.usersandroles;

@Repository
public class UserandroleDAOImpl extends HibernateUtils implements UserandroleDAO {

	@Override
	public void saveUser(usersandroles tk) {
		 getSession().save(tk);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<usersandroles> listUser() {
		return getSession().createCriteria(usersandroles.class).list();
	}

	@Override
	public usersandroles getUser(usersandroles tk) {
		
		 
		
		
		
		
		
		
		 return null;
	}

	@Override
	public void deleteUser(int id) {
			usersandroles r = getUserByIdCanBo(id);
			getSession().delete(r);
	}

 

	@Override
	public void editUser(usersandroles user) {
		getSession().merge(user);
		
	}

	@Override
	public usersandroles getUserByIdCanBo(int id) {
		List<usersandroles> r =  listUser();
		for (usersandroles item : r) {
			if(item.getTaikhoan().getMaCanBo()==id)
				return item;
		}
		
		return null;
	}
}
