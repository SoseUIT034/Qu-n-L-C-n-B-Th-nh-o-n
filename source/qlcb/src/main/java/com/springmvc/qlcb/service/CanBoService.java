package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Canbo;

public interface CanBoService {
	public int save(Canbo canBo);
	public Canbo getCanBoById(int id);
	public void update(Canbo canBo);
	public void delete(int id);
	public List<Canbo> listCanBo();
}
