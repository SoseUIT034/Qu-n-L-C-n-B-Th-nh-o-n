package com.springmvc.qlcb.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mysql.jdbc.log.Log;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model._Toanbothongtincanbo;
@Controller
public class CreateStaffController {

	@RequestMapping(value = { "/create"}, method = RequestMethod.GET)
	public String Index(HttpSession session, HttpServletRequest request) {
 
		
		Taikhoan tk = (Taikhoan) session.getAttribute("loggedInUser");
		if(tk!=null)
		{
			request.setAttribute("KEY_LOGINED", 1);
			request.setAttribute("NAME_LOGINED", tk.getTenDangNhap());
		}
		else
		{
			request.setAttribute("KEY_LOGINED", 0);
		}
		 
		return "/lylich_canbo/themmoi_canbo";
	}
	
	
	@RequestMapping(value = { "/create"}, method = RequestMethod.POST)
	public String create(HttpSession session, HttpServletRequest request,@ModelAttribute(value = "Taikhoan1") _Toanbothongtincanbo data) {
 
		 
		  
		return "redirect:/home";
	}
}
