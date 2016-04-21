package com.springmvc.qlcb.model;
// Generated Apr 19, 2016 9:35:55 AM by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * Canbo generated by hbm2java
 */
@Entity
@Table(name = "canbo", catalog = "qlcb_new")
public class Canbo implements java.io.Serializable {

	private int id;
	private Boolean trangThai;
	private Set<CanboDonvi> canboDonvis = new HashSet<CanboDonvi>(0);
	private Taikhoan taikhoan;
	private Set<Chuyencongtac> chuyencongtacsForNguoiXacNhan = new HashSet<Chuyencongtac>(0);
	private Lylich lylichById;
	private Set<Chuyencongtac> chuyencongtacsForMaCbduocChuyen = new HashSet<Chuyencongtac>(0);
	private Set<Lylich> lylichesForNguoiXacNhan = new HashSet<Lylich>(0);
	private Set<Thanhviengiadinh> thanhviengiadinhs = new HashSet<Thanhviengiadinh>(0);
	private Set<Danhgiacanbo> danhgiacanbosForMaNguoiDanhGia = new HashSet<Danhgiacanbo>(0);
	private Set<Congtacnuocngoai> congtacnuocngoais = new HashSet<Congtacnuocngoai>(0);
	private Set<Danhgiacanbo> danhgiacanbosForMaCbduocDanhGia = new HashSet<Danhgiacanbo>(0);
	private Set<Daotaochuyenmon> daotaochuyenmons = new HashSet<Daotaochuyenmon>(0);
	private Set<Lichsucongtac> lichsucongtacs = new HashSet<Lichsucongtac>(0);
	private Set<Ngoaingu> ngoaingus = new HashSet<Ngoaingu>(0);
	private Set<CanboBan> canboBans = new HashSet<CanboBan>(0);
	private Set<Khenthuong> khenthuongs = new HashSet<Khenthuong>(0);
	private Set<Kyluat> kyluats = new HashSet<Kyluat>(0);
	private Set<Dacdienlichsubanthan> dacdienlichsubanthans = new HashSet<Dacdienlichsubanthan>(0);

	public Canbo() {
	}

	public Canbo(int id) {
		this.id = id;
	}

	public Canbo(int id, Boolean trangThai, Set<CanboDonvi> canboDonvis, Taikhoan taikhoan,
			Set<Chuyencongtac> chuyencongtacsForNguoiXacNhan, Lylich lylichById,
			Set<Chuyencongtac> chuyencongtacsForMaCbduocChuyen, Set<Lylich> lylichesForNguoiXacNhan,
			Set<Thanhviengiadinh> thanhviengiadinhs, Set<Danhgiacanbo> danhgiacanbosForMaNguoiDanhGia,
			Set<Congtacnuocngoai> congtacnuocngoais, Set<Danhgiacanbo> danhgiacanbosForMaCbduocDanhGia,
			Set<Daotaochuyenmon> daotaochuyenmons, Set<Lichsucongtac> lichsucongtacs, Set<Ngoaingu> ngoaingus,
			Set<CanboBan> canboBans, Set<Khenthuong> khenthuongs, Set<Kyluat> kyluats,
			Set<Dacdienlichsubanthan> dacdienlichsubanthans) {
		this.id = id;
		this.trangThai = trangThai;
		this.canboDonvis = canboDonvis;
		this.taikhoan = taikhoan;
		this.chuyencongtacsForNguoiXacNhan = chuyencongtacsForNguoiXacNhan;
		this.lylichById = lylichById;
		this.chuyencongtacsForMaCbduocChuyen = chuyencongtacsForMaCbduocChuyen;
		this.lylichesForNguoiXacNhan = lylichesForNguoiXacNhan;
		this.thanhviengiadinhs = thanhviengiadinhs;
		this.danhgiacanbosForMaNguoiDanhGia = danhgiacanbosForMaNguoiDanhGia;
		this.congtacnuocngoais = congtacnuocngoais;
		this.danhgiacanbosForMaCbduocDanhGia = danhgiacanbosForMaCbduocDanhGia;
		this.daotaochuyenmons = daotaochuyenmons;
		this.lichsucongtacs = lichsucongtacs;
		this.ngoaingus = ngoaingus;
		this.canboBans = canboBans;
		this.khenthuongs = khenthuongs;
		this.kyluats = kyluats;
		this.dacdienlichsubanthans = dacdienlichsubanthans;
	}

	@Id

