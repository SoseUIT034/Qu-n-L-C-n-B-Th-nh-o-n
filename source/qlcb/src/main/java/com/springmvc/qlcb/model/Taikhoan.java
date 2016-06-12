package com.springmvc.qlcb.model;
// Generated Apr 25, 2016 2:33:53 PM by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.hibernate.validator.constraints.Length;

/**
 * Taikhoan generated by hbm2java
 */
@Entity
@Table(name = "taikhoan", catalog = "qlcb", uniqueConstraints = @UniqueConstraint(columnNames = "TenDangNhap"))
public class Taikhoan implements java.io.Serializable {

	private int maCanBo;
	private Canbo canbo;
	/*@NotNull(message="Không được để trống trường tên đăng nhập")
	@Length(min=8,message="Tên đăng nhập phải nhiều hơn 8 ký tự")*/
	private String tenDangNhap;
	/*@NotNull(message="Không được để trống mật khẩu")
	@Length(min=8, message="Mật khẩu phải có ít nhất 8 ký tự")*/
	private String matKhau;

	public Taikhoan() {
	}

	public Taikhoan(Canbo canbo, String tenDangNhap, String matKhau) {
		this.canbo = canbo;
		this.tenDangNhap = tenDangNhap;
		this.matKhau = matKhau;
	}

	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "canbo"))
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "MaCanBo", unique = true, nullable = false)
	public int getMaCanBo() {
		return this.maCanBo;
	}

	public void setMaCanBo(int maCanBo) {
		this.maCanBo = maCanBo;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public Canbo getCanbo() {
		return this.canbo;
	}

	public void setCanbo(Canbo canbo) {
		this.canbo = canbo;
	}

	@Column(name = "TenDangNhap", unique = true, nullable = false, length = 50)
	public String getTenDangNhap() {
		return this.tenDangNhap;
	}

	public void setTenDangNhap(String tenDangNhap) {
		this.tenDangNhap = tenDangNhap;
	}

	@Column(name = "MatKhau", nullable = false, length = 50)
	public String getMatKhau() {
		return this.matKhau;
	}

	public void setMatKhau(String matKhau) {
		this.matKhau = matKhau;
	}

}
