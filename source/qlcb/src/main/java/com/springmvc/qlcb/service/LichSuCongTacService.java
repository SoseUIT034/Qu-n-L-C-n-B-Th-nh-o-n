package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Lichsucongtac;;

public interface LichSuCongTacService {
	public int save(Lichsucongtac lichsucongtac);
	public Lichsucongtac getLichSuCongTacById(int id);
	public void update(Lichsucongtac lichsucongtac);
	public void delete(int id);
	public List<Lichsucongtac> listLichSuCongTac();
}
