package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Trinhdochuyenmon;

@Repository
public class TrinhDoChuyenMonDAOImpl extends HibernateUtils implements TrinhDoChuyenMonDAO {

	@Override
	public int save(Trinhdochuyenmon trinhdochuyenmon) {
		return (Integer) getSession().save(trinhdochuyenmon);
	}

	@Override
	public Trinhdochuyenmon getTrinhDoChuyenMonById(int id) {
		return getSession().get(Trinhdochuyenmon.class, id);
	}

	@Override
	public void update(Trinhdochuyenmon trinhdochuyenmon) {
		getSession().merge(trinhdochuyenmon);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getTrinhDoChuyenMonById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Trinhdochuyenmon> listTrinhDoChuyenMon() {
		return getSession().createCriteria(Trinhdochuyenmon.class).list();
	}

}
