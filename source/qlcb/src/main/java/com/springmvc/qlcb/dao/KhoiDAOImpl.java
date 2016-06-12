package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Donvi;
import com.springmvc.qlcb.model.Khoi;

@Repository
public class KhoiDAOImpl extends HibernateUtils implements KhoiDAO {

	@Override
	public int save(Khoi khoi) {
		return (Integer) getSession().save(khoi);
	}

	@Override
	public Khoi getKhoiById(int id) {
		return getSession().get(Khoi.class, id);
	}

	@Override
	public void update(Khoi khoi) {
		getSession().merge(khoi);
	}

	@Override
	public void delete(int id) {
		Khoi khoi = getKhoiById(id);
		getSession().delete(khoi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Khoi> listKhoi() {
		return getSession().createCriteria(Khoi.class).list();
	}

}
