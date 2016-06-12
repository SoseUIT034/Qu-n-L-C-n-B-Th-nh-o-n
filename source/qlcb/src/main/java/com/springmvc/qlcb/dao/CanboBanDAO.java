package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.CanboBan;
import com.springmvc.qlcb.model.CanboBanId;

public interface CanboBanDAO {
	public Object save(CanboBan canboBan);
	public void update(CanboBan canboBan);
	public void delete(CanboBanId id);
	public CanboBan getCanboBan(CanboBanId id);
	public List<CanboBan> listCanboBan();
	List<CanboBan> listCanBoBanByCanBo(int id);
	CanboBan getCanBoBan(int idcanbo, int idban, int idchucvu);
}
