package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Tongiao;

public interface TonGiaoService {
	public int save(Tongiao tongiao);
	public Tongiao getTonGiaoById(int id);
	public void update(Tongiao tongiao);
	public void delete(int id);
	public List<Tongiao> listTonGiao();
}
