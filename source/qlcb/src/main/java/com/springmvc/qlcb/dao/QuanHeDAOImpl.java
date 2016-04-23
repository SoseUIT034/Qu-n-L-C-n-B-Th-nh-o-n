package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Quanhe;

@Repository
public class QuanHeDAOImpl extends HibernateUtils implements QuanHeDAO {

	@Override
	public int save(Quanhe quanhe) {
		return (Integer) getSession().save(quanhe);
	}

	@Override
	public Quanhe getQuanHeById(int id) {
		return getSession().get(Quanhe.class, id);
	}

	@Override
	public void update(Quanhe quanhe) {
		getSession().merge(quanhe);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getQuanHeById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Quanhe> listQuanHe() {
		return getSession().createCriteria(Quanhe.class).list();
	}

}
