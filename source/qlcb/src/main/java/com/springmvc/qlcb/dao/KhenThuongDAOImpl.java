package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Khenthuong;

@Repository
public class KhenThuongDAOImpl extends HibernateUtils implements KhenThuongDAO {

	@Override
	public int save(Khenthuong khenthuong) {
		return (Integer) getSession().save(khenthuong);
	}

	@Override
	public Khenthuong getKhenThuongById(int id) {
		return getSession().get(Khenthuong.class, id);
	}

	@Override
	public void update(Khenthuong khenthuong) {
		getSession().merge(khenthuong);
	}

	@Override
	public void delete(int id) {
		Khenthuong khenthuong = getKhenThuongById(id);
		getSession().delete(khenthuong);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Khenthuong> listKhenThuong() {
		return getSession().createCriteria(Khenthuong.class).list();
	}

}
