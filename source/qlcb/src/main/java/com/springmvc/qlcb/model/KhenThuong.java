package com.springmvc.qlcb.model;
// Generated Apr 11, 2016 10:54:37 AM by Hibernate Tools 4.3.1.Final

import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * KhenThuong generated by hbm2java
 */
@Entity
@Table(name = "khen_thuong", catalog = "qlcb")
public class KhenThuong implements java.io.Serializable {

	private KhenThuongId id;
	private CanBo canBo;
	private DienKhenThuong dienKhenThuong;
	private KqXetThiDua kqXetThiDua;
	private Date ngayQuyetDinh;
	private String hinhThuc;
	private String capRaQuyetDinh;
	private String lyDo;
	private Float heSoThuong;

	public KhenThuong() {
	}

	public KhenThuong(KhenThuongId id, CanBo canBo) {
		this.id = id;
		this.canBo = canBo;
	}

	public KhenThuong(KhenThuongId id, CanBo canBo, DienKhenThuong dienKhenThuong, KqXetThiDua kqXetThiDua,
			Date ngayQuyetDinh, String hinhThuc, String capRaQuyetDinh, String lyDo, Float heSoThuong) {
		this.id = id;
		this.canBo = canBo;
		this.dienKhenThuong = dienKhenThuong;
		this.kqXetThiDua = kqXetThiDua;
		this.ngayQuyetDinh = ngayQuyetDinh;
		this.hinhThuc = hinhThuc;
		this.capRaQuyetDinh = capRaQuyetDinh;
		this.lyDo = lyDo;
		this.heSoThuong = heSoThuong;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "maKhenThuong", column = @Column(name = "Ma_Khen_Thuong", nullable = false)),
			@AttributeOverride(name = "maCb", column = @Column(name = "Ma_CB", nullable = false)) })
	public KhenThuongId getId() {
		return this.id;
	}

	public void setId(KhenThuongId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Ma_CB", nullable = false, insertable = false, updatable = false)
	public CanBo getCanBo() {
		return this.canBo;
	}

	public void setCanBo(CanBo canBo) {
		this.canBo = canBo;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Ma_Dien")
	public DienKhenThuong getDienKhenThuong() {
		return this.dienKhenThuong;
	}

	public void setDienKhenThuong(DienKhenThuong dienKhenThuong) {
		this.dienKhenThuong = dienKhenThuong;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Ma_DS_Khen_Thuong")
	public KqXetThiDua getKqXetThiDua() {
		return this.kqXetThiDua;
	}

	public void setKqXetThiDua(KqXetThiDua kqXetThiDua) {
		this.kqXetThiDua = kqXetThiDua;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "Ngay_Quyet_Dinh", length = 10)
	public Date getNgayQuyetDinh() {
		return this.ngayQuyetDinh;
	}

	public void setNgayQuyetDinh(Date ngayQuyetDinh) {
		this.ngayQuyetDinh = ngayQuyetDinh;
	}

	@Column(name = "Hinh_Thuc", length = 62)
	public String getHinhThuc() {
		return this.hinhThuc;
	}

	public void setHinhThuc(String hinhThuc) {
		this.hinhThuc = hinhThuc;
	}

	@Column(name = "Cap_Ra_Quyet_Dinh", length = 62)
	public String getCapRaQuyetDinh() {
		return this.capRaQuyetDinh;
	}

	public void setCapRaQuyetDinh(String capRaQuyetDinh) {
		this.capRaQuyetDinh = capRaQuyetDinh;
	}

	@Column(name = "Ly_Do", length = 254)
	public String getLyDo() {
		return this.lyDo;
	}

	public void setLyDo(String lyDo) {
		this.lyDo = lyDo;
	}

	@Column(name = "He_So_Thuong", precision = 12, scale = 0)
	public Float getHeSoThuong() {
		return this.heSoThuong;
	}

	public void setHeSoThuong(Float heSoThuong) {
		this.heSoThuong = heSoThuong;
	}

}
