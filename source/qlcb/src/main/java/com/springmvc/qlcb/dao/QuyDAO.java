package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Quy;

public interface QuyDAO {
	public int save(Quy quy);
	public Quy getQuyById(int id);
	public void update(Quy quy);
	public void delete(int id);
	public List<Quy> listQuy();
}
