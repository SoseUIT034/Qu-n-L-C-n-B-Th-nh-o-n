package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Dantoc;;

public interface DanTocService {
	public int save(Dantoc dantoc);
	public Dantoc getDanTocById(int id);
	public void update(Dantoc dantoc);
	public void delete(int id);
	public List<Dantoc> listDanToc();
}
