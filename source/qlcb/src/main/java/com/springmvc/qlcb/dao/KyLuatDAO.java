package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Kyluat;

public interface KyLuatDAO {
	public int save(Kyluat kyluat);
	public Kyluat getKyLuatById(int id);
	public void update(Kyluat kyluat);
	public void delete(int id);
	public List<Kyluat> listKyLuat();
}
