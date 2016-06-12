package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.CanboDonvi;
import com.springmvc.qlcb.model.CanboDonviId;

public interface CanboDonviDAO {
	public Object save(CanboDonvi canboDonvi);
	public CanboDonvi getCanboDonviById(CanboDonviId id);
	public void update(CanboDonvi canboDonvi);
	public void delete(CanboDonviId id);
	public List<CanboDonvi> listCanboDonvi();
	List<CanboDonvi> listCanBoDonViByCanBo(int id);
	CanboDonvi getCanboDonvi(int idcanbo, int iddonvi, int idchucvu);
}