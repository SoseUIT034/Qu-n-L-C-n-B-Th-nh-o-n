package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.CanboGiadinhBanthan;
 

public interface CanBoGiaDinhBanThanDAO {
	public int save(CanboGiadinhBanthan canboGiadinhBanthan);
	public CanboGiadinhBanthan getCanboGiadinhBanthanById(int id);
	public void update(CanboGiadinhBanthan canboGiadinhBanthan);
	public void delete(int id);
	public List<CanboGiadinhBanthan> listCanboGiadinhBanthan();
}
