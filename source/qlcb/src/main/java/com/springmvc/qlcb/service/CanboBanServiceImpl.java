package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.CanboBanDAO;
import com.springmvc.qlcb.model.CanboBan;
import com.springmvc.qlcb.model.CanboBanId;
import com.springmvc.qlcb.model.CanboDonviId;

@Service
public class CanboBanServiceImpl implements CanboBanService {

	@Autowired
	private CanboBanDAO canboBanDAO;
	
	@Override
	@Transactional
	public Object save(CanboBan canboBan) {
		return canboBanDAO.save(canboBan);
	}

	@Override
	@Transactional
	public void update(CanboBan canboBan) {
		canboBanDAO.update(canboBan);
	}

	@Override
	@Transactional
	public CanboBan getCanboBan(CanboBanId id) {
		return canboBanDAO.getCanboBan(id);
	}

	@Override
	@Transactional
	public List<CanboBan> listCanboBan() {
		return canboBanDAO.listCanboBan();
	}

	@Override
	@Transactional
	public List<CanboBan> listCanBoBanByCanBo(int id) {
		// TODO Auto-generated method stub
		return canboBanDAO.listCanBoBanByCanBo(id);
	}

	@Override
	@Transactional
	public CanboBan getCanboBan(int idcanbo, int idban, int idchucvu) {
		// TODO Auto-generated method stub
		return canboBanDAO.getCanBoBan(idcanbo, idban, idchucvu);
	}

	@Override
	@Transactional
	public void delete(CanboBanId id) {
		canboBanDAO.delete(id);
		
	}

}
