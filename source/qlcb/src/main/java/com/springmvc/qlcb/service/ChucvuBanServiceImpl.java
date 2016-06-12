package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.ChucvuBanDAO;
import com.springmvc.qlcb.model.Chucvuban;

@Service
public class ChucvuBanServiceImpl implements ChucvuBanService {
	
	@Autowired
	private ChucvuBanDAO chucvuBanDAO;

	@Override
	@Transactional
	public int save(Chucvuban chucvuban) {
		return chucvuBanDAO.save(chucvuban);
	}

	@Override
	@Transactional
	public Chucvuban getChucvuBanById(int id) {
		return chucvuBanDAO.getChucvuBanById(id);
	}

	@Override
	@Transactional
	public void update(Chucvuban chucvuban) {
		chucvuBanDAO.update(chucvuban);
	}

	@Override
	@Transactional
	public void delete(int id) {
		chucvuBanDAO.delete(id);
	}

	@Override
	@Transactional
	public List<Chucvuban> listChucvuBan() {
		return chucvuBanDAO.listChucvuBan();
	}
	
}
