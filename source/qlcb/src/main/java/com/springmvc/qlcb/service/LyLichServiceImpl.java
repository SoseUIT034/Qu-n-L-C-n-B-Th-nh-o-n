package com.springmvc.qlcb.service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.helpers.DateTimeDateFormat;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.BanDAO;
import com.springmvc.qlcb.dao.CanBoDAO;
import com.springmvc.qlcb.dao.CanBoGiaDinhBanThanDAO;
import com.springmvc.qlcb.dao.CanBoGiaDinhDoiTacDAO;
import com.springmvc.qlcb.dao.CanboBanDAO;
import com.springmvc.qlcb.dao.CanboDonviDAO;
import com.springmvc.qlcb.dao.ChucvuBanDAO;
import com.springmvc.qlcb.dao.ChucvuDonviDAO;
import com.springmvc.qlcb.dao.DacDiemLichSuBanThanDAO;
import com.springmvc.qlcb.dao.DanTocDAO;
import com.springmvc.qlcb.dao.DaoTaoChuyenMonDAO;
import com.springmvc.qlcb.dao.DienBienLuongDAO;
import com.springmvc.qlcb.dao.DonViDAO;
import com.springmvc.qlcb.dao.HibernateUtils;
import com.springmvc.qlcb.dao.LichSuCongTacDAO;
import com.springmvc.qlcb.dao.LyLichDAO;
import com.springmvc.qlcb.dao.NgoaiNguDAO;
import com.springmvc.qlcb.dao.RoleDAO;
import com.springmvc.qlcb.dao.TonGiaoDAO;
import com.springmvc.qlcb.dao.TrinhDoChinhTriDAO;
import com.springmvc.qlcb.dao.TrinhDoChuyenMonDAO;
import com.springmvc.qlcb.dao.UserDAO;
import com.springmvc.qlcb.dao.UserandroleDAOImpl;
import com.springmvc.qlcb.model.Canbo;
import com.springmvc.qlcb.model.CanboGiadinhBanthan;
import com.springmvc.qlcb.model.CanboGiadinhDoitac;
import com.springmvc.qlcb.model.Dacdienlichsubanthan;
import com.springmvc.qlcb.model.Daotaochuyenmon;
import com.springmvc.qlcb.model.Dienbienluong;
import com.springmvc.qlcb.model.Lichsucongtac;
import com.springmvc.qlcb.model.Lylich;
import com.springmvc.qlcb.model.Taikhoan;
import com.springmvc.qlcb.model.UserStatus;
import com.springmvc.qlcb.model.usersandroles;
import com.springmvc.qlcb.model.usersandrolesId;

@Service
public class LyLichServiceImpl extends HibernateUtils implements LyLichService {

	private static final Logger logger = LoggerFactory.getLogger(LyLichServiceImpl.class);
	
	@Autowired
	private LyLichDAO lyLichDAO;
	
	@Autowired
	private UserandroleDAOImpl userandroleDAOImpl;
	
	@Autowired
	private RoleDAO roleDAO;
	
	@Autowired
	private DaoTaoChuyenMonDAO daoTaoChuyenMonDAO; 
	
	@Autowired
	private DienBienLuongDAO dienBienLuongDAO;
	
	@Autowired
	private CanBoDAO canBoDAO;
	
	@Autowired
	private LichSuCongTacDAO lichSuCongTacDAO;
	
	@Autowired
	private CanBoGiaDinhBanThanDAO canBoGiaDinhBanThanDAO;
	
	@Autowired
	private CanBoGiaDinhDoiTacDAO canBoGiaDinhDoiTacDAO;
	
	@Autowired
	private TonGiaoDAO tonGiaoDAO;
	
	@Autowired
	private UserDAO taikhoanDAO;
	
	@Autowired
	private DanTocDAO danTocDAO;
	
	@Autowired
	private NgoaiNguDAO ngoaiNguDAO;
	
	@Autowired
	private DacDiemLichSuBanThanDAO dacDiemLichSuBanThanDAO;
	
	@Autowired
	private CanboDonviDAO canboDonviDAO;
	
	@Autowired
	private DonViDAO donViDAO;
	
	@Autowired
	private ChucvuDonviDAO chucvuDonviDAO;
	
