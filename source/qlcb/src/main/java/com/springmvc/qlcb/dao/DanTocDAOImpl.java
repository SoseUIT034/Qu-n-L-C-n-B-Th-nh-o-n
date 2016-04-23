package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Dantoc;

@Repository
public class DanTocDAOImpl extends HibernateUtils implements DanTocDAO {

	@Override
	public int save(Dantoc dantoc) {
		return (Integer) getSession().save(dantoc);
	}

	@Override
	public Dantoc getDanTocById(int id) {
		return getSession().get(Dantoc.class, id);
	}

	@Override
	public void update(Dantoc dantoc) {
		getSession().merge(dantoc);
	}

	@Override
	public void delete(int id) {
		Dantoc dantoc = getDanTocById(id);
		getSession().delete(dantoc);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dantoc> listDanToc() {
		return getSession().createCriteria(Dantoc.class).list();
	}

}
