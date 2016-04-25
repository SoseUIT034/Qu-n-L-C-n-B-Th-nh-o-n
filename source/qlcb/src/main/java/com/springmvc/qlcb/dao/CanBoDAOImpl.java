package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Canbo;

@Repository
public class CanBoDAOImpl extends HibernateUtils implements CanBoDAO {

	@Override
	public int save(Canbo canBo) {
		return (Integer)getSession().save(canBo);
	}

	@Override
	public Canbo getCanBoById(int id) {
		return getSession().get(Canbo.class, id);
	}

	@Override
	public void update(Canbo canBo) {
		getSession().merge(canBo);
	}

	@Override
	public void delete(int id) {
		Canbo canBo = getCanBoById(id);
		getSession().delete(canBo);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Canbo> listCanBo() {
		return getSession().createCriteria(Canbo.class).list();
	}

}
