package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.CanboGiadinhBanthan;
import com.springmvc.qlcb.model.CanboGiadinhDoitac;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Dienbienluong;

@Repository
public class CanBoGiaDinhDoiTacDAOImp extends HibernateUtils implements CanBoGiaDinhDoiTacDAO {

	 
 

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		
	} 
	
	@Override
	public int save(CanboGiadinhDoitac canboGiadinhDoitac) {
		return (Integer) getSession().save(canboGiadinhDoitac);
	}

	@Override
	public CanboGiadinhDoitac getCanboGiadinhDoitacId(int id) {
		return getSession().get(CanboGiadinhDoitac.class, id);
	}

	@Override
	public void update(CanboGiadinhDoitac canboGiadinhDoitac) {
		getSession().merge( canboGiadinhDoitac);
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<CanboGiadinhDoitac> listcanboGiadinhDoitac() {
		return getSession().createCriteria(CanboGiadinhDoitac.class).list();
	}
}
