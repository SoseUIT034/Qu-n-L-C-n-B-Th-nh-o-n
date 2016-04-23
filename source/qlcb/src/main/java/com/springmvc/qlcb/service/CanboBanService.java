package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.CanboBan;

public interface CanboBanService {
	public int save(CanboBan canboBan);
	public void update(CanboBan canboBan);
	public void delete(int id);
	public CanboBan getCanboBan(int id);
	public List<CanboBan> listCanboBan();
}
