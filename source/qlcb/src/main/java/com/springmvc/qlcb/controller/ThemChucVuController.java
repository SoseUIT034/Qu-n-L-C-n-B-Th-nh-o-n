package com.springmvc.qlcb.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.qlcb.model.Ban;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.CanboBan;
import com.springmvc.qlcb.model.CanboBanId;
import com.springmvc.qlcb.model.CanboDonvi;
import com.springmvc.qlcb.model.CanboDonviId;
import com.springmvc.qlcb.model.Chucvuban;
import com.springmvc.qlcb.model.Chucvudonvi;
import com.springmvc.qlcb.model.Donvi;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.service.BanService;
import com.springmvc.qlcb.service.CanBoService;
import com.springmvc.qlcb.service.CanboBanService;
import com.springmvc.qlcb.service.CanboDonviService;
import com.springmvc.qlcb.service.ChucvuBanService;
import com.springmvc.qlcb.service.ChucvuDonviService;
import com.springmvc.qlcb.service.DonViService;
import com.springmvc.qlcb.service.LyLichService;

import java.util.*;

@Controller
public class ThemChucVuController {
	
	@Autowired
	DonViService _donViService;
	@Autowired
	BanService _banService;
	@Autowired
	ChucvuBanService _chucVuService;
	@Autowired
	ChucvuDonviService _chucVuDonViService;
	@Autowired
	CanboBanService _canBoBanService;
	@Autowired
	CanboDonviService _canboDonviService;
	@Autowired
	LyLichService _lyLichService;
	@Autowired
	CanBoService _canboService;
	@RequestMapping(value = "/canbo/themchucvu/{canboid}", method = RequestMethod.GET)
	public String ThemChucVu(@PathVariable("canboid") String canbo,
			HttpSession session, 
			HttpServletRequest request, 
			Model model) {
		int canboid = Integer.parseInt(canbo);
		List<Donvi> donViList = _donViService.listDonVi();
		model.addAttribute("donViList", donViList);
		Lylich lylich = _lyLichService.getLyLichById(canboid);
		model.addAttribute("lyLich", lylich);
		List<Ban> banList = _banService.listBan();
		for (Ban item : banList) {
			item.setDonvi(_donViService.getDonViById(item.getMaDonVi()));
		}
		model.addAttribute("banList", banList);
		List<Chucvuban> chucVuBanList = _chucVuService.listChucvuBan(); 
		model.addAttribute("chucVuBanList", chucVuBanList);
		List<Chucvudonvi> chucVuDonViList = _chucVuDonViService.listChucvuDonvi();
		model.addAttribute("chucVuDonViList", chucVuDonViList);
		List<CanboBan> canboBans = _canBoBanService.listCanBoBanByCanBo(canboid);
		for (CanboBan item : canboBans) {
			Ban temp = _banService.getBanById(item.getBan().getMaBan());
			temp.setDonvi(_donViService.getDonViById(temp.getMaDonVi()));
			item.setBan(temp);
			item.setChucvuban(_chucVuService.getChucvuBanById(item.getChucvuban().getMaChucVu()));
		}
		
		model.addAttribute("bans", canboBans);
		List<CanboDonvi> donvis = _canboDonviService.listCanboDonviByCanBo(canboid);
		for (CanboDonvi item : donvis) {
			item.setDonvi(_donViService.getDonViById(item.getDonvi().getMaDonVi()));
			item.setChucvudonvi(_chucVuDonViService.getByChucvuDonviId(item.getChucvudonvi().getMaChucVu()));
		}
		model.addAttribute("donvis", donvis);
		model.addAttribute("idcanbo", canbo);
		return "/themchucvu/themchucvu";
	}
	
