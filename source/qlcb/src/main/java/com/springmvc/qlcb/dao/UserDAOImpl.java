package com.springmvc.qlcb.dao;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Taikhoan;

@Repository
public class UserDAOImpl extends HibernateUtils implements UserDAO {

	@Override
	public void saveUser(Taikhoan tk) {
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Taikhoan> listUser() {
		return getSession().createCriteria(Taikhoan.class).list();
	}

	@Override
	public Taikhoan getUser(Taikhoan tk) {
		String hsql = "from Taikhoan as tk where tk.tenDangNhap=? and tk.matKhau=?";
		Query query = getSession().createQuery(hsql);
		query.setParameter(0, tk.getTenDangNhap());
		query.setParameter(1, tk.getMatKhau());
		
		return (Taikhoan) query.uniqueResult();
	}

	@Override
	public void deleteUser(Taikhoan tk) {

	}
}
