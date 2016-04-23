package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Lylich;

@Repository
public class LyLichDAOImpl extends HibernateUtils implements LyLichDAO {

	@Override
	public int save(Lylich lylich) {
		return (Integer) getSession().save(lylich);
	}

	@Override
	public Lylich getLyLichById(int id) {
		return getSession().get(Lylich.class, id);
	}

	@Override
	public void update(Lylich lylich) {
		getSession().merge(lylich);
	}

	@Override
	public void delete(int id) {
		Lylich lylich = getLyLichById(id);
		getSession().delete(lylich);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Lylich> listLyLich() {
		return getSession().createCriteria(Lylich.class).list();
	}

}
