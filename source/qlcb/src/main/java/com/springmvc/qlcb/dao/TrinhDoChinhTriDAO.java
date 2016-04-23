package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Trinhdochinhtri;

public interface TrinhDoChinhTriDAO {
	public int save(Trinhdochinhtri trinhdochinhtri);
	public Trinhdochinhtri getTrinhDoChinhTriById(int id);
	public void update(Trinhdochinhtri trinhdochinhtri);
	public void delete(int id);
	public List<Trinhdochinhtri> listTrinhDoChinhTri();
}
