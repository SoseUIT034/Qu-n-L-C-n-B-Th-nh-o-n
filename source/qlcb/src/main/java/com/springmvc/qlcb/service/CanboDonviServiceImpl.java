package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.CanboDonviDAO;
import com.springmvc.qlcb.model.CanboDonvi;
import com.springmvc.qlcb.model.CanboDonviId;

@Service
@Transactional
public class CanboDonviServiceImpl implements CanboDonviService {

	@Autowired
	CanboDonviDAO _canboDonviDAO;
	
	@Override
	public Object save(CanboDonvi canboDonvi) {
		// TODO Auto-generated method stub
		return _canboDonviDAO.save(canboDonvi);
	}

	@Override
	public CanboDonvi getCanboDonviById(CanboDonviId id) {
		// TODO Auto-generated method stub
		return _canboDonviDAO.getCanboDonviById(id);
	}

	@Override
	public void update(CanboDonvi canboDonvi) {
		// TODO Auto-generated method stub
		_canboDonviDAO.update(canboDonvi);
	}

	@Override
	public void delete(CanboDonviId id) {
		// TODO Auto-generated method stub
		_canboDonviDAO.delete(id);
	}

	@Override
	public List<CanboDonvi> listCanboDonvi() {
		// TODO Auto-generated method stub
		return _canboDonviDAO.listCanboDonvi();
	}

	@Override
	public List<CanboDonvi> listCanboDonviByCanBo(int id) {
		// TODO Auto-generated method stub
		return _canboDonviDAO.listCanBoDonViByCanBo(id);
	}

	@Override
	public CanboDonvi getCanboDonvi(int idcanbo, int iddonvi, int idchucvu) {
		// TODO Auto-generated method stub
		return _canboDonviDAO.getCanboDonvi(idcanbo, iddonvi, idchucvu);
	}

}
