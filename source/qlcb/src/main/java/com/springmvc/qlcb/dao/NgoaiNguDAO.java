package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Ngoaingu;

public interface NgoaiNguDAO {
	public int save(Ngoaingu ngoaingu);
	public Ngoaingu getNgoaiNguById(int id);
	public void update(Ngoaingu ngoaingu);
	public void delete(int id);
	public List<Ngoaingu> listNgoaiNgu();
}
