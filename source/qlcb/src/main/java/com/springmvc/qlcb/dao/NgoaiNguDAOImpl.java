package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Ngoaingu;

@Repository
public class NgoaiNguDAOImpl extends HibernateUtils implements NgoaiNguDAO {

	@Override
	public int save(Ngoaingu ngoaingu) {
		return (Integer) getSession().save(ngoaingu);
	}

	@Override
	public Ngoaingu getNgoaiNguById(int id) {
		return getSession().get(Ngoaingu.class, id);
	}

	@Override
	public void update(Ngoaingu ngoaingu) {
		getSession().merge(ngoaingu);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getNgoaiNguById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Ngoaingu> listNgoaiNgu() {
		return getSession().createCriteria(Ngoaingu.class).list();
	}

}
