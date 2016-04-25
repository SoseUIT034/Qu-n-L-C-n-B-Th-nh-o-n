package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Mucdohoanthanh;

@Repository
public class MucDoHoanThanhDAOImpl extends HibernateUtils implements MucDoHoanThanhDAO {

	@Override
	public int save(Mucdohoanthanh mucdohoanthanh) {
		return (Integer) getSession().save(mucdohoanthanh);
	}

	@Override
	public Mucdohoanthanh getMucDoHoanThanhById(int id) {
		return getSession().get(Mucdohoanthanh.class, id);
	}

	@Override
	public void update(Mucdohoanthanh mucdohoanthanh) {
		getSession().merge(mucdohoanthanh);
	}

	@Override
	public void delete(int id) {
		Mucdohoanthanh mucdohoanthanh = getMucDoHoanThanhById(id);
		getSession().delete(mucdohoanthanh);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Mucdohoanthanh> listMucDoHoanThanh() {
		return getSession().createCriteria(Mucdohoanthanh.class).list();
	}

}
