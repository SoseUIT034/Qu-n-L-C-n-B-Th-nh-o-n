package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Tongiao;

@Repository
public class TonGiaoDAOImpl extends HibernateUtils implements TonGiaoDAO {

	@Override
	public int save(Tongiao tongiao) {
		return (Integer) getSession().save(tongiao);
	}

	@Override
	public Tongiao getTonGiaoById(int id) {
		return getSession().get(Tongiao.class, id);
	}

	@Override
	public void update(Tongiao tongiao) {
		getSession().merge(tongiao);
	}

	@Override
	public void delete(int id) {
		getSession().delete(getTonGiaoById(id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tongiao> listTonGiao() {
		return getSession().createCriteria(Tongiao.class).list();
	}

}
