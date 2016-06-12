package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Khoi;;

public interface KhoiService {
	public int save(Khoi khoi);
	public Khoi getKhoiById(int id);
	public void update(Khoi khoi);
	public void delete(int id);
	public List<Khoi> listKhoi();
}
