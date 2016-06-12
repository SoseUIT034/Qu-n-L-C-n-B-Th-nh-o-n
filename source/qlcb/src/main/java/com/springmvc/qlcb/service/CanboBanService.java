package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.CanboBan;
import com.springmvc.qlcb.model.CanboBanId;

public interface CanboBanService {
	public Object save(CanboBan canboBan);
	public void update(CanboBan canboBan);
	public void delete(CanboBanId id);
	public CanboBan getCanboBan(CanboBanId id);
	public List<CanboBan> listCanboBan();
	List<CanboBan> listCanBoBanByCanBo(int id);
	CanboBan getCanboBan(int idcanbo, int idban, int idchucvu);
}