	@Autowired
	private CanboBanDAO anboBanDAO;
	
	@Autowired
	private BanDAO banDAO;
	
	@Autowired
	private ChucvuBanDAO chucvuBanDAO;
	
	
	
	public static String getMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger number = new BigInteger(1, messageDigest);
            String hashtext = number.toString(16);
            // Now we need to zero pad it if you actually want the full 32 chars.
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
 
						// save
	//------------
	private int genereteIDCanBoGiaDinhDoiTac(ArrayList<Integer> lint)
	{
		int thisid=0; 
		// generate id
		if(canBoGiaDinhDoiTacDAO.listcanboGiadinhDoitac() !=null)
		{
			thisid = canBoGiaDinhDoiTacDAO.listcanboGiadinhDoitac().size();
		} 
		while( canBoGiaDinhDoiTacDAO.getCanboGiadinhDoitacId(thisid)!=null  )
		{
			thisid++;
		}
		if(lint!= null)
		{
			while(lint.contains(new Integer(thisid)))
			{
				thisid++;
				while( canBoGiaDinhDoiTacDAO.getCanboGiadinhDoitacId(thisid)!=null  )
				{
					thisid++;
				}
			}
		}
		return thisid;
	}
	
	private ArrayList<Integer> _getListIDForCanBoGiaDinhDoiTac(Lylich lylich)
	{
		ArrayList<Integer> res = new ArrayList<Integer>();
		int count = lylich.getLqhdt().size();
		int index=0;
		while(index <count)
		{
			res.add( genereteIDCanBoGiaDinhDoiTac(res));
			index++;
		} 
		return res;
	}
	
	private int _saveCanBoGiaDinhDoiTac(Lylich lylich)
	{
		ArrayList<CanboGiadinhDoitac> arr = lylich.getLqhdt();
		ArrayList<Integer> a = _getListIDForCanBoGiaDinhDoiTac(lylich);
		if(arr!=null)
		{
			for(int i=0; i< arr.size(); i++)
			{ 
				arr.get(i).setCanbo(lylich.getCanboByMaCanBo()); 
				arr.get(i).setId(a.get(i));
				canBoGiaDinhDoiTacDAO.save(arr.get(i));
			}
		}
		return 0;
	}
	//------------
	
	//------------
	private int genereteIDCanBoGiaDinhBanThan(ArrayList<Integer> lint)
	{
		int thisid=0; 
		// generate id
		if(canBoGiaDinhBanThanDAO.listCanboGiadinhBanthan() !=null)
		{
			thisid = canBoGiaDinhBanThanDAO.listCanboGiadinhBanthan().size();
		} 
		while( canBoGiaDinhBanThanDAO.getCanboGiadinhBanthanById(thisid)!=null  )
		{
			thisid++;
		}
		if(lint!= null)
		{
			while(lint.contains(new Integer(thisid)))
			{
				thisid++;
				while( canBoGiaDinhBanThanDAO.getCanboGiadinhBanthanById(thisid)!=null  )
				{
					thisid++;
				}
			}
		}
		return thisid;
	}
	
	private ArrayList<Integer> _getListIDForCanBoGiaDinhBanThan(Lylich lylich)
	{
		ArrayList<Integer> res = new ArrayList<Integer>();
		int count = lylich.getLqhbt().size();
		int index=0;
		while(index <count)
		{
			res.add( genereteIDCanBoGiaDinhBanThan(res));
			index++;
		} 
		return res;
	}
	
	private int _saveCanBoGiaDinhBanThan(Lylich lylich)
	{
		ArrayList<CanboGiadinhBanthan> arr = lylich.getLqhbt();
		ArrayList<Integer> a = _getListIDForCanBoGiaDinhBanThan(lylich);
		if(arr!=null)
		{
			for(int i=0; i< arr.size(); i++)
			{ 
				arr.get(i).setCanbo(lylich.getCanboByMaCanBo()); 
				arr.get(i).setId(a.get(i));
				canBoGiaDinhBanThanDAO.save(arr.get(i));
			}
		}
		return 0;
	}
	//------------
	
