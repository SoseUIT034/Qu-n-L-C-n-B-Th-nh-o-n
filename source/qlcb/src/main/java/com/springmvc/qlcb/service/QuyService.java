package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Quy;

public interface QuyService {
	public int save(Quy quy);
	public Quy getQuyById(int id);
	public void update(Quy quy);
	public void delete(int id);
	public List<Quy> listQuy();
}
