package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Loaiquanhe;

public interface LoaiQuanHeService {
	public int save(Loaiquanhe loaiquanhe);
	public Loaiquanhe getLoaiQuanHeById(int id);
	public void update(Loaiquanhe loaiquanhe);
	public void delete(int id);
	public List<Loaiquanhe> listLoaiQuanHe();
}
