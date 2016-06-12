package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.ChucvuDonviDAO;
import com.springmvc.qlcb.model.Chucvudonvi;
@Service
@Transactional
public class ChucVuDonViServiceImpl implements ChucvuDonviService {

	@Autowired
	ChucvuDonviDAO _chucVuDonViDao;
	
	@Override
	public int save(Chucvudonvi chucvudonvi) {
		// TODO Auto-generated method stub
		return _chucVuDonViDao.save(chucvudonvi);
	}

	@Override
	public Chucvudonvi getByChucvuDonviId(int id) {
		// TODO Auto-generated method stub
		return _chucVuDonViDao.getByChucvuDonviId(id);
	}

	@Override
	public void update(Chucvudonvi chucvudonvi) {
		// TODO Auto-generated method stub
		_chucVuDonViDao.update(chucvudonvi);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		_chucVuDonViDao.delete(id);
	}

	@Override
	public List<Chucvudonvi> listChucvuDonvi() {
		// TODO Auto-generated method stub
		return _chucVuDonViDao.listChucvuDonvi();
	}

}
