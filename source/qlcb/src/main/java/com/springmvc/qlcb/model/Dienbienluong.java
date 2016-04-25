package com.springmvc.qlcb.model;
// Generated Apr 25, 2016 2:33:53 PM by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Dienbienluong generated by hbm2java
 */
@Entity
@Table(name = "dienbienluong", catalog = "qlcb")
public class Dienbienluong implements java.io.Serializable {

	private int id;
	private Lylich lylich;
	private Integer thang;
	private Integer nam;
	private Float bac;
	private Float ngach;
	private Float heSoLuong;
	//-----tu them vao - no mapping----------
	@Transient  
	 private String lngaythang;
	@Transient  
	 private String lmangach_bac;  

	
	
	public String getLngaythang() {
		return lngaythang;
	}

	public void setLngaythang(String lngaythang) {
		this.lngaythang = lngaythang;
	}

	public String getLmangach_bac() {
		return lmangach_bac;
	}

	public void setLmangach_bac(String lmangach_bac) {
		this.lmangach_bac = lmangach_bac;
	}

	
	
	//------------
	public Dienbienluong() {
	}

	public Dienbienluong(int id, Lylich lylich) {
		this.id = id;
		this.lylich = lylich;
	}

	public Dienbienluong(int id, Lylich lylich, Integer thang, Integer nam, Float bac, Float ngach, Float heSoLuong) {
		this.id = id;
		this.lylich = lylich;
		this.thang = thang;
		this.nam = nam;
		this.bac = bac;
		this.ngach = ngach;
		this.heSoLuong = heSoLuong;
	}

	@Id

	@Column(name = "ID", unique = true, nullable = false)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CanBo", nullable = false)
	public Lylich getLylich() {
		return this.lylich;
	}

	public void setLylich(Lylich lylich) {
		this.lylich = lylich;
	}

	@Column(name = "Thang")
	public Integer getThang() {
		return this.thang;
	}

	public void setThang(Integer thang) {
		this.thang = thang;
	}

	@Column(name = "Nam")
	public Integer getNam() {
		return this.nam;
	}

	public void setNam(Integer nam) {
		this.nam = nam;
	}

	@Column(name = "Bac", precision = 12, scale = 0)
	public Float getBac() {
		return this.bac;
	}

	public void setBac(Float bac) {
		this.bac = bac;
	}

	@Column(name = "Ngach", precision = 12, scale = 0)
	public Float getNgach() {
		return this.ngach;
	}

	public void setNgach(Float ngach) {
		this.ngach = ngach;
	}

	@Column(name = "HeSoLuong", precision = 12, scale = 0)
	public Float getHeSoLuong() {
		return this.heSoLuong;
	}

	public void setHeSoLuong(Float heSoLuong) {
		this.heSoLuong = heSoLuong;
	}

}
