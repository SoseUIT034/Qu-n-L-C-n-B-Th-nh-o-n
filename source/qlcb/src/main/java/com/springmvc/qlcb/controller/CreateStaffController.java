package com.springmvc.qlcb.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.Congtacnuocngoai;
import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
@Controller
public class CreateStaffController {

	      
	
	private Set<Congtacnuocngoai> t;


	@RequestMapping(value = { "/create"}, method = RequestMethod.GET)
	public String Index(HttpSession session, HttpServletRequest request,Model model) {
		// header
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
		//=----
		Dantoc d = new Dantoc(1,"adasd");
		Dantoc dd = new Dantoc(2,"bbbbb");
		ArrayList<Dantoc> l= new ArrayList<Dantoc>();
		l.add(d); l.add(dd);
		// send data to dropdown list
		model.addAttribute("listdantoc", l );
		model.addAttribute("listtocgiao", null);
		model.addAttribute("listchuyenmon", null );
		model.addAttribute("listchinhtri", null);
		model.addAttribute("listngoaingu", null);
		// model
		model.addAttribute("Lylich", new Lylich()); 
		
		
		return "/lylich_canbo/themmoi_canbo";
	}
	
	

	@RequestMapping(value = { "/create"}, method = RequestMethod.POST)
	public String create(@ModelAttribute(value = "Lylich") Lylich  data, HttpServletRequest request) 
	{
		
		request.getParameter("fileupload");
		 
		
		return "redirect:/home";
	}

}
