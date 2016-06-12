package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.Ban;

public interface BanDAO {
	public int save(Ban ban);
	public Ban getBanById(int id);
	public void update(Ban ban);
	public void delete(int id);
	public List<Ban> listBan();
	List<Ban> listBanByDonVi(int id);
}
