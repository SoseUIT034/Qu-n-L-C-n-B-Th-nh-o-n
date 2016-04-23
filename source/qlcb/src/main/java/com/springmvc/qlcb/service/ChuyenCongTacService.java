package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Chuyencongtac;;

public interface ChuyenCongTacService {
	public int save(Chuyencongtac chuyencongtac);
	public Chuyencongtac getChuyenCongTacById(int id);
	public void update(Chuyencongtac chuyencongtac);
	public void delete(int id);
	public List<Chuyencongtac> listChuyenCongTac();
}
