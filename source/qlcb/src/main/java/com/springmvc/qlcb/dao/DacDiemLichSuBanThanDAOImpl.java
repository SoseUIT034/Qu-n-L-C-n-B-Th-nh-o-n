package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Dacdienlichsubanthan;

@Repository
public class DacDiemLichSuBanThanDAOImpl extends HibernateUtils implements DacDiemLichSuBanThanDAO {

	@Override
	public int save(Dacdienlichsubanthan dacdienlichsubanthan) {
		return (Integer) getSession().save(dacdienlichsubanthan);
	}

	@Override
	public Dacdienlichsubanthan getDacDiemLichSuBanThanById(int id) {
		return getSession().get(Dacdienlichsubanthan.class, id);
	}

	@Override
	public void update(Dacdienlichsubanthan dacdienlichsubanthan) {
		getSession().merge(dacdienlichsubanthan);
	}

	@Override
	public void delete(int id) {
		Dacdienlichsubanthan dacdienlichsubanthan = getDacDiemLichSuBanThanById(id);
		getSession().delete(dacdienlichsubanthan);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dacdienlichsubanthan> listDacDiemLichSuBanThan() {
		return getSession().createCriteria(Dacdienlichsubanthan.class).list();
	}

}
