package com.springmvc.qlcb.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.qlcb.model.Donvi;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.service.BanService;
import com.springmvc.qlcb.service.LyLichService;

@Controller
public class BanController {
	@RequestMapping(value = { "/createdonvi"}, method = RequestMethod.GET)
	public String Create(HttpSession session, HttpServletRequest request,Model model) {
		
		
		@Autowired
		BanService _banService;
		
		@Autowired
		LyLichService _lyLichService;
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
		//
		
		model.addAttribute("donvi", new Donvi());  
		model.addAttribute("listBan", _banService.listBan());  
		model.addAttribute("listtruongban", _lyLichService.listLyLich());  
		return "/ban/themban";
	}
	
	

	@RequestMapping(value = { "/createdonvi"}, method = RequestMethod.POST)
	public String DoCreate(@Valid @ModelAttribute(value = "donvi")  Donvi  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
 
		    tg.save(data);
		 
			return "redirect:/listdonvi"; 
	}
	
	

	@RequestMapping(value = { "/listdonvi"}, method = RequestMethod.GET)
	public String List( HttpSession session, HttpServletRequest request,Model model) {
		
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
		//-dropdownlist----
		
		 
	 
		// model
	    ArrayList<Donvi>  donvi = new ArrayList<Donvi>();
		
	    donvi= (ArrayList<Donvi>) tg.listDonVi() ; 
		model.addAttribute("listdonvi", donvi);  
		
		return "/Donvi/list_donvi";
	}
	
	
	@RequestMapping(value = { "/edittdonvi/{id}"}, method = RequestMethod.GET)
	public String Edit(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
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
		//-dropdownlist----
		
		 
		model.addAttribute("donvi", tg.getDonViById(id));  
		model.addAttribute("listKhoi", k.listKhoi());  
		model.addAttribute("listtruongdonvi", ll.listLyLich());  
 
		
		return "/Donvi/sua_donvi";
	}
	
	
	@RequestMapping(value = { "/edittdonvi/{id}"}, method = RequestMethod.POST) 
	public String Edit(@Valid @ModelAttribute(value = "donvi")  Donvi  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
 
		     tg.update(data);
		 
		     return "redirect:/listdonvi"; 
	}
}