	@Column(name = "ID", unique = true, nullable = false)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "TrangThai")
	public Boolean getTrangThai() {
		return this.trangThai;
	}

	public void setTrangThai(Boolean trangThai) {
		this.trangThai = trangThai;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<CanboDonvi> getCanboDonvis() {
		return this.canboDonvis;
	}

	public void setCanboDonvis(Set<CanboDonvi> canboDonvis) {
		this.canboDonvis = canboDonvis;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Taikhoan getTaikhoan() {
		return this.taikhoan;
	}

	public void setTaikhoan(Taikhoan taikhoan) {
		this.taikhoan = taikhoan;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canboByNguoiXacNhan")
	public Set<Chuyencongtac> getChuyencongtacsForNguoiXacNhan() {
		return this.chuyencongtacsForNguoiXacNhan;
	}

	public void setChuyencongtacsForNguoiXacNhan(Set<Chuyencongtac> chuyencongtacsForNguoiXacNhan) {
		this.chuyencongtacsForNguoiXacNhan = chuyencongtacsForNguoiXacNhan;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "canboById")
	public Lylich getLylichById() {
		return this.lylichById;
	}

	public void setLylichById(Lylich lylichById) {
		this.lylichById = lylichById;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canboByMaCbduocChuyen")
	public Set<Chuyencongtac> getChuyencongtacsForMaCbduocChuyen() {
		return this.chuyencongtacsForMaCbduocChuyen;
	}

	public void setChuyencongtacsForMaCbduocChuyen(Set<Chuyencongtac> chuyencongtacsForMaCbduocChuyen) {
		this.chuyencongtacsForMaCbduocChuyen = chuyencongtacsForMaCbduocChuyen;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canboByNguoiXacNhan")
	public Set<Lylich> getLylichesForNguoiXacNhan() {
		return this.lylichesForNguoiXacNhan;
	}

	public void setLylichesForNguoiXacNhan(Set<Lylich> lylichesForNguoiXacNhan) {
		this.lylichesForNguoiXacNhan = lylichesForNguoiXacNhan;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "canbo_thanhviengiadinh", catalog = "qlcb_new", joinColumns = {
			@JoinColumn(name = "CanBo_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ThanhVienGiaDinh_ID", nullable = false, updatable = false) })
	public Set<Thanhviengiadinh> getThanhviengiadinhs() {
		return this.thanhviengiadinhs;
	}

	public void setThanhviengiadinhs(Set<Thanhviengiadinh> thanhviengiadinhs) {
		this.thanhviengiadinhs = thanhviengiadinhs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canboByMaNguoiDanhGia")
	public Set<Danhgiacanbo> getDanhgiacanbosForMaNguoiDanhGia() {
		return this.danhgiacanbosForMaNguoiDanhGia;
	}

	public void setDanhgiacanbosForMaNguoiDanhGia(Set<Danhgiacanbo> danhgiacanbosForMaNguoiDanhGia) {
		this.danhgiacanbosForMaNguoiDanhGia = danhgiacanbosForMaNguoiDanhGia;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Congtacnuocngoai> getCongtacnuocngoais() {
		return this.congtacnuocngoais;
	}

	public void setCongtacnuocngoais(Set<Congtacnuocngoai> congtacnuocngoais) {
		this.congtacnuocngoais = congtacnuocngoais;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canboByMaCbduocDanhGia")
	public Set<Danhgiacanbo> getDanhgiacanbosForMaCbduocDanhGia() {
		return this.danhgiacanbosForMaCbduocDanhGia;
	}

	public void setDanhgiacanbosForMaCbduocDanhGia(Set<Danhgiacanbo> danhgiacanbosForMaCbduocDanhGia) {
		this.danhgiacanbosForMaCbduocDanhGia = danhgiacanbosForMaCbduocDanhGia;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Daotaochuyenmon> getDaotaochuyenmons() {
		return this.daotaochuyenmons;
	}

	public void setDaotaochuyenmons(Set<Daotaochuyenmon> daotaochuyenmons) {
		this.daotaochuyenmons = daotaochuyenmons;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Lichsucongtac> getLichsucongtacs() {
		return this.lichsucongtacs;
	}

	public void setLichsucongtacs(Set<Lichsucongtac> lichsucongtacs) {
		this.lichsucongtacs = lichsucongtacs;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "canbo_ngoaingu", catalog = "qlcb_new", joinColumns = {
			@JoinColumn(name = "MaCanBo", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "MaNgoaiNgu", nullable = false, updatable = false) })
	public Set<Ngoaingu> getNgoaingus() {
		return this.ngoaingus;
	}

	public void setNgoaingus(Set<Ngoaingu> ngoaingus) {
		this.ngoaingus = ngoaingus;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<CanboBan> getCanboBans() {
		return this.canboBans;
	}

	public void setCanboBans(Set<CanboBan> canboBans) {
		this.canboBans = canboBans;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Khenthuong> getKhenthuongs() {
		return this.khenthuongs;
	}

	public void setKhenthuongs(Set<Khenthuong> khenthuongs) {
		this.khenthuongs = khenthuongs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Kyluat> getKyluats() {
		return this.kyluats;
	}

	public void setKyluats(Set<Kyluat> kyluats) {
		this.kyluats = kyluats;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "canbo")
	public Set<Dacdienlichsubanthan> getDacdienlichsubanthans() {
		return this.dacdienlichsubanthans;
	}

	public void setDacdienlichsubanthans(Set<Dacdienlichsubanthan> dacdienlichsubanthans) {
		this.dacdienlichsubanthans = dacdienlichsubanthans;
	}

}
