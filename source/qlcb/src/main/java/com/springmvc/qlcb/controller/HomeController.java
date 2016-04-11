package com.springmvc.qlcb.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.qlcb.model.User;
import com.springmvc.qlcb.service.UserServiceImpl;


@Controller
public class HomeController {
	
	
	@RequestMapping(value ="/home" , method = RequestMethod.GET)
	public String home() {
		 
		return "lylich_canbo/themmoi_canbo";
		//return "layout/masterpage";
	}
}
