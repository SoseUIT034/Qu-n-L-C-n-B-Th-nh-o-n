package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Quanhe;

public interface QuanHeDAO {
	public int save(Quanhe quanhe);
	public Quanhe getQuanHeById(int id);
	public void update(Quanhe quanhe);
	public void delete(int id);
	public List<Quanhe> listQuanHe();
}
