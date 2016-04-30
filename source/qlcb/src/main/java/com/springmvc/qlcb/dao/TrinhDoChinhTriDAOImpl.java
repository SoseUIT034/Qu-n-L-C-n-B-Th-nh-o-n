package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Tongiao;
import com.springmvc.qlcb.model.Trinhdochinhtri;

@Repository
public class TrinhDoChinhTriDAOImpl extends HibernateUtils implements TrinhDoChinhTriDAO {

	@Override
	public int save(Trinhdochinhtri trinhdochinhtri) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Trinhdochinhtri getTrinhDoChinhTriById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(Trinhdochinhtri trinhdochinhtri) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Trinhdochinhtri> listTrinhDoChinhTri() {
		return getSession().createCriteria(Trinhdochinhtri.class).list();
	}

}
