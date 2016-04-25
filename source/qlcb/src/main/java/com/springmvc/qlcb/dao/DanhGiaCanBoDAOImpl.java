package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Danhgiacanbo;

@Repository
public class DanhGiaCanBoDAOImpl extends HibernateUtils implements DanhGiaCanBoDAO {

	@Override
	public int save(Danhgiacanbo danhgiacanbo) {
		return (Integer) getSession().save(danhgiacanbo);
	}

	@Override
	public Danhgiacanbo getDanhGiaCanBoById(int id) {
		return getSession().get(Danhgiacanbo.class, id);
	}

	@Override
	public void update(Danhgiacanbo danhgiacanbo) {
		getSession().merge(danhgiacanbo);
	}

	@Override
	public void delete(int id) {
		Danhgiacanbo danhgiacanbo = getDanhGiaCanBoById(id);
		getSession().delete(danhgiacanbo);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Danhgiacanbo> listDanhGiaCanBo() {
		return getSession().createCriteria(Danhgiacanbo.class).list();
	}

}
