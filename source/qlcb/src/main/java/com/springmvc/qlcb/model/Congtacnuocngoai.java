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
 * Congtacnuocngoai generated by hbm2java
 */
@Entity
@Table(name = "congtacnuocngoai", catalog = "qlcb")
public class Congtacnuocngoai implements java.io.Serializable {

	private int maCtnn;
	private Canbo canbo;
	private Date tuNgay;
	private Date toiNgay;
	private String diaDiem;
	private String noiDung;
	private Double kinhPhi;

	public Congtacnuocngoai() {
	}

	public Congtacnuocngoai(int maCtnn, Canbo canbo) {
		this.maCtnn = maCtnn;
		this.canbo = canbo;
	}

	public Congtacnuocngoai(int maCtnn, Canbo canbo, Date tuNgay, Date toiNgay, String diaDiem, String noiDung,
			Double kinhPhi) {
		this.maCtnn = maCtnn;
		this.canbo = canbo;
		this.tuNgay = tuNgay;
		this.toiNgay = toiNgay;
		this.diaDiem = diaDiem;
		this.noiDung = noiDung;
		this.kinhPhi = kinhPhi;
	}

	@Id

	@Column(name = "MaCTNN", unique = true, nullable = false)
	public int getMaCtnn() {
		return this.maCtnn;
	}

	public void setMaCtnn(int maCtnn) {
		this.maCtnn = maCtnn;
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

	@Column(name = "DiaDiem", length = 200)
	public String getDiaDiem() {
		return this.diaDiem;
	}

	public void setDiaDiem(String diaDiem) {
		this.diaDiem = diaDiem;
	}

	@Column(name = "NoiDung", length = 2000)
	public String getNoiDung() {
		return this.noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}

	@Column(name = "KinhPhi", precision = 22, scale = 0)
	public Double getKinhPhi() {
		return this.kinhPhi;
	}

	public void setKinhPhi(Double kinhPhi) {
		this.kinhPhi = kinhPhi;
	}

}
