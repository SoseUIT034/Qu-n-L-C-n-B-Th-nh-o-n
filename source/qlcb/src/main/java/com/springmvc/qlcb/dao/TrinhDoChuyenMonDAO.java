package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Trinhdochuyenmon;

public interface TrinhDoChuyenMonDAO {
	public int save(Trinhdochuyenmon trinhdochuyenmon);
	public Trinhdochuyenmon getTrinhDoChuyenMonById(int id);
	public void update(Trinhdochuyenmon trinhdochuyenmon);
	public void delete(int id);
	public List<Trinhdochuyenmon> listTrinhDoChuyenMon();
}
