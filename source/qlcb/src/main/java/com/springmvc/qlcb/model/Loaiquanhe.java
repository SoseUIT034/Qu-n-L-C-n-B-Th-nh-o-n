package com.springmvc.qlcb.model;
// Generated Apr 21, 2016 1:56:09 PM by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Loaiquanhe generated by hbm2java
 */
@Entity
@Table(name = "loaiquanhe", catalog = "qlcb")
public class Loaiquanhe implements java.io.Serializable {

	private int maLoaiQuanHe;
	private String tenLoaiQuanHe;
	private Set<Thanhviengiadinh> thanhviengiadinhs = new HashSet<Thanhviengiadinh>(0);

	public Loaiquanhe() {
	}

	public Loaiquanhe(int maLoaiQuanHe, String tenLoaiQuanHe) {
		this.maLoaiQuanHe = maLoaiQuanHe;
		this.tenLoaiQuanHe = tenLoaiQuanHe;
	}

	public Loaiquanhe(int maLoaiQuanHe, String tenLoaiQuanHe, Set<Thanhviengiadinh> thanhviengiadinhs) {
		this.maLoaiQuanHe = maLoaiQuanHe;
		this.tenLoaiQuanHe = tenLoaiQuanHe;
		this.thanhviengiadinhs = thanhviengiadinhs;
	}

	@Id

	@Column(name = "MaLoaiQuanHe", unique = true, nullable = false)
	public int getMaLoaiQuanHe() {
		return this.maLoaiQuanHe;
	}

	public void setMaLoaiQuanHe(int maLoaiQuanHe) {
		this.maLoaiQuanHe = maLoaiQuanHe;
	}

	@Column(name = "TenLoaiQuanHe", nullable = false, length = 200)
	public String getTenLoaiQuanHe() {
		return this.tenLoaiQuanHe;
	}

	public void setTenLoaiQuanHe(String tenLoaiQuanHe) {
		this.tenLoaiQuanHe = tenLoaiQuanHe;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "loaiquanhe")
	public Set<Thanhviengiadinh> getThanhviengiadinhs() {
		return this.thanhviengiadinhs;
	}

	public void setThanhviengiadinhs(Set<Thanhviengiadinh> thanhviengiadinhs) {
		this.thanhviengiadinhs = thanhviengiadinhs;
	}

}