package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.CanboBan;

@Repository
public class CanboBanDAOImpl extends HibernateUtils implements CanboBanDAO {

	@Override
	public int save(CanboBan canboBan) {
		return (Integer) getSession().save(canboBan);
	}

	@Override
	public void update(CanboBan canboBan) {
		getSession().merge(canboBan);
	}

	@Override
	public void delete(int id) {
		CanboBan canboBan = getCanboBan(id);
		getSession().delete(canboBan);
	}

	@Override
	public CanboBan getCanboBan(int id) {
		return getSession().get(CanboBan.class, id);
	}

	@Override
	public List<CanboBan> listCanboBan() {
		return getSession().createCriteria(CanboBan.class).list();
	}

}
