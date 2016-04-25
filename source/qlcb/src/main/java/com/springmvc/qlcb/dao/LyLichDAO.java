package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Lylich;

public interface LyLichDAO {
	public int save(Lylich lylich);
	public Lylich getLyLichById(int id);
	public void update(Lylich lylich);
	public void delete(int id);
	public List<Lylich> listLyLich();
}
