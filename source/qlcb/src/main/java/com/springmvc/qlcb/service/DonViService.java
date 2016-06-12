package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Donvi;;

public interface DonViService {
	public Object save(Donvi donvi);
	public Donvi getDonViById(int id);
	public void update(Donvi donvi);
	public void delete(int id);
	public List<Donvi> listDonVi();
}
