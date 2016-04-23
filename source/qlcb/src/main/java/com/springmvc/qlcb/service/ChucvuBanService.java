package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Chucvuban;

public interface ChucvuBanService {
	public int save(Chucvuban chucvuban);
	public Chucvuban getChucvuBanById(int id);
	public void update(Chucvuban chucvuban);
	public void delete(int id);
	public List<Chucvuban> listChucvuBan();
}
