package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Lichsucongtac;

public class LichSuCongTacDAOImpl extends HibernateUtils implements LichSuCongTacDAO {

	@Override
	public int save(Lichsucongtac lichsucongtac) {
		return (Integer) getSession().save(lichsucongtac);
	}

	@Override
	public Lichsucongtac getLichSuCongTacById(int id) {
		return getSession().get(Lichsucongtac.class, id);
	}

	@Override
	public void update(Lichsucongtac lichsucongtac) {
		getSession().merge(lichsucongtac);
	}

	@Override
	public void delete(int id) {
		Lichsucongtac lichsucongtac = getLichSuCongTacById(id);
		getSession().delete(lichsucongtac);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Lichsucongtac> listLichSuCongTac() {
		return getSession().createCriteria(Lichsucongtac.class).list();
	}

}
