package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Lylich;

public interface LyLichService {
	public boolean save(Lylich lylich);
	public Lylich getLyLichById(int id);
	public boolean update(Lylich lylich);
	public void delete(int id);
	public List<Lylich> listLyLich();
	boolean updatefrfile(Lylich lylich);
}
