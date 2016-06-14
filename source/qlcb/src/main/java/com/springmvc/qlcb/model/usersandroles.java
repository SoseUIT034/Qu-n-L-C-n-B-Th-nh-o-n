package com.springmvc.qlcb.model;
// Generated Apr 25, 2016 2:33:53 PM by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name = "usersandroles", catalog = "qlcb")
public class usersandroles implements java.io.Serializable {

	private usersandrolesId id;
	private Taikhoan taikhoan;
	private Role role;
	 
	public usersandroles() {
	}

	public usersandroles(usersandrolesId id) {
		this.id = id;
		 
	}

	@EmbeddedId

	@AttributeOverrides({ @AttributeOverride(name = "user_id", column = @Column(name = "user_id", nullable = false)),
			@AttributeOverride(name = "role_id", column = @Column(name = "role_id", nullable = false)) })
	public usersandrolesId getId() {
		return this.id;
	}

	public void setId(usersandrolesId id) {
		this.id = id;
	}
 
	 
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false, insertable = false, updatable = false)
	public Taikhoan getTaikhoan() {
		return this.taikhoan;
	}

	public void setTaikhoan(Taikhoan taikhoan) {
		this.taikhoan = taikhoan;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "role_id", nullable = false, insertable = false, updatable = false)
	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
}
