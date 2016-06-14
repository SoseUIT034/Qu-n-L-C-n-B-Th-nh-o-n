package com.springmvc.qlcb.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
 

import org.apache.catalina.connector.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.qlcb.dao.TonGiaoDAO;
import com.springmvc.qlcb.dao.TrinhDoChinhTriDAO;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.Congtacnuocngoai;
import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.Tongiao;
import com.springmvc.qlcb.model.Trinhdochinhtri;
import com.springmvc.qlcb.service.DanTocService;
import com.springmvc.qlcb.service.LyLichService;
import com.springmvc.qlcb.service.NgoaiNguService;
import com.springmvc.qlcb.service.TonGiaoService;
import com.springmvc.qlcb.service.TrinhDoChinhTriService;
import com.springmvc.qlcb.service.TrinhDoChuyenMonService;
@Controller
public class TrinhdochinhtriController {

 
	@Autowired
	private TrinhDoChinhTriService  tg ;
	 
	
	
 
	
	@RequestMapping(value = { "/createtrinhdochinhtri"}, method = RequestMethod.GET)
	public String Create(HttpSession session, HttpServletRequest request,Model model) {
		
		// header
//		Taikhoan tk = (Taikhoan) session.getAttribute("loggedInUser");
//		if(tk!=null)
//		{
//			request.setAttribute("KEY_LOGINED", 1);
//			request.setAttribute("NAME_LOGINED", tk.getTenDangNhap());
//		}
//		else
//		{
//			request.setAttribute("KEY_LOGINED", 0);
//		}
		//
		
		model.addAttribute("trinhdochinhtri", new Trinhdochinhtri());  
		return "/Trinhdochinhtri/themmoi_trinhdochinhtri";
	}
	
	

	@RequestMapping(value = { "/createtrinhdochinhtri"}, method = RequestMethod.POST)
	public String DoCreate(@Valid @ModelAttribute(value = "trinhdochinhtri")  Trinhdochinhtri  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
			if(bindingResult.hasErrors())
			{
				return "/Trinhdochinhtri/themmoi_trinhdochinhtri";
			}
			else {
				tg.save(data);
				 
				return "redirect:/listtrinhdochinhtri"; 
			}
		    
	}
	
	

	@RequestMapping(value = { "/listtrinhdochinhtri"}, method = RequestMethod.GET)
	public String List( HttpSession session, HttpServletRequest request,Model model) {
		
		// header
//		Taikhoan tk = (Taikhoan) session.getAttribute("loggedInUser");
//		if(tk!=null)
//		{
//			request.setAttribute("KEY_LOGINED", 1);
//			request.setAttribute("NAME_LOGINED", tk.getTenDangNhap());
//		}
//		else
//		{
//			request.setAttribute("KEY_LOGINED", 0);
//		}
		//-dropdownlist----
		
		 
	 
		// model
	    ArrayList<Trinhdochinhtri>  tongiao = new ArrayList<Trinhdochinhtri>();
		
		tongiao= (ArrayList<Trinhdochinhtri>)tg.listTrinhDoChinhTri() ; 
		model.addAttribute("listtrinhdochinhtri", tongiao);  
		
		return "/Trinhdochinhtri/list_trinhdochinhtri";
	}
	
	
	@RequestMapping(value = { "/edittrinhdochinhtri/{id}"}, method = RequestMethod.GET)
	public String Edit(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
		// header
//		Taikhoan tk = (Taikhoan) session.getAttribute("loggedInUser");
//		if(tk!=null)
//		{
//			request.setAttribute("KEY_LOGINED", 1);
//			request.setAttribute("NAME_LOGINED", tk.getTenDangNhap());
//		}
//		else
//		{
//			request.setAttribute("KEY_LOGINED", 0);
//		}
		//-dropdownlist----
		
		 
		// model
		Trinhdochinhtri tongiao = new Trinhdochinhtri();
		
		tongiao= tg.getTrinhDoChinhTriById(id);
		 
		model.addAttribute("trinhdochinhtri", tongiao);  
		
		return "/Trinhdochinhtri/sua_trinhdochinhtri";
	}
	
	
	@RequestMapping(value = { "/edittrinhdochinhtri/{id}"}, method = RequestMethod.POST) 
	public String Edit(@Valid @ModelAttribute(value = "trinhdochinhtri")  Trinhdochinhtri  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
			if(bindingResult.hasErrors())
			{
				return "/Trinhdochinhtri/sua_trinhdochinhtri";
			}
			else {
				 tg.update(data);
				 
			     return "redirect:/listtrinhdochinhtri"; 
			}
		    
	}
}
