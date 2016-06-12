package com.springmvc.qlcb.dao;

import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Ban;

@Repository
public class BanDAOImpl extends HibernateUtils implements BanDAO {

	public int save(Ban ban) {
		return (Integer) getSession().save(ban);
	}

	@Override
	public Ban getBanById(int id) {
		return getSession().get(Ban.class, id);
	}

	@Override
	public void update(Ban ban) {
		getSession().merge(ban);
	}

	@Override
	public void delete(int id) {
		Ban ban = getBanById(id);
		getSession().delete(ban);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Ban> listBan() {
		return getSession().createCriteria(Ban.class).list();
	}

	@Override
	public List<Ban> listBanByDonVi(int id) {
		// TODO Auto-generated method stub
		 Query query = getSession().createQuery("FROM Ban WHERE MaDonVi=:id");
		 query.setInteger("id", id);
		 return query.list();
	}

}
