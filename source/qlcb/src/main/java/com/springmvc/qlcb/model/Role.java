package com.springmvc.qlcb.model;
// Generated May 30, 2016 7:31:33 AM by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.List;

import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * Role generated by hbm2java
 */
@Entity
@Table(name = "role", catalog = "qlcb")
public class Role implements java.io.Serializable {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	private String roleName;
	
	@ManyToMany(mappedBy = "roles")
	private List<Taikhoan> taikhoans;

	public Role() {
	}

	public Role(int id, String roleName, List<Taikhoan> taikhoans) {
		this.id = id;
		this.roleName = roleName;
		this.taikhoans = taikhoans;
	}

	public Role(String roleName) {
		this.roleName = roleName;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<Taikhoan> getTaiKhoan() {
		return taikhoans;
	}

	public void setUsers(List<Taikhoan> taikhoans) {
		this.taikhoans = taikhoans;
	}

}
