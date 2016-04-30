package com.springmvc.qlcb.dao;

import java.util.List;

import com.springmvc.qlcb.model.CanboGiadinhDoitac;;
 

public interface CanBoGiaDinhDoiTacDAO {
	public int save(CanboGiadinhDoitac canboGiadinhDoitac);
	public CanboGiadinhDoitac getCanboGiadinhDoitacId(int id);
	public void update(CanboGiadinhDoitac canboGiadinhDoitac);
	public void delete(int id);
	public List<CanboGiadinhDoitac> listcanboGiadinhDoitac();
}
