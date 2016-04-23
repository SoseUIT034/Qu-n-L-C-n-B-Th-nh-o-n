package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Chucvuban;

@Repository
public class ChucVuBanDAOImpl extends HibernateUtils implements ChucvuBanDAO {

	@Override
	public int save(Chucvuban chucvuban) {
		return (Integer) getSession().save(chucvuban);
	}

	@Override
	public Chucvuban getChucvuBanById(int id) {
		return getSession().get(Chucvuban.class, id);
	}

	@Override
	public void update(Chucvuban chucvuban) {
		getSession().merge(chucvuban);
	}

	@Override
	public void delete(int id) {
		Chucvuban chucvuban = getChucvuBanById(id);
		getSession().delete(chucvuban);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Chucvuban> listChucvuBan() {
		return getSession().createCriteria(Chucvuban.class).list();
	}

}
