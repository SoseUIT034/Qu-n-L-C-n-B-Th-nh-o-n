package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Dacdienlichsubanthan;;

public interface DacDiemLichSuBanThanDAO {
	public int save(Dacdienlichsubanthan dacdienlichsubanthan);
	public Dacdienlichsubanthan getDacDiemLichSuBanThanById(int id);
	public void update(Dacdienlichsubanthan dacdienlichsubanthan);
	public void delete(int id);
	public List<Dacdienlichsubanthan> listDacDiemLichSuBanThan();
}