	@RequestMapping(value = "/canbo/xoachucvuban/{idcanbo}/{idban}/{idchucvu}", method=RequestMethod.GET)
	public String XoaChucVuBan(@PathVariable("idcanbo") String idcanbo,
			@PathVariable("idban") String idban, 
			@PathVariable("idchucvu") String idchucvu,
			HttpSession session, 
			HttpServletRequest request,
			Model model) {		
		try {
			CanboBan canboBan = _canBoBanService.getCanboBan(Integer.parseInt(idcanbo),
					Integer.parseInt(idban),
					Integer.parseInt(idchucvu));
			_canBoBanService.delete(canboBan.getId());
			
			return "redirect:/canbo/themchucvu/" + idcanbo;
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("error", e.getMessage());
		}
		
		return "/themchucvu/error";
	}
	
	@RequestMapping(value = "/canbo/themchucvuban/{idcanbo}", method = RequestMethod.POST)
	public String ThemChucVuBan(@PathVariable("idcanbo") String idcanbo ,
			@RequestParam("ban") String idban, 
			@RequestParam("chucvu") String idchucvu,
			Model model) {
		
		CanboBan canBoBan = new CanboBan();
		try {
			
			int idban1 = Integer.parseInt(idban);
		
			Ban ban = _banService.getBanById(idban1);
			
			int idchucvu1 = Integer.parseInt(idchucvu);
			
			Chucvuban chucvuban = _chucVuService.getChucvuBanById(idchucvu1);
		
			int idcanbo1 = Integer.parseInt(idcanbo);
			
			Canbo canbo = _canboService.getCanBoById(idcanbo1);
			
			CanboBanId canbobanid = new CanboBanId(ban.getMaBan(), canbo.getMaCanBo());
			
			canBoBan.setId(canbobanid);
			canBoBan.setBan(ban);
			canBoBan.setCanbo(canbo);
			canBoBan.setChucvuban(chucvuban);
			
			
			_canBoBanService.save(canBoBan);
			
			return "redirect:/canbo/themchucvu/" +  idcanbo;
		}
		catch (Exception ex)  {
			model.addAttribute("error", ex.getMessage());
		
		}
		
		return "/themchucvu/error";
	}

	@RequestMapping(value = "/canbo/themchucvudonvi/{idcanbo}", method=RequestMethod.POST)
	public String ThemChucVuDonVi(@PathVariable("idcanbo") String idcanbo,
			@RequestParam("donvi") String iddonvi,
			@RequestParam("chucvu") String idchucvu,
			Model model) {
		CanboDonvi canboDonvi = new CanboDonvi();
		try {
			Canbo canbo = _canboService.getCanBoById(Integer.parseInt(idcanbo));
			Donvi donvi = _donViService.getDonViById(Integer.parseInt(iddonvi));
			Chucvudonvi chucvudonvi = _chucVuDonViService.getByChucvuDonviId(Integer.parseInt(idchucvu));
			CanboDonviId id = new CanboDonviId(canbo.getMaCanBo(), donvi.getMaDonVi());
			
			canboDonvi.setId(id);
			canboDonvi.setCanbo(canbo);
			canboDonvi.setDonvi(donvi);
			canboDonvi.setChucvudonvi(chucvudonvi);
			
			_canboDonviService.save(canboDonvi);
			
			return "redirect:/canbo/themchucvu/" + idcanbo;	
		}
		catch(Exception ex) {
			model.addAttribute("error", ex.getMessage());
		}
		return "/themchucvu/error";
	}
	
	@RequestMapping(value = "/canbo/xoachucvudonvi/{idcanbo}/{iddonvi}/{idchucvu}", method=RequestMethod.GET)
	public String XoaChucVuDonVi(@PathVariable("idcanbo") String idcanbo,
			@PathVariable("iddonvi") String iddonvi,
			@PathVariable("idchucvu") String idchucvu,
			Model model) {
		
		try {
			CanboDonvi canboDonvi = _canboDonviService.getCanboDonvi(Integer.parseInt(idcanbo),
					Integer.parseInt(iddonvi),
					Integer.parseInt(idchucvu));
			_canboDonviService.delete(canboDonvi.getId());
			
			return "redirect:/canbo/themchucvu/" + idcanbo;
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("error", e.getMessage());
		}
		
		return "/themchucvu/error";		
	}
	
}
