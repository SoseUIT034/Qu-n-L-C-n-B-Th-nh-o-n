package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Chucvudonvi;

public interface ChucvuDonviDAO {
	public int save(Chucvudonvi chucvudonvi);
	public Chucvudonvi getByChucvuDonviId(int id);
	public void update(Chucvudonvi chucvudonvi);
	public void delete(int id);
	public List<Chucvudonvi> listChucvuDonvi();
}
