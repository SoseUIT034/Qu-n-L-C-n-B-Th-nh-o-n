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

import com.springmvc.qlcb.model.Role;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.Trinhdochinhtri;

@Repository
public class RoleDAOImpl extends HibernateUtils implements RoleDAO {

	 

	@Override
	public Role getTKById(int id) {
		  return getSession().get(Role.class, id);
		 
	}
}
