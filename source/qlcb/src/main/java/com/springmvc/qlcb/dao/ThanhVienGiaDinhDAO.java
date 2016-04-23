package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Thanhviengiadinh;

public interface ThanhVienGiaDinhDAO {
	public int save(Thanhviengiadinh thanhviengiadinh);
	public Thanhviengiadinh getThanhVienGiaDinhById(int id);
	public void update(Thanhviengiadinh thanhviengiadinh);
	public void delete(int id);
	public List<Thanhviengiadinh> listThanhVienGiaDinh();
}
