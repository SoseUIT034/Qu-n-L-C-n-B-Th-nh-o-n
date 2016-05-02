package com.springmvc.qlcb.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.service.UserService;

@Controller
public class DangNhapsController {
	private static final Logger logger = LoggerFactory.getLogger(TrangChusController.class);
	
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLoginForm(HttpSession session,Model model) {
		
		model.addAttribute("Taikhoan", new Taikhoan()); 
		
		Taikhoan tk= (Taikhoan) session.getAttribute("loggedInUser");
		
		if(tk!=null)
		{
			return "redirect:/create";
		}
		else
		{
			return "/login/login";
		}
		
	}

	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String verifyLogin(@ModelAttribute(value = "Taikhoan") Taikhoan tk, ModelMap modelMap, HttpSession session) {
		
		if (userService.getUser(tk) == null) {
			
			//modelMap.put("loginError", "Error logging in. Please try again");
			
			return "/login/login";
		}
		else
		{
			session.setAttribute("loggedInUser", tk);
			logger.info("Login Success");
			  
			return "redirect:/create";
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "redirect:/login";
	}
}
