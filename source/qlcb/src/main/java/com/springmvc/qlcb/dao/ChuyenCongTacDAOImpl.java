package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Chuyencongtac;

@Repository
public class ChuyenCongTacDAOImpl extends HibernateUtils implements ChuyenCongTacDAO {

	@Override
	public int save(Chuyencongtac chuyencongtac) {
		return (Integer) getSession().save(chuyencongtac);
	}

	@Override
	public Chuyencongtac getChuyenCongTacById(int id) {
		return getSession().get(Chuyencongtac.class, id);
	}

	@Override
	public void update(Chuyencongtac chuyencongtac) {
		getSession().merge(chuyencongtac);
	}

	@Override
	public void delete(int id) {
		Chuyencongtac chuyencongtac = getChuyenCongTacById(id);
		getSession().delete(chuyencongtac);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Chuyencongtac> listChuyenCongTac() {
		return getSession().createCriteria(Chuyencongtac.class).list();
	}

}
