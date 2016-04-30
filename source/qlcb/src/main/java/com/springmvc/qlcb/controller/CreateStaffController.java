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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.qlcb.dao.TonGiaoDAO;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.Congtacnuocngoai;
import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.service.DanTocService;
import com.springmvc.qlcb.service.LyLichService;
import com.springmvc.qlcb.service.NgoaiNguService;
import com.springmvc.qlcb.service.TonGiaoService;
import com.springmvc.qlcb.service.TrinhDoChinhTriService;
import com.springmvc.qlcb.service.TrinhDoChuyenMonService;
@Controller
public class CreateStaffController {

 
	@Autowired
	private LyLichService  l ;
	@Autowired
	private DanTocService  dt ;
	@Autowired
	private TonGiaoService  tg ;
	@Autowired
	private TrinhDoChuyenMonService  tdcm ;
	@Autowired
	private TrinhDoChinhTriService  tdct ;
	@Autowired
	private NgoaiNguService  nn ;
	
	
	@RequestMapping(value = { "/a"}, method = RequestMethod.GET)
	public String asd(HttpSession session, HttpServletRequest request,Model model) {
		
		 
		return "/layout/masterpage";
	}
	
	
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
		//-dropdownlist----
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		/*model.addAttribute("listdantoc", null );
		model.addAttribute("listtocgiao", null);
		model.addAttribute("listchuyenmon", null );
		model.addAttribute("listchinhtri", null);
		model.addAttribute("listngoaingu", null);*/
		// model
		model.addAttribute("Lylich", new Lylich());  
		return "/lylich_canbo/themmoi_canbo";
	}
	
	

	@RequestMapping(value = { "/create"}, method = RequestMethod.POST)
	public String create(@Valid @ModelAttribute(value = "Lylich")  Lylich  data ,BindingResult bindingResult,  Map<String, Object> model ) 
	{
 
		     l.save(data);
		 
			return "/layout/masterpage";
		 
		
		
	}

}
