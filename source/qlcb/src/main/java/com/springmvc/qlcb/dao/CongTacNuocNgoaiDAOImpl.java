package com.springmvc.qlcb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.springmvc.qlcb.model.Congtacnuocngoai;

@Repository
public class CongTacNuocNgoaiDAOImpl extends HibernateUtils implements CongTacNuocNgoaiDAO {

	@Override
	public int save(Congtacnuocngoai congtacnuocngoai) {
		return (Integer) getSession().save(congtacnuocngoai);
	}

	@Override
	public Congtacnuocngoai getCongTacNuocNgoaiById(int id) {
		return getSession().get(Congtacnuocngoai.class, id);
	}

	@Override
	public void update(Congtacnuocngoai congtacnuocngoai) {
		getSession().merge(congtacnuocngoai);
	}

	@Override
	public void delete(int id) {
		Congtacnuocngoai congtacnuocngoai = getCongTacNuocNgoaiById(id);
		getSession().delete(congtacnuocngoai);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Congtacnuocngoai> listCongTacNuocNgoai() {
		return getSession().createCriteria(Congtacnuocngoai.class).list();
	}

}
