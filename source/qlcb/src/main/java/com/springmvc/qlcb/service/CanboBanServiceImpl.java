package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.CanboBanDAO;
import com.springmvc.qlcb.model.CanboBan;

@Repository
public class CanboBanServiceImpl implements CanboBanService {

	@Autowired
	private CanboBanDAO canboBanDAO;
	
	@Override
	@Transactional
	public int save(CanboBan canboBan) {
		return canboBanDAO.save(canboBan);
	}

	@Override
	@Transactional
	public void update(CanboBan canboBan) {
		canboBanDAO.update(canboBan);
	}

	@Override
	@Transactional
	public void delete(int id) {
		canboBanDAO.delete(id);
	}

	@Override
	@Transactional
	public CanboBan getCanboBan(int id) {
		return canboBanDAO.getCanboBan(id);
	}

	@Override
	@Transactional
	public List<CanboBan> listCanboBan() {
		return canboBanDAO.listCanboBan();
	}

}
