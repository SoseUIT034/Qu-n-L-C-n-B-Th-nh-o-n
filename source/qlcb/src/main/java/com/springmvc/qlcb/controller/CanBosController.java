package com.springmvc.qlcb.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
 

import org.apache.catalina.connector.Request;
import org.apache.commons.io.IOUtils;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.qlcb.dao.TonGiaoDAO;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.Congtacnuocngoai;
import com.springmvc.qlcb.model.Dantoc;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.service.DanTocService;
import com.springmvc.qlcb.service.LyLichService;
import com.springmvc.qlcb.service.NgoaiNguService;
import com.springmvc.qlcb.service.TonGiaoService;
import com.springmvc.qlcb.service.TrinhDoChinhTriService;
import com.springmvc.qlcb.service.TrinhDoChuyenMonService;
@Controller
public class CanBosController {

 
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
	
	
 
	
	@RequestMapping(value = { "/create"}, method = RequestMethod.GET)
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
		//-dropdownlist----
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		 
		Lylich l = new Lylich();
		 l.setFileLTN(null);
		model.addAttribute("Lylich", l);  
		return "/lylich_canbo/themmoi_canbo";
	}
	
	

	@RequestMapping(value = { "/create"}, method = RequestMethod.POST)
	public String DoCreate(@Valid @ModelAttribute(value = "Lylich")  Lylich  data ,BindingResult bindingResult,HttpServletRequest request,  Map<String, Object> model  ) 
	{ 
		if(bindingResult.hasErrors())
		{
			((Model) model).addAttribute("listdantoc", dt.listDanToc() );
			((Model) model).addAttribute("listtocgiao", tg.listTonGiao());
			((Model) model).addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
			((Model) model).addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
			((Model) model).addAttribute("listngoaingu", nn.listNgoaiNgu());
			
			 
			/*Lylich l = new Lylich();
			 l.setFileLTN(null);
			model.addAttribute("Lylich", l);  */
			return "/lylich_canbo/themmoi_canbo";
		}
		else {
			String fileName = data.getFileLTN().getOriginalFilename();
			String realPath = request.getSession().getServletContext().getRealPath("/");
			String relativePath = "resources" + File.separator + "upload" + File.separator + "images";
			String storedFolderLocation = realPath + relativePath;

			//if(data.getFileLTN()!=null)
			if(fileName!="")
			{
				File dir = new File(storedFolderLocation);
				if (!dir.exists()) {
					dir.mkdirs();
				}
				try {
					byte[] bytes = data.getFileLTN().getBytes();
					String storedFileLocation = storedFolderLocation + File.separator + fileName;
					System.out.println(storedFileLocation);
					File serverFile = new File(storedFileLocation);
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
					stream.write(bytes);
					stream.close();
					data.setHinhanh(storedFileLocation);
					l.save(data);
					return "redirect:/list"; 
		
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}
					
				l.save(data);
			    return "redirect:/list"; 
		}
		
	}
	
	
	@RequestMapping(value = { "/detail/{id}"}, method = RequestMethod.GET)
	public String Detail(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
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
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		
		
		
		
		
		
	 
		// model
		Lylich lylich = new Lylich();
		
		lylich= l.getLyLichById(id);
		 
		
		 	
		
		model.addAttribute("Lylich", lylich);  
		
		return "/lylich_canbo/chitiet_canbo";
	}
	@RequestMapping(value = { "/profile/{id}"}, method = RequestMethod.GET)
	public String profile(@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
		
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
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		
		
		
		
		
		
	 
		// model
		Lylich lylich = new Lylich();
		
		lylich= l.getLyLichById(id);
		 
		
		 	
		
		model.addAttribute("Lylich", lylich);  
		
		return "/profile/sua_profile";
	}
	@RequestMapping(value = { "/profile/{id}"}, method = RequestMethod.POST)
	public String Doprofile(@Valid @ModelAttribute(value = "Lylich")  Lylich  data   ,@PathVariable int id,HttpSession session, HttpServletRequest request,Model model) {
	   
		Lylich 	tempdata = l.getLyLichById(id); 
		tempdata.setMatkhauLTN(data.getMatkhauLTN());
		l.updatefrfile(tempdata); 
		return "/profile/sua_profile"; 
	}

	@RequestMapping(value = { "/list"}, method = RequestMethod.GET)
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
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		
	 
		// model
	    ArrayList<Lylich>  lylich = new ArrayList<Lylich>();
		
		lylich= (ArrayList<Lylich>) l.listLyLich() ; 
		model.addAttribute("listLylich", lylich);  
		
		return "/lylich_canbo/list_canbo";
	}
	
	
	
	@RequestMapping(value = { "/edit/{id}"}, method = RequestMethod.GET)
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
		
		model.addAttribute("listdantoc", dt.listDanToc() );
		model.addAttribute("listtocgiao", tg.listTonGiao());
		model.addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
		model.addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
		model.addAttribute("listngoaingu", nn.listNgoaiNgu());
		
		
		 
		// model
		Lylich lylich = new Lylich();
		
		lylich= l.getLyLichById(id);
		lylich.setFileLTN(null);
		model.addAttribute("Lylich", lylich);  
		
		return "/lylich_canbo/sua_canbo";
	}
	
	
	@RequestMapping(value = { "/edit/{id}"}, method = RequestMethod.POST) 
	public String Edit(@Valid @ModelAttribute(value = "Lylich")  Lylich  data  , BindingResult bindingResult, HttpServletRequest request, Map<String, Object> model ) 
	{
		if(bindingResult.hasErrors())
		{
			((Model) model).addAttribute("listdantoc", dt.listDanToc() );
			((Model) model).addAttribute("listtocgiao", tg.listTonGiao());
			((Model) model).addAttribute("listchuyenmon", tdcm.listTrinhDoChuyenMon() );
			((Model) model).addAttribute("listchinhtri", tdct.listTrinhDoChinhTri());
			((Model) model).addAttribute("listngoaingu", nn.listNgoaiNgu()); 
			// model
			  
			((Model) model).addAttribute("Lylich", data);  
			
			return "/lylich_canbo/sua_canbo";
		}
		else {
			String fileName = data.getFileLTN().getOriginalFilename();
			String realPath = request.getSession().getServletContext().getRealPath("/");
			String relativePath = "resources" + File.separator + "upload" + File.separator + "images";
			String storedFolderLocation = realPath + relativePath;

			if(data.getFileLTN().getSize()!=0)
			{
				File dir = new File(storedFolderLocation);
				if (!dir.exists()) {
					dir.mkdirs();
				}
				try {
					byte[] bytes = data.getFileLTN().getBytes();
					String storedFileLocation = storedFolderLocation + File.separator + fileName;
					System.out.println(storedFileLocation);
					File serverFile = new File(storedFileLocation);
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
					stream.write(bytes);
					stream.close();
					data.setHinhanh(storedFileLocation);
					l.update(data);
					return "redirect:/list"; 

				} catch (Exception e) {
					e.printStackTrace();
				}	 
			}
			Lylich temp = l.getLyLichById(data.getMacanbo());
			data.setHinhanh(temp.getHinhanh());
			l.update(data); 
			return "redirect:/list"; 
		}
		
	}


	 

}
