package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Tongiao;

public interface TonGiaoDAO {
	public int save(Tongiao tongiao);
	public Tongiao getTonGiaoById(int id);
	public void update(Tongiao tongiao);
	public void delete(int id);
	public List<Tongiao> listTonGiao();
}
