package com.springmvc.qlcb.model;
// Generated Apr 25, 2016 2:33:53 PM by Hibernate Tools 4.3.1.Final

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Daotaochuyenmon generated by hbm2java
 */
@Entity
@Table(name = "daotaochuyenmon", catalog = "qlcb")
public class Daotaochuyenmon implements java.io.Serializable {

	private int maDaoTao;
	private Canbo canbo;
	private Date tuNgay;
	private Date toiNgay;
	private String hinhThucDaoTao;
	private String chuyenNganhDaoTao;
	private String truong;
	private String chungChiDatDuoc;

	public Daotaochuyenmon() {
	}

	public Daotaochuyenmon(int maDaoTao) {
		this.maDaoTao = maDaoTao;
	}

	public Daotaochuyenmon(int maDaoTao, Canbo canbo, Date tuNgay, Date toiNgay, String hinhThucDaoTao,
			String chuyenNganhDaoTao, String truong, String chungChiDatDuoc) {
		this.maDaoTao = maDaoTao;
		this.canbo = canbo;
		this.tuNgay = tuNgay;
		this.toiNgay = toiNgay;
		this.hinhThucDaoTao = hinhThucDaoTao;
		this.chuyenNganhDaoTao = chuyenNganhDaoTao;
		this.truong = truong;
		this.chungChiDatDuoc = chungChiDatDuoc;
	}

	@Id

	@Column(name = "MaDaoTao", unique = true, nullable = false)
	public int getMaDaoTao() {
		return this.maDaoTao;
	}

	public void setMaDaoTao(int maDaoTao) {
		this.maDaoTao = maDaoTao;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaCanBo")
	public Canbo getCanbo() {
		return this.canbo;
	}

	public void setCanbo(Canbo canbo) {
		this.canbo = canbo;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "TuNgay", length = 10)
	public Date getTuNgay() {
		return this.tuNgay;
	}

	public void setTuNgay(Date tuNgay) {
		this.tuNgay = tuNgay;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "ToiNgay", length = 10)
	public Date getToiNgay() {
		return this.toiNgay;
	}

	public void setToiNgay(Date toiNgay) {
		this.toiNgay = toiNgay;
	}

	@Column(name = "HinhThucDaoTao", length = 200)
	public String getHinhThucDaoTao() {
		return this.hinhThucDaoTao;
	}

	public void setHinhThucDaoTao(String hinhThucDaoTao) {
		this.hinhThucDaoTao = hinhThucDaoTao;
	}

	@Column(name = "ChuyenNganhDaoTao", length = 200)
	public String getChuyenNganhDaoTao() {
		return this.chuyenNganhDaoTao;
	}

	public void setChuyenNganhDaoTao(String chuyenNganhDaoTao) {
		this.chuyenNganhDaoTao = chuyenNganhDaoTao;
	}

	@Column(name = "Truong", length = 200)
	public String getTruong() {
		return this.truong;
	}

	public void setTruong(String truong) {
		this.truong = truong;
	}

	@Column(name = "ChungChiDatDuoc", length = 200)
	public String getChungChiDatDuoc() {
		return this.chungChiDatDuoc;
	}

	public void setChungChiDatDuoc(String chungChiDatDuoc) {
		this.chungChiDatDuoc = chungChiDatDuoc;
	}

}
