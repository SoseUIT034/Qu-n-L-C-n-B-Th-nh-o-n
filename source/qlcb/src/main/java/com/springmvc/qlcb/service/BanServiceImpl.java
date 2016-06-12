package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.BanDAO;
import com.springmvc.qlcb.model.Ban;

@Service
public class BanServiceImpl implements BanService {

	@Autowired
	private BanDAO banDAO;
	
	@Override
	@Transactional
	public int save(Ban ban) {
		return banDAO.save(ban);
	}

	@Override
	@Transactional
	public Ban getBanById(int id) {
		return banDAO.getBanById(id);
	}

	@Override
	@Transactional
	public void update(Ban ban) {
		banDAO.update(ban);
	}

	@Override
	@Transactional
	public void delete(int id) {
		banDAO.delete(id);
	}

	@Override
	@Transactional
	public List<Ban> listBan() {
		return banDAO.listBan();
	}

	@Override
	@Transactional
	public List<Ban> listBanByDonVi(int id) {
		// TODO Auto-generated method stub
		return banDAO.listBanByDonVi(id);
	}

}