	//------------
	private int genereteIDDienbienluong(ArrayList<Integer> lint)
	{
		int thisid=0; 
		// generate id
		if(dienBienLuongDAO.listDienBienLuong() !=null)
		{
			thisid = dienBienLuongDAO.listDienBienLuong().size();
		} 
		while( dienBienLuongDAO.getDienbienluongById(thisid)!=null  )
		{
			thisid++;
		}
		if(lint!= null)
		{
			while(lint.contains(new Integer(thisid)))
			{
				thisid++;
				while( dienBienLuongDAO.getDienbienluongById(thisid)!=null  )
				{
					thisid++;
				}
			}
		}
		return thisid;
	}
	
	private ArrayList<Integer> _getListIDForDienbienluong(Lylich lylich)
	{
		ArrayList<Integer> res = new ArrayList<Integer>();
		int count = lylich.getLdbl().size();
		int index=0;
		while(index <count)
		{
			res.add( genereteIDDienbienluong(res));
			index++;
		} 
		return res;
	}
	
	private int _saveDienbienluong(Lylich lylich)
	{
		ArrayList<Dienbienluong> arr = lylich.getLdbl();
		ArrayList<Integer> a = _getListIDForDienbienluong(lylich);
		if(arr!=null)
		{
			for(int i=0; i< arr.size(); i++)
			{ 
				arr.get(i).setLylich(lylich); 
				arr.get(i).setId(a.get(i));
				dienBienLuongDAO.save(arr.get(i));
			}
		}
		return 0;
	}
	//------------
	
	//------------
	private int genereteIDDaoTaoChuyenMon(ArrayList<Integer> lint)
	{
		int thisid=0; 
		// generate id
		if(daoTaoChuyenMonDAO.listDaoTaoChuyenMon() !=null)
		{
			thisid = daoTaoChuyenMonDAO.listDaoTaoChuyenMon().size();
		} 
		while( daoTaoChuyenMonDAO.getDaoTaoChuyenMonById(thisid)!=null  )
		{
			thisid++;
		}
		if(lint!= null)
		{
			while(lint.contains(new Integer(thisid)))
			{
				thisid++;
				while( daoTaoChuyenMonDAO.getDaoTaoChuyenMonById(thisid)!=null  )
				{
					thisid++;
				}
			}
		}
		return thisid;
	}
	
	private ArrayList<Integer> _getListIDForDaoTaoChuyenMon(Lylich lylich)
	{
		ArrayList<Integer> res = new ArrayList<Integer>();
		int count = lylich.getLdtcm().size();
		int index=0;
		while(index <count)
		{
			res.add( genereteIDDaoTaoChuyenMon(res));
			index++;
		} 
		return res;
	}
	
	private int _saveDaoTaoChuyenMon(Lylich lylich)
	{
		ArrayList<Daotaochuyenmon> arr = lylich.getLdtcm();
		ArrayList<Integer> a = _getListIDForDaoTaoChuyenMon(lylich);
		if(arr!=null)
		{
			for(int i=0; i< arr.size(); i++)
			{ 
				arr.get(i).setCanbo(lylich.getCanboByMaCanBo());
				arr.get(i).setMaDaoTao(a.get(i));
				daoTaoChuyenMonDAO.save(arr.get(i));
			}
		}
		return 0;
	}
	//------------
	
	//-------------
	private int genereteIDLichSuCongTac(ArrayList<Integer> lint)
	{
		int thisid=0; 
		// generate id
		if(lichSuCongTacDAO.listLichSuCongTac()!=null)
		{
			thisid = lichSuCongTacDAO.listLichSuCongTac().size();
		} 
		while( lichSuCongTacDAO.getLichSuCongTacById(thisid)!=null  )
		{
			thisid++;
		}
		if(lint!= null)
		{
			while(lint.contains(new Integer(thisid)))
			{
				
				thisid++;
				while( lichSuCongTacDAO.getLichSuCongTacById(thisid)!=null  )
				{
					thisid++;
				}
			}
		}
 
		return thisid;
	}
	
	private ArrayList<Integer> _getListIDForLichSuCongTac(Lylich lylich)
	{
		ArrayList<Integer> res = new ArrayList<Integer>();
		int count = lylich.getLsct().size();
		int index=0;
		while(index <count)
		{
			res.add( genereteIDLichSuCongTac(res));
			index++;
		} 
		return res;
	}
	
