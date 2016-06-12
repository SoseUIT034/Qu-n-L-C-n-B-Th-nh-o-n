package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Tongiao;
import com.springmvc.qlcb.model.Trinhdochinhtri;

@Repository
public class TrinhDoChinhTriDAOImpl extends HibernateUtils implements TrinhDoChinhTriDAO {

	@Override
	public int save(Trinhdochinhtri trinhdochinhtri) {
		return (Integer) getSession().save(trinhdochinhtri);
	}

	@Override
	public Trinhdochinhtri getTrinhDoChinhTriById(int id) {
		return getSession().get(Trinhdochinhtri.class, id);
	}

	@Override
	public void update(Trinhdochinhtri trinhdochinhtri) {
		getSession().merge(trinhdochinhtri);
		
	} 
	@Override
	public void delete(int id) {
		getSession().delete(getTrinhDoChinhTriById(id));
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Trinhdochinhtri> listTrinhDoChinhTri() {
		return getSession().createCriteria(Trinhdochinhtri.class).list(); 
	}

}
