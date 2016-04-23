package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Donvi;

@Repository
public class DonViDAOImpl extends HibernateUtils implements DonViDAO {

	@Override
	public int save(Donvi donvi) {
		return (Integer) getSession().save(donvi);
	}

	@Override
	public Donvi getDonViById(int id) {
		return getSession().get(Donvi.class, id);
	}

	@Override
	public void update(Donvi donvi) {
		getSession().merge(donvi);
	}

	@Override
	public void delete(int id) {
		Donvi donvi = getDonViById(id);
		getSession().delete(donvi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Donvi> listDonVi() {
		return getSession().createCriteria(Donvi.class).list();
	}

}
