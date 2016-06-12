package com.springmvc.qlcb.model;
// Generated Apr 25, 2016 2:33:53 PM by Hibernate Tools 4.3.1.Final

import java.util.List;

import javax.persistence.*;

/**
 * Taikhoan generated by hbm2java
 */
@Entity
//@Table(name = "taikhoan", catalog = "qlcb", uniqueConstraints = @UniqueConstraint(columnNames = "TenDangNhap"))
public class Taikhoan implements java.io.Serializable {

	@Id
	private int maCanBo;
	// private Canbo canbo;
	private String username;
	private String password;

	@ManyToMany
	@JoinTable(name = "UsersAndRoles", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
	private List<Role> roles;

	@Enumerated(EnumType.STRING)
	private UserStatus status;

	public Taikhoan() {
	}

	public Taikhoan(int maCanBo, String tenDangNhap, String matKhau, List<Role> roles, UserStatus status) {
		this.maCanBo = maCanBo;
		this.username = tenDangNhap;
		this.password = matKhau;
		this.roles = roles;
		this.status = status;
	}

	public int getMaCanBo() {
		return maCanBo;
	}

	public void setMaCanBo(int maCanBo) {
		this.maCanBo = maCanBo;
	}
	// @Column(name = "MaCanBo", unique = true, nullable = false)
	// public int getMaCanBo() {
	// return this.maCanBo;
	// }
	//
	// public void setMaCanBo(int maCanBo) {
	// this.maCanBo = maCanBo;
	// }

	// @Column(name = "TenDangNhap", unique = true, nullable = false, length =
	// 50)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String tenDangNhap) {
		this.username = tenDangNhap;
	}

	// @Column(name = "MatKhau", nullable = false, length = 50)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String matKhau) {
		this.password = matKhau;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public UserStatus getStatus() {
		return status;
	}

	public void setStatus(UserStatus status) {
		this.status = status;
	}

}
