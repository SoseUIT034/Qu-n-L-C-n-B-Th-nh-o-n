package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Thanhviengiadinh;

@Repository
public class ThanhVienGiaDinhDAOImpl extends HibernateUtils implements ThanhVienGiaDinhDAO {

	@Override
	public int save(Thanhviengiadinh thanhviengiadinh) {
		return (Integer) getSession().save(thanhviengiadinh);
	}

	@Override
	public Thanhviengiadinh getThanhVienGiaDinhById(int id) {
		return getSession().get(Thanhviengiadinh.class, id);
	}

	@Override
	public void update(Thanhviengiadinh thanhviengiadinh) {
		getSession().merge(thanhviengiadinh);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getThanhVienGiaDinhById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Thanhviengiadinh> listThanhVienGiaDinh() {
		return getSession().createCriteria(Thanhviengiadinh.class).list();
	}

}
