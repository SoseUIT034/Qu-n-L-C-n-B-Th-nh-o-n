package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Daotaochuyenmon;

@Repository
public class DaoTaoChuyenMonDAOImpl extends HibernateUtils implements DaoTaoChuyenMonDAO {

	@Override
	public int save(Daotaochuyenmon daotaochuyenmon) {
		return (Integer) getSession().save(daotaochuyenmon);
	}

	@Override
	public Daotaochuyenmon getDaoTaoChuyenMonById(int id) {
		return getSession().get(Daotaochuyenmon.class, id);
	}

	@Override
	public void update(Daotaochuyenmon daotaochuyenmon) {
		getSession().merge(daotaochuyenmon);
	}

	@Override
	public void delete(int id) {
		Daotaochuyenmon daotaochuyenmon = getDaoTaoChuyenMonById(id);
		getSession().delete(daotaochuyenmon);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Daotaochuyenmon> listDaoTaoChuyenMon() {
		return getSession().createCriteria(Daotaochuyenmon.class).list();
	}
	
}
