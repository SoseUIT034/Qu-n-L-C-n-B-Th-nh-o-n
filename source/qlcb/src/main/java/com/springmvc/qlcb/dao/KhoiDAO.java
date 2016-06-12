package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Donvi;
import com.springmvc.qlcb.model.Khoi;;

public interface KhoiDAO {
	public int save(Khoi khoi);
	public Khoi getKhoiById(int id);
	public void update(Khoi khoii);
	public void delete(int id);
	public List<Khoi> listKhoi();
}
