package com.springmvc.qlcb.model;
// Generated Apr 21, 2016 1:56:09 PM by Hibernate Tools 4.3.1.Final

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
 * Dacdienlichsubanthan generated by hbm2java
 */
@Entity
@Table(name = "dacdienlichsubanthan", catalog = "qlcb")
public class Dacdienlichsubanthan implements java.io.Serializable {

	private int maDdls;
	private Canbo canbo;
	private Date tuNgay;
	private Date toiNgay;
	private String tenSuKien;
	private String noiDung;

	public Dacdienlichsubanthan() {
	}

	public Dacdienlichsubanthan(int maDdls, Canbo canbo, Date tuNgay, Date toiNgay, String tenSuKien) {
		this.maDdls = maDdls;
		this.canbo = canbo;
		this.tuNgay = tuNgay;
		this.toiNgay = toiNgay;
		this.tenSuKien = tenSuKien;
	}

	public Dacdienlichsubanthan(int maDdls, Canbo canbo, Date tuNgay, Date toiNgay, String tenSuKien, String noiDung) {
		this.maDdls = maDdls;
		this.canbo = canbo;
		this.tuNgay = tuNgay;
		this.toiNgay = toiNgay;
		this.tenSuKien = tenSuKien;
		this.noiDung = noiDung;
	}

	@Id

	@Column(name = "MaDDLS", unique = true, nullable = false)
	public int getMaDdls() {
		return this.maDdls;
	}

	public void setMaDdls(int maDdls) {
		this.maDdls = maDdls;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaCanBo", nullable = false)
	public Canbo getCanbo() {
		return this.canbo;
	}

	public void setCanbo(Canbo canbo) {
		this.canbo = canbo;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "TuNgay", nullable = false, length = 10)
	public Date getTuNgay() {
		return this.tuNgay;
	}

	public void setTuNgay(Date tuNgay) {
		this.tuNgay = tuNgay;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "ToiNgay", nullable = false, length = 10)
	public Date getToiNgay() {
		return this.toiNgay;
	}

	public void setToiNgay(Date toiNgay) {
		this.toiNgay = toiNgay;
	}

	@Column(name = "TenSuKien", nullable = false, length = 200)
	public String getTenSuKien() {
		return this.tenSuKien;
	}

	public void setTenSuKien(String tenSuKien) {
		this.tenSuKien = tenSuKien;
	}

	@Column(name = "NoiDung", length = 65535)
	public String getNoiDung() {
		return this.noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}

}