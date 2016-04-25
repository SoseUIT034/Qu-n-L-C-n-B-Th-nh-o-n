package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Chucvudonvi;

@Repository
public class ChucvuDonviDAOImpl extends HibernateUtils implements ChucvuDonviDAO {

	@Override
	public int save(Chucvudonvi chucvudonvi) {
		return (Integer) getSession().save(chucvudonvi);
	}

	@Override
	public Chucvudonvi getByChucvuDonviId(int id) {
		return getSession().get(Chucvudonvi.class, id);
	}

	@Override
	public void update(Chucvudonvi chucvudonvi) {
		getSession().merge(chucvudonvi);
	}

	@Override
	public void delete(int id) {
		Chucvudonvi chucvudonvi = getByChucvuDonviId(id);
		getSession().delete(chucvudonvi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Chucvudonvi> listChucvuDonvi() {
		return getSession().createCriteria(Chucvudonvi.class).list();
	}

}
