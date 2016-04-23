package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.CanboDonvi;

public interface CanboDonviDAO {
	public int save(CanboDonvi canboDonvi);
	public CanboDonvi getCanboDonviById(int id);
	public void update(CanboDonvi canboDonvi);
	public void delete(int id);
	public List<CanboDonvi> listCanboDonvi();
}