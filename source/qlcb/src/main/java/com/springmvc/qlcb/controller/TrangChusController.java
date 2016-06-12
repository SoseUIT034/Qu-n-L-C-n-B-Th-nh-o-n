package com.springmvc.qlcb.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.qlcb.model.Taikhoan;

@Controller
public class TrangChusController {
 
	@RequestMapping("/login")
	public String doLogin() {
		return "/login/login";
	}

	@RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
	public String homePage() {
		return "redirect:/create";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout() {
		return "redirect:/login";
	}
 

//	@RequestMapping(value = {"/","/home"}, method = RequestMethod.GET)
//	public String homePage(HttpSession session, HttpServletRequest request) {
////		logger.info("Welcome home!");
////		
////		Taikhoan tk = (Taikhoan) session.getAttribute("loggedInUser");
////		if(tk!=null)
////		{
////			request.setAttribute("KEY_LOGINED", 1);
////			request.setAttribute("NAME_LOGINED", tk.getTenDangNhap());
////		}
////		else
////		{
////			request.setAttribute("KEY_LOGINED", 0);
////		}
////		 
////		return "/lylich_canbo/themmoi_canbo";
//		return null;
//	}
}
