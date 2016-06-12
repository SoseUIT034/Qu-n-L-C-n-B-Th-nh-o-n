package com.springmvc.qlcb.dao;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.CanboBan;
import com.springmvc.qlcb.model.CanboBanId;

@Repository
public class CanboBanDAOImpl extends HibernateUtils implements CanboBanDAO {

	@Override
	public Object save(CanboBan canboBan) {
		return getSession().save(canboBan);
	}

	@Override
	public void update(CanboBan canboBan) {
		getSession().merge(canboBan);
	}

	@Override
	public void delete(CanboBanId id) {
		CanboBan canboBan = getCanboBan(id);
		getSession().delete(canboBan);
	}

	@Override
	public CanboBan getCanboBan(CanboBanId id) {
		return getSession().get(CanboBan.class, id);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<CanboBan> listCanboBan() {
		return getSession().createCriteria(CanboBan.class).list();
	}

	@Override
	public List<CanboBan> listCanBoBanByCanBo(int id) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("FROM CanboBan WHERE IDCanBo=:id");
		query.setInteger("id",id);
		return query.list();
	}

	@Override
	public CanboBan getCanBoBan(int idcanbo, int idban, int idchucvu) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("FROM CanboBan WHERE IDCanBo=:idcanbo and IDBan=:idban and ChucVu=:idchucvu");
		query.setInteger("idcanbo", idcanbo);
		query.setInteger("idban", idban);
		query.setInteger("idchucvu", idchucvu);
		if (!query.list().isEmpty()) {
			return (CanboBan) query.list().get(0);
		}
		return null;
	}

}
