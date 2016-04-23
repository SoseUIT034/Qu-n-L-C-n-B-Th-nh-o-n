package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Loaiquanhe;

@Repository
public class LoaiQuanHeDAOImpl extends HibernateUtils implements LoaiQuanHeDAO {

	@Override
	public int save(Loaiquanhe loaiquanhe) {
		return (Integer) getSession().save(loaiquanhe);
	}

	@Override
	public Loaiquanhe getLoaiQuanHeById(int id) {
		return getSession().get(Loaiquanhe.class, id);
	}

	@Override
	public void update(Loaiquanhe loaiquanhe) {
		getSession().merge(loaiquanhe);
	}

	@Override
	public void delete(int id) {
		Loaiquanhe loaiquanhe = getLoaiQuanHeById(id);
		getSession().delete(loaiquanhe);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Loaiquanhe> listLoaiQuanHe() {
		return getSession().createCriteria(Loaiquanhe.class).list();
	}

}
