package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Kyluat;

@Repository
public class KyLuatDAOImpl extends HibernateUtils implements KyLuatDAO {

	@Override
	public int save(Kyluat kyluat) {
		return (Integer) getSession().save(kyluat);
	}

	@Override
	public Kyluat getKyLuatById(int id) {
		return getSession().get(Kyluat.class, id);
	}

	@Override
	public void update(Kyluat kyluat) {
		getSession().merge(kyluat);
	}

	@Override
	public void delete(int id) {
		Kyluat kyluat = getKyLuatById(id);
		getSession().delete(kyluat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Kyluat> listKyLuat() {
		return getSession().createCriteria(Kyluat.class).list();
	}

}
