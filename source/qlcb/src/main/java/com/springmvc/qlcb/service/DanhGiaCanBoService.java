package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Danhgiacanbo;;

public interface DanhGiaCanBoService {
	public int save(Danhgiacanbo danhgiacanbo);
	public Danhgiacanbo getDanhGiaCanBoById(int id);
	public void update(Danhgiacanbo danhgiacanbo);
	public void delete(int id);
	public List<Danhgiacanbo> listDanhGiaCanBo();
}
