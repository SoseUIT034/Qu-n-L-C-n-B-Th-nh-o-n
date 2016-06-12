package com.springmvc.qlcb.dao;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.CanboDonvi;
import com.springmvc.qlcb.model.CanboDonviId;

@Repository
public class CanboDonviDAOImpl extends HibernateUtils implements CanboDonviDAO {

	@Override
	public Object save(CanboDonvi canboDonvi) {
		return getSession().save(canboDonvi);
	}

	@Override
	public CanboDonvi getCanboDonviById(CanboDonviId id) {
		return getSession().get(CanboDonvi.class, id);
	}

	@Override
	public void update(CanboDonvi canboDonvi) {
		getSession().merge(canboDonvi);
	}

	@Override
	public void delete(CanboDonviId id) {
		CanboDonvi canboDonvi = getCanboDonviById(id);
		getSession().delete(canboDonvi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CanboDonvi> listCanboDonvi() {
		return getSession().createCriteria(CanboDonvi.class).list();
	}

	@Override
	public List<CanboDonvi> listCanBoDonViByCanBo(int id) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("FROM CanboDonvi where MaCanBo=:id");
		query.setInteger("id", id);
		return query.list();
	}

	@Override
	public CanboDonvi getCanboDonvi(int idcanbo, int iddonvi, int idchucvu) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("FROM CanboDonvi WHERE MaCanBo=:idcanbo and MaDonVi=:iddonvi and ChucVu=:idchucvu");
		query.setInteger("idcanbo", idcanbo);
		query.setInteger("iddonvi", iddonvi);
		query.setInteger("idchucvu", idchucvu);
		
		if (!query.list().isEmpty()){
			return (CanboDonvi) query.list().get(0);
		}
		return null;
	}

}
