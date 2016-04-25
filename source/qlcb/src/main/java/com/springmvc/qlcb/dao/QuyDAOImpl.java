package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Quy;

@Repository
public class QuyDAOImpl extends HibernateUtils implements QuyDAO {

	@Override
	public int save(Quy quy) {
		return (Integer) getSession().save(quy);
	}

	@Override
	public Quy getQuyById(int id) {
		return getSession().get(Quy.class, id);
	}

	@Override
	public void update(Quy quy) {
		getSession().merge(quy);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getQuyById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Quy> listQuy() {
		return getSession().createCriteria(Quy.class).list();
	}
	
}
