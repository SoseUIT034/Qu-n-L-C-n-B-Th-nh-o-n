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
import com.springmvc.qlcb.model.Ngoaingu;
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
public class DantocController {

 
	@Autowired
	private DanTocService  tg ;
	 
	 
 
	
	@RequestMapping(value = { "/createdantoc"}, method = RequestMethod.GET)
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
		
		model.addAttribute("dantoc", new Dantoc());  
		return "/Dantoc/themmoi_dantoc";
	}
	
	

	@RequestMapping(value = { "/createdantoc"}, method = RequestMethod.POST)
	public String DoCreate(@Valid @ModelAttribute(value = "dantoc")  Dantoc  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
 
		    tg.save(data);
		 
			return "redirect:/listdantoc"; 
	}
	
	

	@RequestMapping(value = { "/listdantoc"}, method = RequestMethod.GET)
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
	    ArrayList<Dantoc>  nn = new ArrayList<Dantoc>();
		
		nn= (ArrayList<Dantoc>)tg.listDanToc() ; 
		model.addAttribute("dantoc", nn);  
		
		return "/Dantoc/list_dantoc";
	}
	
	
	@RequestMapping(value = { "/editdantoc/{id}"}, method = RequestMethod.GET)
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
		Dantoc tongiao = new Dantoc();
		
		tongiao= tg.getDanTocById(id);
		 
		model.addAttribute("dantoc", tongiao);  
		
		return "/Dantoc/sua_dantoc";
	}
	
	
	@RequestMapping(value = { "/editdantoc/{id}"}, method = RequestMethod.POST) 
	public String Edit(@Valid @ModelAttribute(value = "dantoc")  Dantoc  data  ) 
	{
 
		     tg.update(data);
		 
		     return "redirect:/listdantoc"; 
	}
}
