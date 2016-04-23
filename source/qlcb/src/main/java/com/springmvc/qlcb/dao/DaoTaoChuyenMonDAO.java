package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Daotaochuyenmon;;

public interface DaoTaoChuyenMonDAO {
	public int save(Daotaochuyenmon daotaochuyenmon);
	public Daotaochuyenmon getDaoTaoChuyenMonById(int id);
	public void update(Daotaochuyenmon daotaochuyenmon);
	public void delete(int id);
	public List<Daotaochuyenmon> listDaoTaoChuyenMon();
}
