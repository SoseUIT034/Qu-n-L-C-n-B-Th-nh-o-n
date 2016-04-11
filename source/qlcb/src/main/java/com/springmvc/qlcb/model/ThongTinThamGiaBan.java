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
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * ThongTinThamGiaBan generated by hbm2java
 */
@Entity
@Table(name = "thong_tin_tham_gia_ban", catalog = "qlcb")
public class ThongTinThamGiaBan implements java.io.Serializable {

	private ThongTinThamGiaBanId id;
	private Ban ban;
	private CanBo canBo;
	private ChucVu chucVu;
	private ToCongTac toCongTac;
	private Date ngayRoiKhoi;
	private String lyDoChuyenDen;
	private byte laCongTacChinh;
	private Integer maBanTruocDo;
	private Date ngayGnBanTruocDo;
	private byte trangThai;

	public ThongTinThamGiaBan() {
	}

	public ThongTinThamGiaBan(ThongTinThamGiaBanId id, Ban ban, CanBo canBo, ToCongTac toCongTac, byte laCongTacChinh,
			byte trangThai) {
		this.id = id;
		this.ban = ban;
		this.canBo = canBo;
		this.toCongTac = toCongTac;
		this.laCongTacChinh = laCongTacChinh;
		this.trangThai = trangThai;
	}

	public ThongTinThamGiaBan(ThongTinThamGiaBanId id, Ban ban, CanBo canBo, ChucVu chucVu, ToCongTac toCongTac,
			Date ngayRoiKhoi, String lyDoChuyenDen, byte laCongTacChinh, Integer maBanTruocDo, Date ngayGnBanTruocDo,
			byte trangThai) {
		this.id = id;
		this.ban = ban;
		this.canBo = canBo;
		this.chucVu = chucVu;
		this.toCongTac = toCongTac;
		this.ngayRoiKhoi = ngayRoiKhoi;
		this.lyDoChuyenDen = lyDoChuyenDen;
		this.laCongTacChinh = laCongTacChinh;
		this.maBanTruocDo = maBanTruocDo;
		this.ngayGnBanTruocDo = ngayGnBanTruocDo;
		this.trangThai = trangThai;
	}

	@EmbeddedId

	@AttributeOverrides({ @AttributeOverride(name = "maCb", column = @Column(name = "Ma_CB", nullable = false)),
			@AttributeOverride(name = "maBan", column = @Column(name = "Ma_Ban", nullable = false)),
			@AttributeOverride(name = "ngayGiaNhap", column = @Column(name = "Ngay_Gia_Nhap", nullable = false, length = 10)) })
	public ThongTinThamGiaBanId getId() {
		return this.id;
	}

	public void setId(ThongTinThamGiaBanId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Ma_Ban", nullable = false, insertable = false, updatable = false)
	public Ban getBan() {
		return this.ban;
	}

	public void setBan(Ban ban) {
		this.ban = ban;
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
	@JoinColumn(name = "Ma_CV")
	public ChucVu getChucVu() {
		return this.chucVu;
	}

	public void setChucVu(ChucVu chucVu) {
		this.chucVu = chucVu;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "Ma_Ban", referencedColumnName = "Ma_Ban", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "STT_To", referencedColumnName = "STT_To", insertable = false, updatable = false) })
	public ToCongTac getToCongTac() {
		return this.toCongTac;
	}

	public void setToCongTac(ToCongTac toCongTac) {
		this.toCongTac = toCongTac;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "Ngay_Roi_Khoi", length = 10)
	public Date getNgayRoiKhoi() {
		return this.ngayRoiKhoi;
	}

	public void setNgayRoiKhoi(Date ngayRoiKhoi) {
		this.ngayRoiKhoi = ngayRoiKhoi;
	}

	@Column(name = "Ly_Do_Chuyen_Den", length = 254)
	public String getLyDoChuyenDen() {
		return this.lyDoChuyenDen;
	}

	public void setLyDoChuyenDen(String lyDoChuyenDen) {
		this.lyDoChuyenDen = lyDoChuyenDen;
	}

	@Column(name = "La_Cong_Tac_Chinh", nullable = false)
	public byte getLaCongTacChinh() {
		return this.laCongTacChinh;
	}

	public void setLaCongTacChinh(byte laCongTacChinh) {
		this.laCongTacChinh = laCongTacChinh;
	}

	@Column(name = "Ma_Ban_Truoc_Do")
	public Integer getMaBanTruocDo() {
		return this.maBanTruocDo;
	}

	public void setMaBanTruocDo(Integer maBanTruocDo) {
		this.maBanTruocDo = maBanTruocDo;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "Ngay_GN_Ban_Truoc_Do", length = 10)
	public Date getNgayGnBanTruocDo() {
		return this.ngayGnBanTruocDo;
	}

	public void setNgayGnBanTruocDo(Date ngayGnBanTruocDo) {
		this.ngayGnBanTruocDo = ngayGnBanTruocDo;
	}

	@Column(name = "Trang_Thai", nullable = false)
	public byte getTrangThai() {
		return this.trangThai;
	}

	public void setTrangThai(byte trangThai) {
		this.trangThai = trangThai;
	}

}
