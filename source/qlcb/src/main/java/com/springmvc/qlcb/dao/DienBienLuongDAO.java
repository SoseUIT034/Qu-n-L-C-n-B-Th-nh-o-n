package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Dienbienluong;;;

public interface DienBienLuongDAO {
	public int save(Dienbienluong dienBienLuong);
	public Dienbienluong getDienbienluongById(int id);
	public void update(Dienbienluong dienBienLuong);
	public void delete(int id);
	public List<Dienbienluong> listDienBienLuong();
}
