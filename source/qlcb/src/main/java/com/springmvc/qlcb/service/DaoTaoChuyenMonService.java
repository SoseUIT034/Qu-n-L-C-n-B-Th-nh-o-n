package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Daotaochuyenmon;;

public interface DaoTaoChuyenMonService {
	public int save(Daotaochuyenmon daotaochuyenmon);
	public Daotaochuyenmon getDaoTaoChuyenMonById(int id);
	public void update(Daotaochuyenmon daotaochuyenmon);
	public void delete(int id);
	public List<Daotaochuyenmon> listDaoTaoChuyenMon();
}
