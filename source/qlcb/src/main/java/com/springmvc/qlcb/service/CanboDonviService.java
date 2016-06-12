package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.CanboDonvi;
import com.springmvc.qlcb.model.CanboDonviId;

public interface CanboDonviService {
	public Object save(CanboDonvi canboDonvi);
	public CanboDonvi getCanboDonviById(CanboDonviId id);
	public void update(CanboDonvi canboDonvi);
	public void delete(CanboDonviId id);
	public List<CanboDonvi> listCanboDonvi();
	List<CanboDonvi> listCanboDonviByCanBo(int id);
	CanboDonvi getCanboDonvi(int idcanbo, int iddonvi, int idchucvu);
}