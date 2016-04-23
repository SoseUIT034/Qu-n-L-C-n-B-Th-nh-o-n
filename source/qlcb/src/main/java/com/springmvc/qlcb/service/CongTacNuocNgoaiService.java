package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Congtacnuocngoai;;

public interface CongTacNuocNgoaiService {
	public int save(Congtacnuocngoai congtacnuocngoai);
	public Congtacnuocngoai getCongTacNuocNgoaiById(int id);
	public void update(Congtacnuocngoai congtacnuocngoai);
	public void delete(int id);
	public List<Congtacnuocngoai> listCongTacNuocNgoai();
}
