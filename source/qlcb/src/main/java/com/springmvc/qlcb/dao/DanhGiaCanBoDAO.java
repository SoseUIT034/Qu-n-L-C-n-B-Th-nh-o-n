package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Danhgiacanbo;;

public interface DanhGiaCanBoDAO {
	public int save(Danhgiacanbo danhgiacanbo);
	public Danhgiacanbo getDanhGiaCanBoById(int id);
	public void update(Danhgiacanbo danhgiacanbo);
	public void delete(int id);
	public List<Danhgiacanbo> listDanhGiaCanBo();
}
