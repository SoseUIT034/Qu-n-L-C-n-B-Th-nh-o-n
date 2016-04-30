package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Dienbienluong;

@Repository
public class DienBienLuongDAOImp extends HibernateUtils implements DienBienLuongDAO {

	 

	@Override
	public int save(Dienbienluong dienBienLuong) {
		return (Integer) getSession().save(dienBienLuong);
	}

	@Override
	public Dienbienluong getDienbienluongById(int id) {
		return getSession().get(Dienbienluong.class, id);
	}

	@Override
	public void update(Dienbienluong dienBienLuong) {
		getSession().merge( dienBienLuong);
		
	}

	@Override
	public List<Dienbienluong> listDienBienLuong() {
		return getSession().createCriteria(Dienbienluong.class).list();
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		
	}
	
}
