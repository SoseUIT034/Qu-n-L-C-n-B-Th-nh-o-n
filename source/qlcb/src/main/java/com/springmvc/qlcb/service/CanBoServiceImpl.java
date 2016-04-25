package com.springmvc.qlcb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.CanBoDAO;
import com.springmvc.qlcb.model.Canbo;

@Service
public class CanBoServiceImpl implements CanBoService {

	@Autowired
	private CanBoDAO canBoDAO;
	
	@Override
	@Transactional
	public int save(Canbo canBo) {
		return canBoDAO.save(canBo);
	}

	@Override
	@Transactional
	public Canbo getCanBoById(int id) {
		return canBoDAO.getCanBoById(id);
	}

	@Override
	@Transactional
	public void update(Canbo canBo) {
		canBoDAO.update(canBo);
	}

	@Override
	@Transactional
	public void delete(int id) {
		canBoDAO.delete(id);
	}

	@Override
	@Transactional
	public List<Canbo> listCanBo() {
		return canBoDAO.listCanBo();
	}

}
