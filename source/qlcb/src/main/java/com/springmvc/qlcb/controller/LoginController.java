package com.springmvc.qlcb.controller;


import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;


import org.hamcrest.core.IsNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mysql.jdbc.log.Log;
import com.springmvc.qlcb.model.User;
import com.springmvc.qlcb.service.UserService;
import com.springmvc.qlcb.service.UserServiceImpl;

@Controller
public class LoginController {

	
	@RequestMapping(value ="/login" , method = RequestMethod.GET)
	public String home( Model model) {
		model.addAttribute("account", new User()); 
		return "login/login";
	}
	
	@RequestMapping(value ="/dologin" , method = RequestMethod.POST)
	public String home(HttpServletRequest request,@ModelAttribute("account") User acc  ) {
		
		UserServiceImpl userservice = new UserServiceImpl();
		
		if(userservice.CheckUser(acc)==true)
		{
			request.getSession().setAttribute("KEY_LOGIN", acc.getUsername());
			return "redirect:/index";
		}
		else
		{
			// bao loi 
		}
		
		 
		return "redirect:/login";
	}
	
	
	@RequestMapping(value ="/fogotpassword" , method = RequestMethod.GET)
	public String home() {
		 
		return "home/index";
	}
	
	
}
