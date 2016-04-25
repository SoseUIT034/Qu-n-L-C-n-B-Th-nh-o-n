package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Mucdohoanthanh;

public interface MucDoHoanThanhService {
	public int save(Mucdohoanthanh mucdohoanthanh);
	public Mucdohoanthanh getMucDoHoanThanhById(int id);
	public void update(Mucdohoanthanh mucdohoanthanh);
	public void delete(int id);
	public List<Mucdohoanthanh> listMucDoHoanThanh();
}
