package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Congtacnuocngoai;;

public interface CongTacNuocNgoaiDAO {
	public int save(Congtacnuocngoai congtacnuocngoai);
	public Congtacnuocngoai getCongTacNuocNgoaiById(int id);
	public void update(Congtacnuocngoai congtacnuocngoai);
	public void delete(int id);
	public List<Congtacnuocngoai> listCongTacNuocNgoai();
}