	private int _saveLichSuCongTac(Lylich lylich)
	{
		ArrayList<Lichsucongtac> arr = lylich.getLsct();
		ArrayList<Integer> a = _getListIDForLichSuCongTac(lylich);
		if(arr!=null)
		{
			for(int i=0; i< arr.size(); i++)
			{ 
				arr.get(i).setCanbo(lylich.getCanboByMaCanBo());
				arr.get(i).setMaLsct(a.get(i));
				lichSuCongTacDAO.save(arr.get(i));
			}
		}
		return 0;
	}
	//--------------
	
	//-------------
	private int genereteIDLichSuBanThan()
		{
			int thisid=0; 
			// generate id
			if(dacDiemLichSuBanThanDAO.listDacDiemLichSuBanThan()!=null)
			{
				thisid = dacDiemLichSuBanThanDAO.listDacDiemLichSuBanThan().size();
			} 
			while( dacDiemLichSuBanThanDAO.getDacDiemLichSuBanThanById(thisid)!=null  )
			{
				thisid++;
			}
	 
			return thisid;
		}
 
	
	private int _saveLichSuBanThan(Lylich lylich)
	{
		int id = genereteIDLichSuBanThan();
		 
		Dacdienlichsubanthan d = new Dacdienlichsubanthan();
		d.setCanbo(lylich.getCanboByMaCanBo() );
		d.setMaDdls(id);
		d.setNoidung1(lylich.getDacdienlichsubanthan().getNoidung1());
		d.setNoidung2(lylich.getDacdienlichsubanthan().getNoidung2());
		d.setNoiDung3(lylich.getDacdienlichsubanthan().getNoiDung3());
		dacDiemLichSuBanThanDAO.save(d);
			 
		return 0;
	}
	//--------------
	
	//-------------
		private int genereteIDlylich()
			{
				int thisid=0; 
				// generate id
				if(lyLichDAO.listLyLich()!=null)
				{
					thisid = lyLichDAO.listLyLich().size();
				} 
				while( lyLichDAO.getLyLichById(thisid)!=null  )
				{
					thisid++;
				}
		 
				return thisid;
			}
	//-----------------
	 
		private void saveTaikhoan(int macb, int matk)
		{
			Taikhoan tk=new Taikhoan();
			tk.setMaCanBo(macb);
			tk.setUsername(""+macb);
			tk.setPassword(getMD5(""+macb));
			tk.setStatus(UserStatus.ACTIVE);
			taikhoanDAO.saveUser(tk);
			
			usersandroles r =new usersandroles(new usersandrolesId(macb,matk));
			r.setTaikhoan(taikhoanDAO.getTKById(macb));
			r.setRole(roleDAO.getTKById(matk));
			userandroleDAOImpl.saveUser(r);
		}
		private void editTaikhoan(int macb, int matk)
		{
			Taikhoan tk=taikhoanDAO.getUserByName(""+macb);/*
			tk.setMaCanBo(macb);
			tk.setUsername(""+macb);
			tk.setPassword("asdasd");
			tk.setStatus(UserStatus.ACTIVE);
			taikhoanDAO.saveUser(tk);*/
			
			usersandroles r =new usersandroles(new usersandrolesId(macb,matk));
			r.setTaikhoan(tk);
			r.setRole(roleDAO.getTKById(matk));
			userandroleDAOImpl.deleteUser(macb);
			userandroleDAOImpl.saveUser(r);
		}
		
