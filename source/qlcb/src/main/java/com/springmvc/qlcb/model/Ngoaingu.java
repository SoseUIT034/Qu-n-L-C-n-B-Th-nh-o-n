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
import javax.persistence.Table;

/**
 * Ngoaingu generated by hbm2java
 */
@Entity
@Table(name = "ngoaingu", catalog = "qlcb_new")
public class Ngoaingu implements java.io.Serializable {

	private int id;
	private String tenNgoaiNgu;
	private Set<Canbo> canbos = new HashSet<Canbo>(0);

	public Ngoaingu() {
	}

	public Ngoaingu(int id, String tenNgoaiNgu) {
		this.id = id;
		this.tenNgoaiNgu = tenNgoaiNgu;
	}

	public Ngoaingu(int id, String tenNgoaiNgu, Set<Canbo> canbos) {
		this.id = id;
		this.tenNgoaiNgu = tenNgoaiNgu;
		this.canbos = canbos;
	}

	@Id

	@Column(name = "ID", unique = true, nullable = false)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "TenNgoaiNgu", nullable = false, length = 200)
	public String getTenNgoaiNgu() {
		return this.tenNgoaiNgu;
	}

	public void setTenNgoaiNgu(String tenNgoaiNgu) {
		this.tenNgoaiNgu = tenNgoaiNgu;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "canbo_ngoaingu", catalog = "qlcb_new", joinColumns = {
			@JoinColumn(name = "MaNgoaiNgu", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "MaCanBo", nullable = false, updatable = false) })
	public Set<Canbo> getCanbos() {
		return this.canbos;
	}

	public void setCanbos(Set<Canbo> canbos) {
		this.canbos = canbos;
	}

}
