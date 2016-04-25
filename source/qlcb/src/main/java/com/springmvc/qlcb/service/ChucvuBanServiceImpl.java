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
		return 0;
	}

	@Override
	@Transactional
	public Chucvuban getChucvuBanById(int id) {
		return null;
	}

	@Override
	@Transactional
	public void update(Chucvuban chucvuban) {
		
	}

	@Override
	@Transactional
	public void delete(int id) {
		
	}

	@Override
	@Transactional
	public List<Chucvuban> listChucvuBan() {
		return null;
	}
	
}
