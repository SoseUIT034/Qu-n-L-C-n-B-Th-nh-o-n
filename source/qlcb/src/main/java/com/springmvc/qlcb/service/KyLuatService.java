package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Kyluat;

public interface KyLuatService {
	public int save(Kyluat kyluat);
	public Kyluat getKyLuatById(int id);
	public void update(Kyluat kyluat);
	public void delete(int id);
	public List<Kyluat> listKyLuat();
}