		private void editTaikhoanprofile(int macb, String matkhau)
		{
			if(matkhau.length()>0)
			{
				Taikhoan tk=taikhoanDAO.getTKById(macb);
				tk.setPassword( getMD5(matkhau));
				/*
				tk.setMaCanBo(macb);
				tk.setUsername(""+macb);
				
				tk.setStatus(UserStatus.ACTIVE);
				taikhoanDAO.saveUser(tk);*/
				taikhoanDAO.editUser(tk);
			}
		}
		
		
	private int _saveLyLich(Lylich lylich)
	{
		int thisid=0; 
		// generate id
		if(lyLichDAO.listLyLich()!=null)
		{
			thisid = lyLichDAO.listLyLich().size();
		} 
		while( lyLichDAO.getLyLichById(thisid)!=null  )
		{
			thisid++;
		}
		lylich.setMacanbo(thisid);
		Canbo cb = new Canbo();
		cb.setMaCanBo(thisid);
		cb.setTrangThai(true);
		lylich.setCanboByMaCanBo(cb);
		
		// part and  save date
		//_saveDate(  lylich);
		
		// save can bo 
		canBoDAO.save(cb);
		
		
		
		// save lylich
		lyLichDAO.save(lylich);
		
		// save lsbt
		_saveLichSuBanThan(  lylich);
		
		 // save lsct
		if(lylich.getLsct()!=null)
			if(lylich.getLsct().size()>0)
					_saveLichSuCongTac(lylich);
		
		// save dao tao chuyen mon
		if(lylich.getLdtcm()!=null)
			if(lylich.getLdtcm().size()>0)
					_saveDaoTaoChuyenMon(lylich);
		
		// save dien bien luong(xu ly them )
		if(lylich.getLdbl()!=null)
			if(lylich.getLdbl().size()>0)
					_saveDienbienluong(lylich);
		
		// save quan he gia dinh ban than 
		if(lylich.getLqhbt()!=null)
			if(lylich.getLqhbt().size()>0)
					_saveCanBoGiaDinhBanThan(lylich);
		
		// save quan he gia dinh doi tac
		if(lylich.getLqhdt()!=null)
			if(lylich.getLqhdt().size()>0)
					_saveCanBoGiaDinhDoiTac(lylich);
		
		//save tk
			
				saveTaikhoan(thisid,lylich.getLoaicanbo());
		return 0;
	}
	
				// save//
	
	
				// update//
		//------------
		 
