package com.springmvc.qlcb.service;

import java.util.List;

import com.springmvc.qlcb.model.Trinhdochinhtri;

public interface TrinhDoChinhTriService {
	public int save(Trinhdochinhtri trinhdochinhtri);
	public Trinhdochinhtri getTrinhDoChinhTriById(int id);
	public void update(Trinhdochinhtri trinhdochinhtri);
	public void delete(int id);
	public List<Trinhdochinhtri> listTrinhDoChinhTri();
}
