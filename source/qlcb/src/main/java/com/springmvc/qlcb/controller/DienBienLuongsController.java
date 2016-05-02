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
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.Congtacnuocngoai;
import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Dienbienluong;
import com.springmvc.qlcb.model.Lichsucongtac;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.service.DanTocService;
import com.springmvc.qlcb.service.DaoTaoChuyenMonService;
import com.springmvc.qlcb.service.LyLichService;
import com.springmvc.qlcb.service.NgoaiNguService;
import com.springmvc.qlcb.service.TonGiaoService;
import com.springmvc.qlcb.service.TrinhDoChinhTriService;
import com.springmvc.qlcb.service.TrinhDoChuyenMonService;
@Controller
@RequestMapping(value = "Dienbienluong")
public class DienBienLuongsController {

 
	/*@Autowired
	private DaoTaoChuyenMonService  daoTaoChuyenMonService ;
	*/
	
	@RequestMapping(value = { "create"}, method = RequestMethod.GET)
	public String Create(HttpSession session, HttpServletRequest request,Model model) {
		model.addAttribute("Dienbienluong", new Dienbienluong());  
		return "/lylich_canbo/DienBienLuong/create";
	}
	
	@RequestMapping(value ={"create"}, method = RequestMethod.POST)
	public String doCreate(@Valid @ModelAttribute(value = "Dienbienluong")  Dienbienluong  data,HttpSession session, HttpServletRequest request,Model model ) 
	{
 
		     // luu xong roi tra ve gia tri
		 
		return "/layout/masterpage";  
	}
	
	
	@RequestMapping(value = {"edit/{id}"}, method = RequestMethod.GET)
	public String Edit(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
		Dienbienluong d=new Dienbienluong();
		d.setId(id); 
		model.addAttribute("Dienbienluong", d); 
		return "/lylich_canbo/DienBienLuong/edit";
	}
	
	@RequestMapping(value ="edit", method = RequestMethod.POST)
	public String doEdit(@Valid @ModelAttribute(value = "Dienbienluong")  Dienbienluong  data,HttpSession session, HttpServletRequest request,Model model ) 
	{
 
		     // luu xong roi tra ve gia tri
		 
		return "/layout/masterpage";  
	}
	
	
	@RequestMapping(value = { "delete/{id}"}, method = RequestMethod.GET)
	public String Delete(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		Dienbienluong d=new Dienbienluong();
		d.setId(id);
		model.addAttribute("Dienbienluong", d);  
		return "/lylich_canbo/DienBienLuong/delete";
	}
	
	@RequestMapping(value = { "delete/{id}"}, method = RequestMethod.POST)
	public String doDelete(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
		return "/layout/masterpage";  
	}
	
	 
}
