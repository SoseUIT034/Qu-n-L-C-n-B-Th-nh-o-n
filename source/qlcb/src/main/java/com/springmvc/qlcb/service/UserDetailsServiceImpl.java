package com.springmvc.qlcb.service;

import java.util.ArrayList;
import java.util.Collection;

import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.UserDAO;
import com.springmvc.qlcb.model.Role;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.UserStatus;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserDAO userDAO;

	@Transactional
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		Taikhoan user = userDAO.getUserByName(username);
		
		if (user != null) {
			
			//additional information on the security object
			String password = user.getPassword();
			boolean enabled = user.getStatus().equals(UserStatus.ACTIVE);
			boolean accountNonExpired = user.getStatus().equals(UserStatus.ACTIVE);
			boolean credentialsNonExpired = user.getStatus().equals(UserStatus.ACTIVE);
			boolean accountNonLocked = user.getStatus().equals(UserStatus.ACTIVE);
			
			//Let's populate user roles
			Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			for(Role role: user.getRoles()){
				authorities.add(new GrantedAuthorityImpl(role.getRoleName()));
			}
			
			//Now let's create Spring Security User object
			org.springframework.security.core.userdetails.User userSecurity = new org.springframework.security.core.userdetails.User(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
			return userSecurity;
		}else{
			throw new UsernameNotFoundException("User Not Found!!!");
			}

	}

}
