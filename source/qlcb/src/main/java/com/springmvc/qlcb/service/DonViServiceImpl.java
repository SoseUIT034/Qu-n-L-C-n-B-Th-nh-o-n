package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.DonViDAO;
import com.springmvc.qlcb.model.Donvi;

@Service
@Transactional
public class DonViServiceImpl implements DonViService {

	@Autowired
	DonViDAO _donViDao;
	@Override
	public int save(Donvi donvi) {
		// TODO Auto-generated method stub
		return _donViDao.save(donvi);
		
	}

	@Override
	public Donvi getDonViById(int id) {
		// TODO Auto-generated method stub
		return _donViDao.getDonViById(id);
	}

	@Override
	public void update(Donvi donvi) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Donvi> listDonVi() {
		// TODO Auto-generated method stub
		return _donViDao.listDonVi();
	}

}
