package com.springmvc.qlcb.model;
// Generated Apr 19, 2016 9:35:55 AM by Hibernate Tools 4.3.1.Final

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
 * Chuyencongtac generated by hbm2java
 */
@Entity
@Table(name = "chuyencongtac", catalog = "qlcb_new")
public class Chuyencongtac implements java.io.Serializable {

	private int maChuyenCongTac;
	private Canbo canboByNguoiXacNhan;
	private Canbo canboByMaCbduocChuyen;
	private int maNoiCongTacHienTai;
	private int maNoiCongTacChuyenToi;
	private Date ngayChuyen;
	private boolean daXacNhan;
	private String lyDoChuyen;

	public Chuyencongtac() {
	}

	public Chuyencongtac(int maChuyenCongTac, Canbo canboByMaCbduocChuyen, int maNoiCongTacHienTai,
			int maNoiCongTacChuyenToi, Date ngayChuyen, boolean daXacNhan) {
		this.maChuyenCongTac = maChuyenCongTac;
		this.canboByMaCbduocChuyen = canboByMaCbduocChuyen;
		this.maNoiCongTacHienTai = maNoiCongTacHienTai;
		this.maNoiCongTacChuyenToi = maNoiCongTacChuyenToi;
		this.ngayChuyen = ngayChuyen;
		this.daXacNhan = daXacNhan;
	}

	public Chuyencongtac(int maChuyenCongTac, Canbo canboByNguoiXacNhan, Canbo canboByMaCbduocChuyen,
			int maNoiCongTacHienTai, int maNoiCongTacChuyenToi, Date ngayChuyen, boolean daXacNhan, String lyDoChuyen) {
		this.maChuyenCongTac = maChuyenCongTac;
		this.canboByNguoiXacNhan = canboByNguoiXacNhan;
		this.canboByMaCbduocChuyen = canboByMaCbduocChuyen;
		this.maNoiCongTacHienTai = maNoiCongTacHienTai;
		this.maNoiCongTacChuyenToi = maNoiCongTacChuyenToi;
		this.ngayChuyen = ngayChuyen;
		this.daXacNhan = daXacNhan;
		this.lyDoChuyen = lyDoChuyen;
	}

	@Id

	@Column(name = "MaChuyenCongTac", unique = true, nullable = false)
	public int getMaChuyenCongTac() {
		return this.maChuyenCongTac;
	}

	public void setMaChuyenCongTac(int maChuyenCongTac) {
		this.maChuyenCongTac = maChuyenCongTac;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NguoiXacNhan")
	public Canbo getCanboByNguoiXacNhan() {
		return this.canboByNguoiXacNhan;
	}

	public void setCanboByNguoiXacNhan(Canbo canboByNguoiXacNhan) {
		this.canboByNguoiXacNhan = canboByNguoiXacNhan;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "MaCBDuocChuyen", nullable = false)
	public Canbo getCanboByMaCbduocChuyen() {
		return this.canboByMaCbduocChuyen;
	}

	public void setCanboByMaCbduocChuyen(Canbo canboByMaCbduocChuyen) {
		this.canboByMaCbduocChuyen = canboByMaCbduocChuyen;
	}

	@Column(name = "MaNoiCongTacHienTai", nullable = false)
	public int getMaNoiCongTacHienTai() {
		return this.maNoiCongTacHienTai;
	}

	public void setMaNoiCongTacHienTai(int maNoiCongTacHienTai) {
		this.maNoiCongTacHienTai = maNoiCongTacHienTai;
	}

	@Column(name = "MaNoiCongTacChuyenToi", nullable = false)
	public int getMaNoiCongTacChuyenToi() {
		return this.maNoiCongTacChuyenToi;
	}

	public void setMaNoiCongTacChuyenToi(int maNoiCongTacChuyenToi) {
		this.maNoiCongTacChuyenToi = maNoiCongTacChuyenToi;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "NgayChuyen", nullable = false, length = 10)
	public Date getNgayChuyen() {
		return this.ngayChuyen;
	}

	public void setNgayChuyen(Date ngayChuyen) {
		this.ngayChuyen = ngayChuyen;
	}

	@Column(name = "DaXacNhan", nullable = false)
	public boolean isDaXacNhan() {
		return this.daXacNhan;
	}

	public void setDaXacNhan(boolean daXacNhan) {
		this.daXacNhan = daXacNhan;
	}

	@Column(name = "LyDoChuyen", length = 65535)
	public String getLyDoChuyen() {
		return this.lyDoChuyen;
	}

	public void setLyDoChuyen(String lyDoChuyen) {
		this.lyDoChuyen = lyDoChuyen;
	}

}
