package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.CanboGiadinhBanthan;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Dienbienluong;

@Repository
public class CanBoGiaDinhBanThanDAOImp extends HibernateUtils implements CanBoGiaDinhBanThanDAO {

	 
 

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		
	}
 
	@Override
	public int save(CanboGiadinhBanthan canboGiadinhBanthan) {
		return (Integer) getSession().save(canboGiadinhBanthan);
	}

	@Override
	public CanboGiadinhBanthan getCanboGiadinhBanthanById(int id) {
		return getSession().get(CanboGiadinhBanthan.class, id);
	}

	@Override
	public void update(CanboGiadinhBanthan canboGiadinhBanthan) {
		getSession().merge( canboGiadinhBanthan);
		
	}

	@Override
	public List<CanboGiadinhBanthan> listCanboGiadinhBanthan() {
		return getSession().createCriteria(CanboGiadinhBanthan.class).list();
	}
}
