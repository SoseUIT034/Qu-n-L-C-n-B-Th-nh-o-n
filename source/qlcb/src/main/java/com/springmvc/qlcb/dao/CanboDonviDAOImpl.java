package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.CanboDonvi;

@Repository
public class CanboDonviDAOImpl extends HibernateUtils implements CanboDonviDAO {

	@Override
	public int save(CanboDonvi canboDonvi) {
		return (Integer) getSession().save(canboDonvi);
	}

	@Override
	public CanboDonvi getCanboDonviById(int id) {
		return getSession().get(CanboDonvi.class, id);
	}

	@Override
	public void update(CanboDonvi canboDonvi) {
		getSession().merge(canboDonvi);
	}

	@Override
	public void delete(int id) {
		CanboDonvi canboDonvi = getCanboDonviById(id);
		getSession().delete(canboDonvi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CanboDonvi> listCanboDonvi() {
		return getSession().createCriteria(CanboDonvi.class).list();
	}

}