		private int _updateCanBoGiaDinhDoiTac(Lylich lylich)
		{
			ArrayList<CanboGiadinhDoitac> arr = lylich.getLqhdt();
			ArrayList<CanboGiadinhDoitac> arrcurent = (ArrayList<CanboGiadinhDoitac>) canBoGiaDinhDoiTacDAO.listcanboGiadinhDoitac(); 
			ArrayList<Integer> arrid= new ArrayList<Integer>();
			if(arr!=null)
			{
				for(int i=0; i< arr.size(); i++)
				{ 
					if(canBoGiaDinhDoiTacDAO.getCanboGiadinhDoitacId(arr.get(i).getId())!=null)
					{
						CanboGiadinhDoitac temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo()); 
						canBoGiaDinhDoiTacDAO.update(temp);
						arrcurent.remove(canBoGiaDinhDoiTacDAO.getCanboGiadinhDoitacId(arr.get(i).getId()));
					}
					else
					{
						int id = genereteIDCanBoGiaDinhDoiTac(arrid);
						arrid.add(id);
						arr.get(i).setCanbo(lylich.getCanboByMaCanBo()); 
						arr.get(i).setId(id);
						CanboGiadinhDoitac temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo()); 
						canBoGiaDinhDoiTacDAO.save(temp);
					}
				}
				
			}
			for(int i=0; i< arrcurent.size();i++)
			{
				if(arrcurent.get(i).getCanbo().getMaCanBo() == lylich.getMacanbo())
					canBoGiaDinhDoiTacDAO.delete(arrcurent.get(i).getId());
			}
			return 0;
		}
		//------------
		
		//------------
		 
		private int _updateCanBoGiaDinhBanThan(Lylich lylich)
		{
			ArrayList<CanboGiadinhBanthan> arr = lylich.getLqhbt();
			ArrayList<CanboGiadinhBanthan> arrcurent = (ArrayList<CanboGiadinhBanthan>) canBoGiaDinhBanThanDAO.listCanboGiadinhBanthan();
			ArrayList<Integer> arrid= new ArrayList<Integer>();
			if(arr!=null)
			{
				for(int i=0; i< arr.size(); i++)
				{ 
					if(canBoGiaDinhBanThanDAO.getCanboGiadinhBanthanById(arr.get(i).getId())!= null)
					{
						CanboGiadinhBanthan temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo()); 
						canBoGiaDinhBanThanDAO.update(temp);
						arrcurent.remove(canBoGiaDinhBanThanDAO.getCanboGiadinhBanthanById(arr.get(i).getId()));
					}
					else
					{
						int id = genereteIDCanBoGiaDinhBanThan(arrid);
						arrid.add(id);
						arr.get(i).setCanbo(lylich.getCanboByMaCanBo()); 
						arr.get(i).setId(id);
						CanboGiadinhBanthan temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo()); 
						canBoGiaDinhBanThanDAO.save(temp);
					}
					
				}
				
			}
			for(int i=0; i< arrcurent.size();i++)
			{
				if(arrcurent.get(i).getCanbo().getMaCanBo() == lylich.getMacanbo())
					canBoGiaDinhBanThanDAO.delete(arrcurent.get(i).getId());
			}	
			return 0;
		}
		//------------
		
		//------------
		 
		private int _updateDienbienluong(Lylich lylich)
		{
			ArrayList<Dienbienluong> arr = lylich.getLdbl();
			ArrayList<Integer> arrid= new ArrayList<Integer>();
			ArrayList<Dienbienluong> arrcurent = (ArrayList<Dienbienluong>) dienBienLuongDAO.listDienBienLuong();
			if(arr!=null)
			{
				
				for(int i=0; i< arr.size(); i++)
				{ 
					if(dienBienLuongDAO.getDienbienluongById(arr.get(i).getId())!=null)
					{
						Dienbienluong temp = arr.get(i);
						temp.setLylich(lylich);
						dienBienLuongDAO.update(temp);
						arrcurent.remove(dienBienLuongDAO.getDienbienluongById(arr.get(i).getId()));
					}
					else
					{
						int id = genereteIDDienbienluong(arrid);
						arrid.add(id);
						arr.get(i).setLylich(lylich); 
						arr.get(i).setId(id); 
						Dienbienluong temp = arr.get(i);
						temp.setLylich(lylich);
						dienBienLuongDAO.save(temp);
					}
					
				}
				
			}
			for(int i=0; i< arrcurent.size();i++)
			{
				if(arrcurent.get(i).getLylich().getMacanbo() == lylich.getMacanbo())
					dienBienLuongDAO.delete(arrcurent.get(i).getId());
			}
			return 0;
		}
		//------------
		
		//------------ 
		private int _updateDaoTaoChuyenMon(Lylich lylich)
		{
			ArrayList<Daotaochuyenmon> arr = lylich.getLdtcm();
			ArrayList<Integer> arrid=  new ArrayList<Integer>();
			ArrayList<Daotaochuyenmon> arrcurent = (ArrayList<Daotaochuyenmon>) daoTaoChuyenMonDAO.listDaoTaoChuyenMon();
			if(arr!=null)
			{
				for(int i=0; i< arr.size(); i++)
				{ 
					if(daoTaoChuyenMonDAO.getDaoTaoChuyenMonById(arr.get(i).getMaDaoTao())!=null)
					{
						Daotaochuyenmon temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo());
						daoTaoChuyenMonDAO.update(temp);
						arrcurent.remove(daoTaoChuyenMonDAO.getDaoTaoChuyenMonById(arr.get(i).getMaDaoTao()));
					}
					else
					{ 
						int id = genereteIDDaoTaoChuyenMon(arrid);
						arrid.add(id);
						arr.get(i).setCanbo(lylich.getCanboByMaCanBo());
						arr.get(i).setMaDaoTao(id);
						Daotaochuyenmon temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo());
						daoTaoChuyenMonDAO.save(temp);
					}
				}
				
			}
			for(int i=0; i< arrcurent.size();i++)
			{
				if(arrcurent.get(i).getCanbo().getMaCanBo() == lylich.getMacanbo())
					daoTaoChuyenMonDAO.delete(arrcurent.get(i).getMaDaoTao());
			}
			return 0;
		}
		//------------
		
		//------------- 
		private int _updateLichSuCongTac(Lylich lylich)
		{
			ArrayList<Lichsucongtac> arr = lylich.getLsct();
			ArrayList<Lichsucongtac> arrcurent = (ArrayList<Lichsucongtac>) lichSuCongTacDAO.listLichSuCongTac();
			ArrayList<Integer> arrid= new ArrayList<Integer>();
			if(arr!=null)
			{
				
				for(int i=0; i< arr.size(); i++)
				{ 
					if(lichSuCongTacDAO.getLichSuCongTacById(arr.get(i).getMaLsct())!= null)
					{
						Lichsucongtac temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo());
						lichSuCongTacDAO.update(temp);
						arrcurent.remove(lichSuCongTacDAO.getLichSuCongTacById(arr.get(i).getMaLsct()));
					}
					else
					{ 
						int id = genereteIDLichSuCongTac(arrid);
						arr.get(i).setCanbo(lylich.getCanboByMaCanBo());
						arr.get(i).setMaLsct(id);
						arrid.add(id);
						Lichsucongtac temp = arr.get(i);
						temp.setCanbo(lylich.getCanboByMaCanBo());
						lichSuCongTacDAO.save(temp);
						
					}
				}
				
			}
			for(int i=0; i< arrcurent.size();i++)
			{
				if(arrcurent.get(i).getCanbo().getMaCanBo() == lylich.getMacanbo())
					lichSuCongTacDAO.delete(arrcurent.get(i).getMaLsct());
			}
			return 0;
		}
		//--------------
		
		//-------------  
		private int _updateLichSuBanThan(Lylich lylich)
		{
			 
			
			if(dacDiemLichSuBanThanDAO.getDacDiemLichSuBanThanById(lylich.getMacanbo())!= null)
			{
				Dacdienlichsubanthan dd = lylich.getDacdienlichsubanthan();
				dd.setCanbo(lylich.getCanboByMaCanBo());
				dd.setMaDdls(dacDiemLichSuBanThanDAO.getDacDiemLichSuBanThanById(lylich.getMacanbo()).getMaDdls()); 
				dacDiemLichSuBanThanDAO.update(dd);
			}
			else
			{
				 
			}
			
				 
			return 0;
		}
		//--------------
		
 
		 
		
		private String _updateLyLich(Lylich lylich)
		{
			String res = "";
			if(lyLichDAO.getLyLichById(lylich.getMacanbo())== null)
			{
				res= "Mã cán bộ không tồn tại ! Thao tác không thành công...";
			}
			else
			{
				
				Canbo cb = canBoDAO.getCanBoById(lylich.getMacanbo());
				if(cb == null)
				{
					res= "Mã cán bộ không tồn tại ! Thao tác không thành công...";
				}
				{
					lylich.setCanboByMaCanBo(cb);
					lyLichDAO.update(lylich); 
					
					//update tk
					editTaikhoan(lylich.getMacanbo(), lylich.getLoaicanbo());
					// update lsbt
					_updateLichSuBanThan(  lylich);
					
					 // update lsct
					 _updateLichSuCongTac(lylich);
					
					// update dao tao chuyen mon
					_updateDaoTaoChuyenMon(lylich);
					
					// update dien bien luong(xu ly them ) 
					_updateDienbienluong(lylich);
					
					// update quan he gia dinh ban than  
					_updateCanBoGiaDinhBanThan(lylich);
					
					// update quan he gia dinh doi tac 
					_updateCanBoGiaDinhDoiTac(lylich);
				}
				
			}  
			return res;
		}
		
		
		private String _updateprofile(Lylich lylich)
		{
			String res = "";
			if(lyLichDAO.getLyLichById(lylich.getMacanbo())== null)
			{
				res= "Mã cán bộ không tồn tại ! Thao tác không thành công...";
			}
			else
			{
				
				Canbo cb = canBoDAO.getCanBoById(lylich.getMacanbo());
				if(cb == null)
				{
					res= "Mã cán bộ không tồn tại ! Thao tác không thành công...";
				}
				{
					lylich.setCanboByMaCanBo(cb);
					lyLichDAO.update(lylich); 
					
					//update tk
					editTaikhoan(lylich.getMacanbo(), lylich.getLoaicanbo());
					// update lsbt
					_updateLichSuBanThan(  lylich);
					
					 // update lsct
					 _updateLichSuCongTac(lylich);
					
					// update dao tao chuyen mon
					_updateDaoTaoChuyenMon(lylich);
					
					// update dien bien luong(xu ly them ) 
					_updateDienbienluong(lylich);
					
					// update quan he gia dinh ban than  
					_updateCanBoGiaDinhBanThan(lylich);
					
					// update quan he gia dinh doi tac 
					_updateCanBoGiaDinhDoiTac(lylich);
					
					//
					editTaikhoanprofile(lylich.getMacanbo(), lylich.getMatkhauLTN());
				}
				
			}  
			return res;
		}
					// update//
	
	
	// 
	@Transactional
	@Override 
	public boolean save(Lylich lylich) {
		boolean result = false;
		
		 
		
		Transaction tx = null;
		try{
			tx = getSession().beginTransaction();
			
			
			 
			_saveLyLich( lylich);
			
			result = true;
		}catch(Exception ex){
			if(tx != null){
				tx.rollback();
			}
			logger.error("Error", ex);
		}
		return result;
	}
	
	//
	@Override
	@Transactional
	public Lylich getLyLichById(int id) {
		
		Lylich  lylich = new Lylich(); 
		lylich =lyLichDAO.getLyLichById(id);
		ArrayList<Daotaochuyenmon> listDaoTaoChuyenMons =  new ArrayList<Daotaochuyenmon>( lylich.getCanboByMaCanBo().getDaotaochuyenmons());
		ArrayList<Lichsucongtac> listLichsucongtacs =  new ArrayList<Lichsucongtac>( lylich.getCanboByMaCanBo().getLichsucongtacs());
		ArrayList<CanboGiadinhBanthan> listcanboGiadinhBanthans =  new ArrayList<CanboGiadinhBanthan>( lylich.getCanboByMaCanBo().getCanboGiadinhBanthans());
		ArrayList<CanboGiadinhDoitac> listcanboGiadinhDoitacs =  new ArrayList<CanboGiadinhDoitac>( lylich.getCanboByMaCanBo().getCanboGiadinhDoitacs());
		ArrayList<Dienbienluong> listdienbienluongs =  new ArrayList<Dienbienluong>( lylich.getDienbienluongs());
		Dacdienlichsubanthan dacdienlichsubanthans  = new Dacdienlichsubanthan();
		if(new ArrayList<Dacdienlichsubanthan>(lylich.getCanboByMaCanBo().getDacdienlichsubanthans())!=null){
		  dacdienlichsubanthans =    (new ArrayList<Dacdienlichsubanthan>(lylich.getCanboByMaCanBo().getDacdienlichsubanthans())).get(0);}
		lylich.setLdtcm(listDaoTaoChuyenMons); 
		lylich.setLsct(listLichsucongtacs); 
		lylich.setLqhbt(listcanboGiadinhBanthans); 
		lylich.setLqhdt(listcanboGiadinhDoitacs); 
		lylich.setLdbl(listdienbienluongs); 
		lylich.setDacdienlichsubanthan(dacdienlichsubanthans); 
		lylich.setLoaicanbo(userandroleDAOImpl.getUserByIdCanBo(id).getRole().getId());
		lylich.setMatkhauLTN(taikhoanDAO.getTKById(id).getPassword());
		return lylich;
	}

	//
	@Override
	@Transactional
	public boolean  update(Lylich lylich) {
		boolean result = false;
		
		 
		
		Transaction tx = null;
		try{
			tx = getSession().beginTransaction();
			
			
			 
			_updateLyLich( lylich);
			
			result = true;
		}catch(Exception ex){
			if(tx != null){
				tx.rollback();
			}
			logger.error("Error", ex);
		}
		return result;
	}

	
	@Override
	@Transactional
	public boolean  updatefrfile(Lylich lylich) {
		boolean result = false;
		
		 
		
		Transaction tx = null;
		try{
			tx = getSession().beginTransaction();
			
			
			 
			_updateprofile( lylich);
			
			result = true;
		}catch(Exception ex){
			if(tx != null){
				tx.rollback();
			}
			logger.error("Error", ex);
		}
		return result;
	}
	
	
	//
	@Override
	@Transactional
	public void delete(int id) {
		
	}

	//
	@Override
	@Transactional
	public List<Lylich> listLyLich() {
		
		return lyLichDAO.listLyLich();
	}

}
