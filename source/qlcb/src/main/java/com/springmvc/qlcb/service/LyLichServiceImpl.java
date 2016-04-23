package com.springmvc.qlcb.service;

import java.util.List;

import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springmvc.qlcb.dao.BanDAO;
import com.springmvc.qlcb.dao.CanboBanDAO;
import com.springmvc.qlcb.dao.ChucvuBanDAO;
import com.springmvc.qlcb.dao.ChucvuDonviDAO;
import com.springmvc.qlcb.dao.DacDiemLichSuBanThanDAO;
import com.springmvc.qlcb.dao.DanTocDAO;
import com.springmvc.qlcb.dao.DaoTaoChuyenMonDAO;
import com.springmvc.qlcb.dao.DonViDAO;
import com.springmvc.qlcb.dao.HibernateUtils;
import com.springmvc.qlcb.dao.LyLichDAO;
import com.springmvc.qlcb.dao.NgoaiNguDAO;
import com.springmvc.qlcb.dao.TonGiaoDAO;
import com.springmvc.qlcb.dao.TrinhDoChinhTriDAO;
import com.springmvc.qlcb.dao.TrinhDoChuyenMonDAO;
import com.springmvc.qlcb.model.Lylich;

@Service
public class LyLichServiceImpl extends HibernateUtils implements LyLichService {

	private static final Logger logger = LoggerFactory.getLogger(LyLichServiceImpl.class);
	
	@Autowired
//	@Qualifier("LyLichDAOImpl")
	private LyLichDAO lyLichDAO;
	
	@Autowired
	private TrinhDoChinhTriDAO trinhDoChinhTriDAO;

	@Autowired
	private TrinhDoChuyenMonDAO trinhDoChuyenMonDAO;
	
	@Autowired
	private TonGiaoDAO tonGiaoDAO;
	
	@Autowired
	private DanTocDAO danTocDAO;
	
	@Autowired
	private DaoTaoChuyenMonDAO daoTaoChuyenMonDAO;
	
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
	
	@Override
	@Transactional
	public boolean save(Lylich lylich) {
		boolean result = false;
		
		Transaction tx = null;
		try{
			tx = getSession().beginTransaction();
			lyLichDAO.save(lylich);
//			trinhDoChinhTriDAO.save();
			
			tx.commit();
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
	public Lylich getLyLichById(int id) {
		return lyLichDAO.getLyLichById(id);
	}

	@Override
	@Transactional
	public void update(Lylich lylich) {
		
	}

	@Override
	@Transactional
	public void delete(int id) {
		
	}

	@Override
	@Transactional
	public List<Lylich> listLyLich() {
		return null;
	}

}
