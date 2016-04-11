-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2015 at 09:05 AM
-- Server version: 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `qlcbd`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getCadreWorkInfo`()
    NO SQL
select can_bo.Ma_Can_Bo, Ho_Ten_CB, DATE_FORMAT(Ngay_Sinh,'%d/%m/%Y') AS Ngay_Sinh, So_CMND,
                       Chuc_Vu.Ten_Chuc_Vu
                from Can_Bo left join Ly_Lich on( Can_Bo.Ma_Can_Bo = Ly_Lich.Ma_CB)
                            left join Chuc_Vu on (Can_Bo.Ma_CV_Chinh = Chuc_Vu.Ma_Chuc_Vu)
                WHERE Ngay_Roi_Khoi IS NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_layDSCanBoTrucThuoc`(IN `maCB` INT)
    NO SQL
SELECT Ma_CB AS Ma_Can_Bo, Ho_Ten_CB
                FROM thong_tin_tham_gia_ban t1 LEFT JOIN can_bo ON (t1.Ma_CB = can_bo.Ma_Can_Bo)
                WHERE t1.Ngay_Roi_Khoi IS NULL
                      AND Ma_Ban  = (SELECT t2.Ma_Ban
                                     FROM thong_tin_tham_gia_ban t2
                                     WHERE t2.Ma_CB = maCB
                                         AND t2.Ngay_Roi_Khoi IS NULL
                                         AND t2.Ma_CV IN (SELECT Ma_Chuc_Vu FROM chuc_vu WHERE Ma_Cap IN (1,2,6,7))
                                    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_layDSCanBoVoiThongTinVanTat`()
    NO SQL
SELECT can_bo.Ma_Can_Bo, Ho_Ten_CB, DATE_FORMAT(Ngay_Sinh,'%d/%m/%Y') AS Ngay_Sinh, SO_CMND
                from Can_Bo left join Ly_Lich on( can_bo.Ma_Can_Bo = Ly_Lich.Ma_CB)
                WHERE (Ngay_Roi_Khoi IS NULL)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_layThongTinBCH`(IN `maDonVi` VARCHAR(32))
    NO SQL
SELECT Ma_Ban AS Ma_BCH, Ten_Ban, loai_hinh_ban.Ten_Loai_Hinh_Ban AS Loai_Hinh
                FROM ban LEFT JOIN loai_hinh_ban ON (ban.Ma_Loai_Ban =loai_hinh_ban.Ma_Loai_Ban)
                WHERE   (Ma_Ban IN (SELECT Ma_Ban_Chap_Hanh FROM don_vi WHERE Ma_Don_Vi = maDonVi) )
                    AND (Trang_Thai=1)
                LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_layThongTinCanBo`(IN `maCanBo` INT)
    NO SQL
    COMMENT 'lấy thông tin của một cán bộ từ mã cán bộ'
SELECT Ho_Ten_CB, DATE_FORMAT(Ngay_Sinh,'%d/%m/%Y') AS Ngay_Sinh, So_CMND,
                       DATE_FORMAT(Ngay_Tuyen_Dung,'%d/%m/%Y') AS Ngay_Tuyen_Dung, DATE_FORMAT(Ngay_Bien_Che,'%d/%m/%Y') AS Ngay_Bien_Che
                FROM Can_Bo LEFT JOIN Ly_Lich on( can_bo.Ma_Can_Bo = Ly_Lich.Ma_CB)
                WHERE Ma_CB = maCanBo
                LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_layThongTinLyLich`(IN `macb` INT)
    NO SQL
SELECT can_bo.Ma_Can_Bo, don_vi.Ten_Don_Vi, can_bo.Ho_Ten_CB,can_bo.Ma_Quan_Ly, ly_lich.So_Hieu_CB, can_bo.Ngay_Tuyen_Dung, can_bo.Ngay_Bien_Che, can_bo.Ngay_Roi_Khoi, can_bo.Trang_Thai, can_bo.Tham_Gia_CLBTT,
                       Ten_Goi_Khac, Gioi_Tinh,Cap_Uy_Hien_Tai, Cap_Uy_Kiem, cvchinh.Ten_Chuc_Vu as Chuc_Vu_Chinh, Chuc_Danh as Chuc_Danh, Phu_Cap_Chuc_Vu,
                       Ngay_Sinh, Noi_Sinh, Que_Quan,Noi_O_Hien_Nay, Dien_Thoai,
                       ton_giao.Ten_Ton_Giao as Ton_Giao, dan_toc.Ten_Dan_Toc as Dan_Toc,Thanh_Phan_Gia_Dinh_Xuat_Than,
                       Nghe_Nghiep_Truoc_Do, Co_Quan_Tuyen_Dung, Dia_Chi_Co_Quan_Tuyen_Dung, Ngay_Duoc_Tuyen_Dung,
                       can_bo.Ngay_Gia_Nhap, Ngay_Tham_Gia_CM,
                       Ngay_Vao_Dang, Ngay_Chinh_Thuc,
                       Ngay_Tham_Gia_Cac_To_Chuc_Chinh_Tri_Xa_Hoi,
                       Ngay_Nhap_Ngu, Ngay_Xuat_Ngu, Quan_Ham_Chuc_Vu_Cao_Nhat,
                       Trinh_Do_Hoc_Van, trinh_do_chuyen_mon.Ten_TDCM as Trinh_Do_Chuyen_Mon, Chuyen_Nganh, Hoc_Ham, trinh_do_ly_luan_chinh_tri.Ten_CTLL, Ngoai_Ngu,
                       Cong_Tac_Chinh_Dang_Lam, qua_trinh_luong.Thoi_Gian_Nang_Luong, qua_trinh_luong.Ma_So_Ngach, qua_trinh_luong.Bac_Luong, qua_trinh_luong.He_So_Luong, qua_trinh_luong.He_So_Phu_Cap, qua_trinh_luong.Muc_Luong_Khoang, qua_trinh_luong.Phu_Cap_Vuot_Khung,
                       Danh_Hieu_Duoc_Phong, So_Truong_Cong_Tac, Cong_Viec_Lam_Lau_Nhat, Khen_Thuong, Ky_Luat, Khen_Thuong,
                       Tinh_Trang_Suc_Khoe, Chieu_Cao, Can_Nang, Nhom_Mau, So_CMND , Ngay_Cap_CMND, Noi_Cap_CMND,
                       Loai_Thuong_Binh, Gia_Dinh_Liet_Sy, Dac_Diem_Lich_Su, Lam_Viec_Trong_Che_Do_Cu,
                       Tham_Gia_Cac_To_Chuc_Nuoc_Ngoai, Co_Than_Nhan_Nuoc_Ngoai,
                       Luong_Thu_Nhap_Nam, Nguon_Thu_Khac,
                       Loai_Nha_Duoc_Cap, Dien_Tich_Nha_Duoc_Cap, Loai_Nha_Tu_Xay, Dien_Tich_Nha_Tu_Xay,
                       Dien_Tich_Dat_O_Duoc_Cap, Dien_Tich_Dat_O_Tu_Mua, Dien_Tich_Dat_San_Xuat
                FROM can_bo LEFT JOIN ly_lich ON (can_bo.Ma_Can_Bo = ly_lich.Ma_CB)
                            LEFT JOIN chuc_vu as cvchinh ON (can_bo.Ma_CV_Chinh = cvchinh.Ma_Chuc_Vu)
                            LEFT JOIN dan_toc ON (ly_lich.Dan_Toc = dan_toc.Ma_Dan_Toc)
                            LEFT JOIN ton_giao ON (ly_lich.Ton_Giao = ton_giao.Ma_Ton_Giao)
                            LEFT JOIN trinh_do_chuyen_mon ON (ly_lich.Cap_Do_TDCM = trinh_do_chuyen_mon.Cap_Do_TDCM)
                            LEFT JOIN trinh_do_ly_luan_chinh_tri ON (ly_lich.Cap_Do_CTLL = trinh_do_ly_luan_chinh_tri.Cap_Do_LLCT)
                            LEFT JOIN qua_trinh_luong ON (can_bo.Ma_Can_Bo = qua_trinh_luong.Ma_CB AND qua_trinh_luong.thoi_gian_nang_luong >= (SELECT MAX(qua_trinh_luong.Thoi_Gian_Nang_Luong)
                                                                                                                                                FROM qua_trinh_luong qtl2
                                                                                                                                                WHERE qtl2.Ma_CB = qua_trinh_luong.Ma_CB
                                                                                                                                               )
                                                           )
                            LEFT JOIN don_vi ON (can_bo.Ma_DVCT_Chinh = don_vi.Ma_DV)
                WHERE (can_bo.Ma_Can_Bo = macb)

                LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_themDanhGia`(IN `maCB_TDG` INT, IN `ngayDanhGia` DATE, IN `noidung_TDG` TEXT CHARSET utf8, IN `maMDHT_TDG` TINYINT, IN `maDonViMuonDen` TINYINT, IN `maBanMuonDen` INT, IN `tgMuonChuyen` DATE, IN `nguyenvongDaoTao` TEXT CHARSET utf8, IN `maCB_DG` INT, IN `noidung_DG` TEXT CHARSET utf8, IN `maMDHT_DG` TINYINT, IN `maCHPT` TINYINT, IN `dinhhuong` TEXT)
    NO SQL
INSERT INTO `danh_gia_can_bo`(`Ma_CB_Tu_Danh_Gia`, `Ngay_Danh_Gia`, `Noi_Dung_Tu_Danh_Gia`, `Ma_MDHT_Tu_Danh_Gia`, `Ma_DV_Muon_Den`, `Ma_Ban_Muon_Den`, `Thoi_Gian_Muon_Chuyen`, `Nguyen_Vong_Dao_Tao`, `Ma_CB_Danh_Gia`, `Noi_Dung_Danh_Gia`, `Ma_MDHT`, `Ma_CHPT`, `Dinh_Huong`) 
VALUES (maCB_TDG,ngayDanhGia,noidung_TDG, maMDHT_TDG,maDonViMuonDen,maBanMuonDen, tgMuonChuyen,nguyenvongDaoTao, maCB_DG,noidung_DG,maMDHT_DG,maCHPT,dinhhuong)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_themLoaiHinhBan`(IN `tenLoaiHinh` VARCHAR(62) CHARSET utf8, IN `maKieu` TINYINT, IN `mota` VARCHAR(254) CHARSET utf8)
    NO SQL
    DETERMINISTIC
    COMMENT 'thêm Loại Hình Ban mới'
BEGIN
    INSERT INTO `loai_hinh_ban`( `Ten_Loai_Hinh_Ban`, `Ma_Kieu_Loai_Hinh` , `Mo_Ta`) VALUES (tenLoaiHinh, maKieu , mota);
    SELECT LAST_INSERT_ID() AS New_ID;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `f_isCBThuongVuTD`(`maCB` INT) RETURNS tinyint(1)
    NO SQL
RETURN (EXISTS(SELECT Ma_CB
 FROM thong_tin_tham_gia_ban
 WHERE Ma_Ban IN (SELECT Ma_Ban_Chap_Hanh FROM don_vi WHERE Ma_DV = 0)
 	AND Ngay_Roi_Khoi IS NULL
    AND Ma_CB = maCB))$$

CREATE DEFINER=`root`@`localhost` FUNCTION `f_isTruongPhoBan`(`maCB` INT) RETURNS tinyint(1)
    NO SQL
Return EXISTS(SELECT Ma_CB FROM thong_tin_tham_gia_ban WHERE (Ngay_Roi_Khoi IS NULL) AND (Ma_CV IN (SELECT Ma_Chuc_Vu FROM chuc_vu WHERE Ma_Cap IN (1,2,6,7))                                                                                         AND (Ma_CB = maCB))
                                                                                         )$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ban`
--

CREATE TABLE IF NOT EXISTS `ban` (
`Ma_Ban` int(11) NOT NULL,
  `Ma_Loai_Ban` tinyint(4) DEFAULT NULL,
  `Ma_Don_Vi` smallint(6) unsigned DEFAULT NULL,
  `Ten_Ban` varchar(254) DEFAULT NULL,
  `Ngay_Thanh_Lap` date DEFAULT NULL,
  `Ngay_Man_Nhiem` date DEFAULT NULL,
  `Mo_Ta` varchar(254) DEFAULT NULL,
  `Trang_Thai` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `ban`
--

INSERT INTO `ban` (`Ma_Ban`, `Ma_Loai_Ban`, `Ma_Don_Vi`, `Ten_Ban`, `Ngay_Thanh_Lap`, `Ngay_Man_Nhiem`, `Mo_Ta`, `Trang_Thai`) VALUES
(1, 10, 0, 'Văn Phòng', '2014-04-01', NULL, '', 1),
(2, 11, 0, 'Văn Phòng Dảng Ủy', '2014-04-01', NULL, '<p>yes</p>\r\n', 1),
(3, 12, 0, 'Ban Quốc Tế', '2014-04-01', NULL, '', 1),
(4, 13, 0, 'Ban Tuyên Giáo', '2014-04-01', NULL, '', 1),
(5, 14, 0, 'Ban Thiếu Nhi', '2014-04-01', NULL, '', 1),
(6, 15, 0, 'Ban Tổ Chức', '2014-04-01', NULL, '', 1),
(7, 16, 0, 'Ban Kiểm Tra', '2014-04-01', NULL, '', 1),
(8, 18, 0, 'Ban Thanh Niên Trường Học', '2014-04-01', NULL, '', 1),
(9, 17, 0, 'Ban Công Nhân Lao Dộng', '2014-04-01', NULL, '', 1),
(10, 19, 0, 'Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư', '2014-04-01', NULL, '', 1),
(11, 1, 1, 'Ban Chấp Hành Trường DH Công nghệ Thông tin nhiệm kỳ 2014 - 2016', '1970-01-01', '1970-01-01', '<p>M&ocirc; tả cho&nbsp;Ban Chấp H&agrave;nh Trường DH C&ocirc;ng nghệ Th&ocirc;ng tin nhiệm kỳ 2014 - 2016</p>\r\n', 0),
(12, 1, 1, 'Ban Chấp Hành Trường DH Công nghệ Thông tin nhiệm kỳ 2015', '1970-01-01', '1970-01-01', '', 0),
(13, 14, 1, 'Ban Thiếu Nhi Trường DH Công nghệ Thông tin', '2015-05-13', NULL, '', 1),
(14, 1, 0, 'Ban Giám Hiệu Chuyên Trách Thành Doàn nhiệm kỳ 2015', '1970-01-01', '1970-01-01', '', 0),
(15, 1, 0, 'Ban Chấp Hành Chuyên Trách Thành Doàn nhiệm kỳ 2015', '1970-01-01', '1970-01-01', '<p>abx</p>\r\n', 0),
(16, 1, 0, 'Ban Chấp Hành Chuyên Trách Thành Doàn nhiệm kỳ 2015', '1970-01-01', '1970-01-01', '', 0),
(17, 1, 0, 'Ban Chấp Hành Chuyên Trách Thành Doàn nhiệm kỳ 2015', '1970-01-01', '1970-01-01', '', 0),
(18, 1, 0, 'Ban Chấp Hành Chuyên Trách Thành Doàn nhiệm kỳ 2015', '1970-01-01', NULL, '', 1),
(19, 14, 0, 'Ban Thiếu Nhi Chuyên Trách Thành Doàn', '2015-05-22', NULL, '', 1),
(20, 2, 1, 'Hội Dồng Thành Viên Trường DH Công nghệ Thông tin nhiệm kỳ 2015', '1970-01-01', NULL, '', 1),
(21, 3, 1, 'Phòng Kế Toán Trường DH Công nghệ Thông tin', '2015-05-22', NULL, '', 1),
(22, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(23, 19, 0, 'ABX Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(24, 19, 0, 'Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(25, 19, 0, 'Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư Chuyên Trách Thành Doàn Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(26, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(27, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(28, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(29, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(30, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(31, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-04', NULL, '', 1),
(32, 8, 0, 'Phòng Kinh Doanh Chuyên Trách Thành Doàn', '2015-06-29', NULL, '', 1),
(33, 5, 0, 'Ban Biên Tập Chuyên Trách Thành Doàn', '2015-06-30', NULL, '', 1),
(34, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-29', NULL, '', 1),
(35, 3, 1, 'aaaaa Phòng Kế Toán Trường DH Công nghệ Thông tin', '2015-06-23', NULL, '', 1),
(36, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-16', NULL, '', 1),
(37, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-16', NULL, '', 1),
(38, 3, 0, 'Phòng Kế Toán Chuyên Trách Thành Doàn', '2015-06-16', NULL, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `can_bo`
--

CREATE TABLE IF NOT EXISTS `can_bo` (
`Ma_Can_Bo` int(11) NOT NULL,
  `Ma_Quan_Ly` varchar(254) DEFAULT NULL COMMENT 'MaDoiTuong, MaKhuVuc, STT',
  `Ma_CV_Chinh` smallint(5) unsigned DEFAULT NULL COMMENT 'tham chiếu chức vụ chính của cán bộ',
  `Ho_Ten_CB` varchar(254) DEFAULT '(chưa biết)',
  `Ngay_Gia_Nhap` date DEFAULT NULL,
  `Ngay_Tuyen_Dung` date DEFAULT NULL,
  `Ngay_Bien_Che` date DEFAULT NULL,
  `Ma_DVCT_Chinh` smallint(5) unsigned DEFAULT NULL,
  `Ngay_Roi_Khoi` date DEFAULT NULL,
  `Trang_Thai` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - Dang công tác, 0 - Dã rời khỏi, (-1) - dã mất',
  `DangHoatDong` tinyint(1) NOT NULL DEFAULT '1',
  `Tham_Gia_CLBTT` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=103 ;

--
-- Dumping data for table `can_bo`
--

INSERT INTO `can_bo` (`Ma_Can_Bo`, `Ma_Quan_Ly`, `Ma_CV_Chinh`, `Ho_Ten_CB`, `Ngay_Gia_Nhap`, `Ngay_Tuyen_Dung`, `Ngay_Bien_Che`, `Ma_DVCT_Chinh`, `Ngay_Roi_Khoi`, `Trang_Thai`, `DangHoatDong`, `Tham_Gia_CLBTT`) VALUES
(1, NULL, NULL, 'Vưu Chí Hào', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(2, NULL, NULL, 'Nguyễn Tuấn Anh', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(3, NULL, NULL, 'Trần Dình Thi', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(4, NULL, NULL, 'Doàn Thi Xuân Thu', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(5, NULL, NULL, 'Trương Dăng Khoa', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(6, NULL, NULL, 'Nguyễn Trác Thức', '2009-11-23', '2009-11-23', '2009-11-23', NULL, '1970-01-01', 1, 1, 0),
(7, NULL, NULL, 'Lê Dức Thịnh', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(8, NULL, NULL, 'Trần Dình Thi', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(9, NULL, NULL, 'Trần Dình Thi 123', '2009-11-23', '2009-11-23', '2009-11-23', NULL, NULL, 1, 1, 0),
(10, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(11, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(12, NULL, NULL, 'MANTA ZOORO', NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(13, NULL, NULL, 'RANTO', NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(14, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(15, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(16, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(17, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(18, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(19, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 0, 0),
(20, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(21, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(22, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(23, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(24, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(25, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(26, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(27, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(28, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(29, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(30, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(31, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(32, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(33, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(34, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(35, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(36, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(37, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(38, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(39, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(40, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(41, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(42, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(43, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(44, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(45, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(46, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(47, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(48, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(49, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(50, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(51, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(52, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(53, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(54, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(55, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(56, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(57, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(58, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(59, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(60, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(61, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(62, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(63, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(64, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(65, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(66, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(67, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(68, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(69, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(70, NULL, NULL, 'DDD', NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
(71, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(72, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(73, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(74, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(75, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(76, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(77, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(78, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(79, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(80, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(81, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(82, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(83, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(84, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(85, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(86, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(87, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(88, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(89, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(90, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(91, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(92, NULL, NULL, 'NGUYỄN THANH DOÀN', NULL, NULL, NULL, NULL, NULL, 1, 0, 0),
(93, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 0, 0),
(94, NULL, NULL, 'AAAA', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '2015-06-03', 0, 1, 0),
(95, NULL, NULL, 'CHÂU MINH HÒA', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 1, 0),
(96, NULL, NULL, 'VƯƠNG THANH LIỄU', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 1, 0),
(97, NULL, NULL, 'NGUYỄN THANH DOÀN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 0, 0),
(98, NULL, NULL, 'canbo', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 1, 0),
(99, NULL, NULL, 'canbodemo', '1970-01-01', '1970-01-01', '1970-01-01', NULL, '1970-01-01', 0, 1, 0),
(100, NULL, NULL, 'democanbo', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 1, 0),
(101, NULL, NULL, 'NGUYỄN THỊ HỒNG YẾN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 1, 0),
(102, NULL, NULL, 'NGUYỄN THỊ HỒNG YẾN', '1970-01-01', '1970-01-01', '1970-01-01', NULL, NULL, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cap_chuc_vu`
--

CREATE TABLE IF NOT EXISTS `cap_chuc_vu` (
`Ma_Cap` tinyint(4) NOT NULL,
  `Ten_Cap_CV` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `cap_chuc_vu`
--

INSERT INTO `cap_chuc_vu` (`Ma_Cap`, `Ten_Cap_CV`) VALUES
(0, 'Khác'),
(1, 'Trưởng Dơn Vị'),
(2, 'Phó Dơn Vị'),
(3, 'Thường Trực'),
(4, 'Thường Vụ/ Thành Viên Hội Dồng'),
(5, 'Ủy Viên'),
(6, 'Trưởng Phòng/Ban'),
(7, 'Phó Phòng/Ban'),
(8, 'Cán Bộ/Nhân Viên');

-- --------------------------------------------------------

--
-- Table structure for table `chieu_huong_phat_trien`
--

CREATE TABLE IF NOT EXISTS `chieu_huong_phat_trien` (
`Ma_CHPT` tinyint(4) NOT NULL,
  `Ten_CHPT` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `chieu_huong_phat_trien`
--

INSERT INTO `chieu_huong_phat_trien` (`Ma_CHPT`, `Ten_CHPT`) VALUES
(1, 'Tốt hơn'),
(2, 'Giứ mức'),
(3, 'Giảm');

-- --------------------------------------------------------

--
-- Table structure for table `chuc_vu`
--

CREATE TABLE IF NOT EXISTS `chuc_vu` (
`Ma_Chuc_Vu` smallint(5) unsigned NOT NULL,
  `Ma_Cap` tinyint(4) DEFAULT NULL,
  `Ten_Chuc_Vu` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `chuc_vu`
--

INSERT INTO `chuc_vu` (`Ma_Chuc_Vu`, `Ma_Cap`, `Ten_Chuc_Vu`) VALUES
(0, NULL, '(Chức Vụ Khác)'),
(1, 1, 'Bí Thư'),
(2, 1, 'Giám Dốc'),
(3, 2, 'Phó Bí Thư'),
(4, 2, 'Phó Giám Dốc'),
(5, 3, 'Thường Trực'),
(6, 4, 'Thường Vụ'),
(7, 4, 'Thành Viên Hội Dồng'),
(8, 5, 'Ủy Viên BCH'),
(9, 6, 'Trưởng Ban'),
(10, 6, 'Kế Toán Trưởng'),
(11, 6, 'Trưởng Phòng'),
(12, 7, 'Phó Ban'),
(13, 7, 'Kế Toán Phó'),
(14, 7, 'Phó Phòng'),
(15, 8, 'Cán Bộ'),
(16, 8, 'Nhân Viên');

-- --------------------------------------------------------

--
-- Table structure for table `cong_tac_nuoc_ngoai`
--

CREATE TABLE IF NOT EXISTS `cong_tac_nuoc_ngoai` (
  `Ma_CB` int(10) unsigned NOT NULL,
`Ma_CTNN` bigint(20) unsigned NOT NULL,
  `Tu_Ngay` date NOT NULL DEFAULT '0000-00-00',
  `Den_Ngay` date NOT NULL DEFAULT '0000-00-00',
  `Dia_Diem` varchar(254) DEFAULT NULL,
  `Noi_Dung` varchar(254) DEFAULT NULL,
  `Cap_Cu_Di` varchar(254) DEFAULT NULL,
  `Kinh_Phi` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cong_tac_nuoc_ngoai`
--

INSERT INTO `cong_tac_nuoc_ngoai` (`Ma_CB`, `Ma_CTNN`, `Tu_Ngay`, `Den_Ngay`, `Dia_Diem`, `Noi_Dung`, `Cap_Cu_Di`, `Kinh_Phi`) VALUES
(94, 1, '2015-06-04', '2015-06-04', 'Nhật', 'Di công tác ', 'Thành doàn', '50%');

-- --------------------------------------------------------

--
-- Table structure for table `cong_tac_vien`
--

CREATE TABLE IF NOT EXISTS `cong_tac_vien` (
`Ma_CTV` int(10) unsigned NOT NULL,
  `Ho_Ten_CTV` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `controller`
--

CREATE TABLE IF NOT EXISTS `controller` (
  `Controller_Name` varchar(32) NOT NULL,
  `Module_Name` varchar(32) DEFAULT NULL,
  `Controller_Display_Name` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dan_toc`
--

CREATE TABLE IF NOT EXISTS `dan_toc` (
`Ma_Dan_Toc` smallint(6) NOT NULL,
  `Ten_Dan_Toc` varchar(63) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `dan_toc`
--

INSERT INTO `dan_toc` (`Ma_Dan_Toc`, `Ten_Dan_Toc`) VALUES
(0, '(Khác)'),
(1, 'Kinh'),
(2, 'Chăm'),
(3, 'Hoa'),
(4, 'Thái'),
(5, 'Tày'),
(6, 'Nùng');

-- --------------------------------------------------------

--
-- Table structure for table `dien_khen_thuong`
--

CREATE TABLE IF NOT EXISTS `dien_khen_thuong` (
`Ma_Dien` smallint(6) NOT NULL,
  `Ten_Dien` varchar(254) DEFAULT NULL,
  `Muc_Thuong_Khung` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hop_dong_cong_tac`
--

CREATE TABLE IF NOT EXISTS `hop_dong_cong_tac` (
  `Ma_Ban` int(11) NOT NULL,
  `Ma_CTV` int(10) unsigned NOT NULL,
  `Ngay_Bat_Dau` datetime NOT NULL,
  `Ngay_Ket_Thuc` date DEFAULT NULL,
  `Nhiem_Vu` varchar(254) DEFAULT NULL,
  `Tien_Luong_Khoan` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `khen_thuong`
--

CREATE TABLE IF NOT EXISTS `khen_thuong` (
  `Ma_CB` int(11) NOT NULL,
`Ma_Khen_Thuong` bigint(20) unsigned NOT NULL,
  `Ngay_Quyet_Dinh` date DEFAULT NULL,
  `Hinh_Thuc` varchar(62) DEFAULT NULL,
  `Cap_Ra_Quyet_Dinh` varchar(62) DEFAULT NULL,
  `Ly_Do` varchar(254) DEFAULT NULL,
  `Ma_DS_Khen_Thuong` int(10) unsigned DEFAULT NULL,
  `Ma_Dien` smallint(6) DEFAULT NULL,
  `He_So_Thuong` float DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=617 ;

--
-- Dumping data for table `khen_thuong`
--

INSERT INTO `khen_thuong` (`Ma_CB`, `Ma_Khen_Thuong`, `Ngay_Quyet_Dinh`, `Hinh_Thuc`, `Cap_Ra_Quyet_Dinh`, `Ly_Do`, `Ma_DS_Khen_Thuong`, `Ma_Dien`, `He_So_Thuong`) VALUES
(1, 1, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(2, 2, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(3, 3, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(4, 4, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(5, 5, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(6, 6, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(7, 7, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(8, 8, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(9, 9, '2013-02-25', 'Giấy khen', 'Thành Doàn', 'Hoàn thành nhiệm vụ', NULL, NULL, 1),
(10, 10, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(10, 11, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(10, 12, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(10, 13, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(10, 14, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(10, 15, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(10, 16, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(10, 17, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(10, 18, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(11, 19, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(11, 20, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(11, 21, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(11, 22, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(11, 23, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(11, 24, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(11, 25, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(11, 26, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(11, 27, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(12, 28, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(12, 29, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(12, 30, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(12, 31, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(12, 32, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(12, 33, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(12, 34, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(12, 35, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(12, 36, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(13, 37, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(13, 38, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(13, 39, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(13, 40, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(13, 41, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(13, 42, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(13, 43, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(13, 44, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(13, 45, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(14, 46, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(14, 47, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(14, 48, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(14, 49, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(14, 50, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(14, 51, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(14, 52, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(14, 53, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(14, 54, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(15, 55, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(15, 56, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(15, 57, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(15, 58, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(15, 59, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(15, 60, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(15, 61, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(15, 62, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(15, 63, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(16, 64, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(16, 65, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(16, 66, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(16, 67, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(16, 68, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(16, 69, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(16, 70, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(16, 71, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(16, 72, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(18, 73, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(18, 74, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(18, 75, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(18, 76, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(18, 77, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(18, 78, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(18, 79, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(18, 80, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(18, 81, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(19, 82, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(19, 83, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(19, 84, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(19, 85, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(19, 86, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(19, 87, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(19, 88, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(19, 89, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(19, 90, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(20, 91, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(20, 92, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(20, 93, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(20, 94, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(20, 95, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(20, 96, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(20, 97, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(20, 98, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(20, 99, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(21, 100, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(21, 101, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(21, 102, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(21, 103, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(21, 104, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(21, 105, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(21, 106, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(21, 107, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(21, 108, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(22, 109, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(22, 110, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(22, 111, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(22, 112, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(22, 113, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(22, 114, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(22, 115, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(22, 116, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(22, 117, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(23, 118, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(23, 119, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(23, 120, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(23, 121, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(23, 122, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(23, 123, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(23, 124, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(23, 125, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(23, 126, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(24, 127, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(24, 128, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(24, 129, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(24, 130, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(24, 131, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(24, 132, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(24, 133, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(24, 134, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(24, 135, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(25, 136, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(25, 137, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(25, 138, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(25, 139, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(25, 140, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(25, 141, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(25, 142, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(25, 143, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(25, 144, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(26, 145, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(26, 146, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(26, 147, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(26, 148, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(26, 149, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(26, 150, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(26, 151, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(26, 152, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(26, 153, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(27, 154, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(27, 155, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(27, 156, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(27, 157, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(27, 158, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(27, 159, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(27, 160, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(27, 161, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(27, 162, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(28, 163, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(28, 164, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(28, 165, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(28, 166, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(28, 167, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(28, 168, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(28, 169, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(28, 170, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(28, 171, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(29, 172, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(29, 173, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(29, 174, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(29, 175, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(29, 176, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(29, 177, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(29, 178, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(29, 179, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(29, 180, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(30, 181, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(30, 182, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(30, 183, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(30, 184, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(30, 185, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(30, 186, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(30, 187, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(30, 188, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(30, 189, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(31, 190, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(31, 191, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(31, 192, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(31, 193, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(31, 194, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(31, 195, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(31, 196, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(31, 197, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(31, 198, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(32, 199, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(32, 200, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(32, 201, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(32, 202, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(32, 203, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(32, 204, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(32, 205, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(32, 206, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(32, 207, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(33, 208, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(33, 209, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(33, 210, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(33, 211, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(33, 212, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(33, 213, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(33, 214, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(33, 215, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(33, 216, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(34, 217, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(34, 218, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(34, 219, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(34, 220, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(34, 221, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(34, 222, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(34, 223, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(34, 224, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(34, 225, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(35, 226, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(35, 227, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(35, 228, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(35, 229, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(35, 230, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(35, 231, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(35, 232, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(35, 233, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(35, 234, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(36, 235, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(36, 236, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(36, 237, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(36, 238, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(36, 239, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(36, 240, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(36, 241, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(36, 242, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(36, 243, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(37, 244, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(37, 245, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(37, 246, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(37, 247, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(37, 248, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(37, 249, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(37, 250, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(37, 251, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(37, 252, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(38, 253, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(38, 254, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(38, 255, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(38, 256, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(38, 257, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(38, 258, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(38, 259, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(38, 260, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(38, 261, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(39, 262, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(39, 263, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(39, 264, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(39, 265, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(39, 266, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(39, 267, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(39, 268, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(39, 269, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(39, 270, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(40, 271, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(40, 272, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(40, 273, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(40, 274, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(40, 275, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(40, 276, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(40, 277, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(40, 278, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(40, 279, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(41, 280, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(41, 281, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(41, 282, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(41, 283, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(41, 284, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(41, 285, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(41, 286, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(41, 287, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(41, 288, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(42, 289, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(42, 290, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(42, 291, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(42, 292, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(42, 293, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(42, 294, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(42, 295, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(42, 296, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(42, 297, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(43, 298, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(43, 299, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(43, 300, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(43, 301, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(43, 302, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(43, 303, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(43, 304, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(43, 305, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(43, 306, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(44, 307, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(44, 308, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(44, 309, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(44, 310, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(44, 311, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(44, 312, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(44, 313, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(44, 314, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(44, 315, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(46, 316, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(46, 317, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(46, 318, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(46, 319, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(46, 320, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(46, 321, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(46, 322, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(46, 323, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(46, 324, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(47, 325, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(47, 326, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(47, 327, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(47, 328, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(47, 329, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(47, 330, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(47, 331, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(47, 332, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(47, 333, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(48, 334, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(48, 335, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(48, 336, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(48, 337, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(48, 338, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(48, 339, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(48, 340, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(48, 341, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(48, 342, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(49, 343, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(49, 344, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(49, 345, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(49, 346, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(49, 347, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(49, 348, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(49, 349, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(49, 350, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(49, 351, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(50, 352, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(50, 353, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(50, 354, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(50, 355, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(50, 356, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(50, 357, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(50, 358, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(50, 359, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(50, 360, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(51, 361, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(51, 362, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(51, 363, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(51, 364, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(51, 365, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(51, 366, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(51, 367, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(51, 368, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(51, 369, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(52, 370, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(52, 371, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(52, 372, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(52, 373, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(52, 374, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(52, 375, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(52, 376, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(52, 377, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(52, 378, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(53, 379, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(53, 380, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(53, 381, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(53, 382, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(53, 383, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(53, 384, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(53, 385, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(53, 386, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(53, 387, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(54, 388, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(54, 389, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(54, 390, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(54, 391, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(54, 392, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(54, 393, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(54, 394, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(54, 395, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(54, 396, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(55, 397, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(55, 398, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(55, 399, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(55, 400, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(55, 401, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(55, 402, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(55, 403, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(55, 404, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(55, 405, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(56, 406, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(56, 407, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(56, 408, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(56, 409, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(56, 410, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(56, 411, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(56, 412, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(56, 413, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(56, 414, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(57, 415, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(57, 416, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(57, 417, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(57, 418, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(57, 419, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(57, 420, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(57, 421, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(57, 422, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(57, 423, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(59, 424, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(59, 425, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(59, 426, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(59, 427, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(59, 428, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(59, 429, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(59, 430, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(59, 431, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(59, 432, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(60, 433, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(60, 434, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(60, 435, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(60, 436, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(60, 437, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(60, 438, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(60, 439, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(60, 440, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(60, 441, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(61, 442, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(61, 443, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(61, 444, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(61, 445, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(61, 446, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(61, 447, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(61, 448, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(61, 449, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(61, 450, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(62, 451, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(62, 452, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(62, 453, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(62, 454, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(62, 455, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(62, 456, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(62, 457, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(62, 458, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(62, 459, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(63, 460, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(63, 461, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(63, 462, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(63, 463, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(63, 464, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(63, 465, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(63, 466, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(63, 467, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(63, 468, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(64, 469, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(64, 470, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(64, 471, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(64, 472, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(64, 473, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(64, 474, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(64, 475, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(64, 476, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(64, 477, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(65, 478, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(65, 479, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(65, 480, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(65, 481, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(65, 482, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(65, 483, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(65, 484, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(65, 485, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(65, 486, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(66, 487, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(66, 488, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(66, 489, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(66, 490, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(66, 491, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(66, 492, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(66, 493, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(66, 494, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(66, 495, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(67, 496, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(67, 497, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(67, 498, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(67, 499, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(67, 500, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(67, 501, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(67, 502, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(67, 503, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(67, 504, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(68, 505, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(68, 506, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(68, 507, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(68, 508, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(68, 509, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(68, 510, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(68, 511, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(68, 512, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(68, 513, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(71, 514, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(71, 515, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(71, 516, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(71, 517, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(71, 518, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(71, 519, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(71, 520, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(71, 521, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(71, 522, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(72, 523, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(72, 524, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(72, 525, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(72, 526, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(72, 527, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(72, 528, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(72, 529, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(72, 530, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(72, 531, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(76, 532, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(76, 533, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(76, 534, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(76, 535, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(76, 536, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(76, 537, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(76, 538, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(76, 539, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(76, 540, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(77, 541, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(77, 542, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(77, 543, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(77, 544, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(77, 545, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(77, 546, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(77, 547, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(77, 548, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(77, 549, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(78, 550, NULL, 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(78, 551, NULL, 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(78, 552, NULL, 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(78, 553, NULL, 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(78, 554, NULL, 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(78, 555, NULL, 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(78, 556, NULL, 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(78, 557, NULL, 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(78, 558, NULL, 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(94, 559, '1970-01-01', 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(94, 560, '1970-01-01', 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(94, 561, '1970-01-01', 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(94, 562, '1970-01-01', 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(94, 563, '1970-01-01', 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(94, 564, '1970-01-01', 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(94, 565, '1970-01-01', 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(94, 566, '1970-01-01', 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(94, 567, '1970-01-01', 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(95, 568, '2015-05-23', 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', '', NULL, NULL, 1),
(95, 569, '2015-05-24', 'Bằng khen', 'Trung ương Doàn', '', NULL, NULL, 1),
(95, 570, '1970-01-01', 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(95, 571, '2015-05-23', 'Dảng viên hoàn thành xuất sắc nhiệm vụ, Dảng viên trẻ tiêu biể', '', '', NULL, NULL, 1),
(96, 572, '1970-01-01', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(97, 573, '1970-01-01', 'Kỷ niệm chương Vì thế hệ trẻ', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(97, 574, '1970-01-01', 'Bằng khen', 'Trung ương Doàn', ' ', NULL, NULL, 1),
(97, 575, '1970-01-01', 'Bằng khen', 'Trung ương Hội sinh viên Việt Nam', '', NULL, NULL, 1),
(97, 576, '1970-01-01', 'Bằng khen', 'UBND TP', ' ', NULL, NULL, 1),
(97, 577, '1970-01-01', 'Bằng khen', 'UBND tỉnh Gia Lai', ' ', NULL, NULL, 1),
(97, 578, '1970-01-01', 'Bằng khen', 'UBND tỉnh Bến Tre', ' ', NULL, NULL, 1),
(97, 579, '1970-01-01', 'Bằng khen', 'Trung ương Hội Chữ thập dỏ VN', ' ', NULL, NULL, 1),
(97, 580, '1970-01-01', 'Giấy khen', 'Thành Doàn', ' ', NULL, NULL, 1),
(97, 581, '1970-01-01', 'Giấy khen', 'Hội Sinh viên Tp. HCM', ' ', NULL, NULL, 1),
(98, 582, '2015-06-04', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(98, 583, '1970-01-01', 'Bằng khen', 'Trung ương Doàn', '', NULL, NULL, 1),
(98, 584, '2015-06-04', 'Bằng khen', 'UBND TP', '', NULL, NULL, 1),
(98, 585, '2015-06-04', 'Giấy khen', 'Thành Doàn', '', NULL, NULL, 1),
(98, 586, '2015-06-04', 'Danh hiệu ', 'Doàn Khối Dân - Chính - Dảng', '', NULL, NULL, 1),
(99, 587, '2015-06-04', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(99, 588, '1970-01-01', 'Bằng khen', 'Trung ương Doàn', '', NULL, NULL, 1),
(99, 589, '2015-06-04', 'Bằng khen', 'UBND TP', '', NULL, NULL, 1),
(99, 590, '2015-06-04', 'Giấy khen', 'Thành Doàn', '', NULL, NULL, 1),
(99, 591, '2015-06-04', 'Danh hiệu ', 'Doàn Khối Dân - Chính - Dảng', '', NULL, NULL, 1),
(100, 592, '2015-06-04', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(100, 593, '1970-01-01', 'Bằng khen', 'Trung ương Doàn', '', NULL, NULL, 1),
(100, 594, '2015-06-04', 'Bằng khen', 'UBND TP', '', NULL, NULL, 1),
(100, 595, '2015-06-04', 'Giấy khen', 'Thành Doàn', '', NULL, NULL, 1),
(100, 596, '2015-06-04', 'Danh hiệu ', 'Doàn Khối Dân - Chính - Dảng', '', NULL, NULL, 1),
(101, 597, '1996-06-25', 'Thanh niên tiên tiến Quận 6', 'Quận Doàn 6', '', NULL, NULL, 1),
(101, 598, '1998-06-25', 'Bí thư Chi doàn giỏi Quận 6', 'Quận Doàn 6', '', NULL, NULL, 1),
(101, 599, '1970-01-01', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(101, 600, '2005-06-25', 'Bằng khen', 'UBND TP', '', NULL, NULL, 1),
(101, 601, '2015-06-25', 'Bằng khen vì hoạt dộng tình nguyện Mùa hè xanh', 'Trung ương Doàn', '', NULL, NULL, 1),
(101, 602, '1970-01-01', 'Phụ nữ Giỏi việc nước - Dảm việc nhà', '', '', NULL, NULL, 1),
(101, 603, '1970-01-01', 'Chiến sĩ thi dua cơ sở', '', '', NULL, NULL, 1),
(101, 604, '2015-06-25', 'Bằng khen', 'Liên doàn Lao dộng TP', '', NULL, NULL, 1),
(101, 605, '2015-06-25', 'Giấy khen Dảng ủy viên dủ tư cách hoàn thành xuất sắc nhiệm vụ', 'Dảng ủy cơ quan Thành Doàn', '', NULL, NULL, 1),
(101, 606, '2015-06-25', 'Giấy khen học tập và làm theo tấm gương dạo dức Hồ Chí Minh', 'Dảng ủy Khối Dân - Chính - Dảng', '', NULL, NULL, 1),
(102, 607, '1996-06-25', 'Thanh niên tiên tiến Quận 6', 'Quận Doàn 6', '', NULL, NULL, 1),
(102, 608, '1998-06-25', 'Bí thư Chi doàn giỏi Quận 6', 'Quận Doàn 6', '', NULL, NULL, 1),
(102, 609, '1970-01-01', 'Kỷ niệm chương ', 'Trung ương Doàn', '', NULL, NULL, 1),
(102, 610, '2005-06-25', 'Bằng khen', 'UBND TP', '', NULL, NULL, 1),
(102, 611, '2015-06-25', 'Bằng khen vì hoạt dộng tình nguyện Mùa hè xanh', 'Trung ương Doàn', '', NULL, NULL, 1),
(102, 612, '1970-01-01', 'Phụ nữ Giỏi việc nước - Dảm việc nhà', '', '', NULL, NULL, 1),
(102, 613, '1970-01-01', 'Chiến sĩ thi dua cơ sở', '', '', NULL, NULL, 1),
(102, 614, '2015-06-25', 'Bằng khen', 'Liên doàn Lao dộng TP', '', NULL, NULL, 1);
INSERT INTO `khen_thuong` (`Ma_CB`, `Ma_Khen_Thuong`, `Ngay_Quyet_Dinh`, `Hinh_Thuc`, `Cap_Ra_Quyet_Dinh`, `Ly_Do`, `Ma_DS_Khen_Thuong`, `Ma_Dien`, `He_So_Thuong`) VALUES
(102, 615, '2015-06-25', 'Giấy khen Dảng ủy viên dủ tư cách hoàn thành xuất sắc nhiệm vụ', 'Dảng ủy cơ quan Thành Doàn', '', NULL, NULL, 1),
(102, 616, '2015-06-25', 'Giấy khen học tập và làm theo tấm gương dạo dức Hồ Chí Minh', 'Dảng ủy Khối Dân - Chính - Dảng', '', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `khoi`
--

CREATE TABLE IF NOT EXISTS `khoi` (
`Ma_Khoi` tinyint(3) unsigned NOT NULL,
  `Ten_Khoi` varchar(254) DEFAULT NULL,
  `Mo_Ta` varchar(254) DEFAULT NULL,
  `Ma_Khoi_Cap_Tren` tinyint(3) unsigned DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `khoi`
--

INSERT INTO `khoi` (`Ma_Khoi`, `Ten_Khoi`, `Mo_Ta`, `Ma_Khoi_Cap_Tren`) VALUES
(1, 'Thành Doàn', NULL, NULL),
(2, 'Khối cơ quan chuyên trách Thành Doàn', NULL, 1),
(3, 'Khối các dơn vị sự nghiệp - doanh nghiệp', NULL, 1),
(4, 'Cơ Sở Doàn', NULL, 1),
(5, 'Cơ Quan Chính Dảng', NULL, NULL),
(6, 'Khác', 'Các khối khác', 1);

-- --------------------------------------------------------

--
-- Table structure for table `kien_nghi`
--

CREATE TABLE IF NOT EXISTS `kien_nghi` (
  `Thoi_Gian` datetime NOT NULL,
  `Ma_CB_Kien_Nghi` int(11) NOT NULL,
  `Ten_Kien_Nghi` varchar(254) DEFAULT NULL,
  `Noi_Dung` text,
  `File_URL` varchar(254) DEFAULT NULL,
  `Trang_Thai` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kien_nghi`
--

INSERT INTO `kien_nghi` (`Thoi_Gian`, `Ma_CB_Kien_Nghi`, `Ten_Kien_Nghi`, `Noi_Dung`, `File_URL`, `Trang_Thai`) VALUES
('2014-05-25 10:41:11', 6, 'Sửa CMND', 'ádfgh', '6_1401007271.zip', 0),
('2015-06-04 17:06:19', 6, 'Cập nhật anh chị em', 'Em út: Văn Hà 1 Tuổi', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kieu_loai_hinh_ban`
--

CREATE TABLE IF NOT EXISTS `kieu_loai_hinh_ban` (
  `Ma_KLHB` tinyint(4) NOT NULL,
  `Ten_KLHB` varchar(62) DEFAULT NULL,
  `Mo_Ta` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kieu_loai_hinh_ban`
--

INSERT INTO `kieu_loai_hinh_ban` (`Ma_KLHB`, `Ten_KLHB`, `Mo_Ta`) VALUES
(0, 'Phòng/Ban chức năng', NULL),
(1, 'Ban Lãnh Dạo', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kq_xet_thi_dua`
--

CREATE TABLE IF NOT EXISTS `kq_xet_thi_dua` (
`Ma_DS_Khen_Thuong` int(10) unsigned NOT NULL,
  `Nam_Danh_Gia` smallint(6) NOT NULL,
  `Quy_Danh_Gia` smallint(6) NOT NULL,
  `Thoi_Diem_Xet` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ky_luat`
--

CREATE TABLE IF NOT EXISTS `ky_luat` (
  `Ma_CB` int(11) NOT NULL,
`Ma_Ky_Luat` bigint(20) unsigned NOT NULL,
  `Ngay_Quyet_Dinh` date DEFAULT NULL,
  `Hinh_Thuc` varchar(62) DEFAULT NULL,
  `Cap_Ra_Quyet_Dinh` varchar(62) DEFAULT NULL,
  `Ly_Do_Ky_Luat` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=130 ;

--
-- Dumping data for table `ky_luat`
--

INSERT INTO `ky_luat` (`Ma_CB`, `Ma_Ky_Luat`, `Ngay_Quyet_Dinh`, `Hinh_Thuc`, `Cap_Ra_Quyet_Dinh`, `Ly_Do_Ky_Luat`) VALUES
(3, 1, '2009-02-24', 'Khiển trách', 'Thành Doàn', 'Không hoàn thành nhiệm vụ'),
(8, 2, '2009-02-24', 'Khiển trách', 'Thành Doàn', 'Không hoàn thành nhiệm vụ'),
(9, 3, '2009-02-24', 'Khiển trách', 'Thành Doàn', 'Không hoàn thành nhiệm vụ'),
(10, 4, NULL, '', '', ' '),
(10, 5, NULL, '', ' ', ' '),
(11, 6, NULL, '', '', ' '),
(11, 7, NULL, '', ' ', ' '),
(12, 8, NULL, '', '', ' '),
(12, 9, NULL, '', ' ', ' '),
(13, 10, NULL, '', '', ' '),
(13, 11, NULL, '', ' ', ' '),
(14, 12, NULL, '', '', ' '),
(14, 13, NULL, '', ' ', ' '),
(15, 14, NULL, '', '', ' '),
(15, 15, NULL, '', ' ', ' '),
(16, 16, NULL, '', '', ' '),
(16, 17, NULL, '', ' ', ' '),
(18, 18, NULL, '', '', ' '),
(18, 19, NULL, '', ' ', ' '),
(19, 20, NULL, '', '', ' '),
(19, 21, NULL, '', ' ', ' '),
(20, 22, NULL, '', '', ' '),
(20, 23, NULL, '', ' ', ' '),
(21, 24, NULL, '', '', ' '),
(21, 25, NULL, '', ' ', ' '),
(22, 26, NULL, '', '', ' '),
(22, 27, NULL, '', ' ', ' '),
(23, 28, NULL, '', '', ' '),
(23, 29, NULL, '', ' ', ' '),
(24, 30, NULL, '', '', ' '),
(24, 31, NULL, '', ' ', ' '),
(25, 32, NULL, '', '', ' '),
(25, 33, NULL, '', ' ', ' '),
(26, 34, NULL, '', '', ' '),
(26, 35, NULL, '', ' ', ' '),
(27, 36, NULL, '', '', ' '),
(27, 37, NULL, '', ' ', ' '),
(28, 38, NULL, '', '', ' '),
(28, 39, NULL, '', ' ', ' '),
(29, 40, NULL, '', '', ' '),
(29, 41, NULL, '', ' ', ' '),
(30, 42, NULL, '', '', ' '),
(30, 43, NULL, '', ' ', ' '),
(31, 44, NULL, '', '', ' '),
(31, 45, NULL, '', ' ', ' '),
(32, 46, NULL, '', '', ' '),
(32, 47, NULL, '', ' ', ' '),
(33, 48, NULL, '', '', ' '),
(33, 49, NULL, '', ' ', ' '),
(34, 50, NULL, '', '', ' '),
(34, 51, NULL, '', ' ', ' '),
(35, 52, NULL, '', '', ' '),
(35, 53, NULL, '', ' ', ' '),
(36, 54, NULL, '', '', ' '),
(36, 55, NULL, '', ' ', ' '),
(37, 56, NULL, '', '', ' '),
(37, 57, NULL, '', ' ', ' '),
(38, 58, NULL, '', '', ' '),
(38, 59, NULL, '', ' ', ' '),
(39, 60, NULL, '', '', ' '),
(39, 61, NULL, '', ' ', ' '),
(40, 62, NULL, '', '', ' '),
(40, 63, NULL, '', ' ', ' '),
(41, 64, NULL, '', '', ' '),
(41, 65, NULL, '', ' ', ' '),
(42, 66, NULL, '', '', ' '),
(42, 67, NULL, '', ' ', ' '),
(43, 68, NULL, '', '', ' '),
(43, 69, NULL, '', ' ', ' '),
(44, 70, NULL, '', '', ' '),
(44, 71, NULL, '', ' ', ' '),
(46, 72, NULL, '', '', ' '),
(46, 73, NULL, '', ' ', ' '),
(47, 74, NULL, '', '', ' '),
(47, 75, NULL, '', ' ', ' '),
(48, 76, NULL, '', '', ' '),
(48, 77, NULL, '', ' ', ' '),
(49, 78, NULL, '', '', ' '),
(49, 79, NULL, '', ' ', ' '),
(50, 80, NULL, '', '', ' '),
(50, 81, NULL, '', ' ', ' '),
(51, 82, NULL, '', '', ' '),
(51, 83, NULL, '', ' ', ' '),
(52, 84, NULL, '', '', ' '),
(52, 85, NULL, '', ' ', ' '),
(53, 86, NULL, '', '', ' '),
(53, 87, NULL, '', ' ', ' '),
(54, 88, NULL, '', '', ' '),
(54, 89, NULL, '', ' ', ' '),
(55, 90, NULL, '', '', ' '),
(55, 91, NULL, '', ' ', ' '),
(56, 92, NULL, '', '', ' '),
(56, 93, NULL, '', ' ', ' '),
(57, 94, NULL, '', '', ' '),
(57, 95, NULL, '', ' ', ' '),
(59, 96, NULL, '', '', ' '),
(59, 97, NULL, '', ' ', ' '),
(60, 98, NULL, '', '', ' '),
(60, 99, NULL, '', ' ', ' '),
(61, 100, NULL, '', '', ' '),
(61, 101, NULL, '', ' ', ' '),
(62, 102, NULL, '', '', ' '),
(62, 103, NULL, '', ' ', ' '),
(63, 104, NULL, '', '', ' '),
(63, 105, NULL, '', ' ', ' '),
(64, 106, NULL, '', '', ' '),
(64, 107, NULL, '', ' ', ' '),
(65, 108, NULL, '', '', ' '),
(65, 109, NULL, '', ' ', ' '),
(66, 110, NULL, '', '', ' '),
(66, 111, NULL, '', ' ', ' '),
(67, 112, NULL, '', '', ' '),
(67, 113, NULL, '', ' ', ' '),
(68, 114, NULL, '', '', ' '),
(68, 115, NULL, '', ' ', ' '),
(71, 116, NULL, '', '', ' '),
(71, 117, NULL, '', ' ', ' '),
(72, 118, NULL, '', '', ' '),
(72, 119, NULL, '', ' ', ' '),
(76, 120, NULL, '', '', ' '),
(76, 121, NULL, '', ' ', ' '),
(77, 122, NULL, '', '', ' '),
(77, 123, NULL, '', ' ', ' '),
(78, 124, NULL, '', '', ' '),
(78, 125, NULL, '', ' ', ' '),
(94, 126, '1970-01-01', '', '', ' '),
(94, 127, '1970-01-01', '', ' ', ' '),
(97, 128, '1970-01-01', '', '', ' '),
(97, 129, '1970-01-01', '', ' ', ' ');

-- --------------------------------------------------------

--
-- Table structure for table `loai_hinh_ban`
--

CREATE TABLE IF NOT EXISTS `loai_hinh_ban` (
`Ma_Loai_Ban` tinyint(4) NOT NULL,
  `Ten_Loai_Hinh_Ban` varchar(62) DEFAULT NULL,
  `Mo_Ta` varchar(254) DEFAULT NULL,
  `Ma_Kieu_Loai_Hinh` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `loai_hinh_ban`
--

INSERT INTO `loai_hinh_ban` (`Ma_Loai_Ban`, `Ten_Loai_Hinh_Ban`, `Mo_Ta`, `Ma_Kieu_Loai_Hinh`) VALUES
(1, 'Ban Chấp Hành', '<p>Ban chấp h&igrave;nh c&aacute;c cơ quan. Ch&uacute; &yacute;: Ban Thường Vụ l&agrave; c&aacute;c C&aacute;n bộ giữ chức Thường Vụ tại Ban Chấp H&agrave;nh cơ quan d&oacute; 4s</p>\r\n', 1),
(2, 'Hội Dồng Thành Viên', 'Hội dồng thành viên, giành cho các cơ quan doanh nghiệp', 1),
(3, 'Phòng Kế Toán', NULL, 0),
(4, 'Phòng Hành Chính', NULL, 0),
(5, 'Ban Biên Tập', NULL, 0),
(6, 'Ban Giám Hiệu', 'dối với các cơ quan Trường học', 1),
(7, 'Ban Giám Dốc', NULL, 1),
(8, 'Phòng Kinh Doanh', NULL, 0),
(9, 'Ban Phát Thanh Truyền Hình', '', 0),
(10, 'Phòng Bảo Vệ', '', 0),
(11, 'Văn Phòng Dảng Ủy', '', 0),
(12, 'Ban Quốc Tế', '', 0),
(13, 'Ban Tuyên Giáo', '', 0),
(14, 'Ban Thiếu Nhi', '', 0),
(15, 'Ban Tổ Chức', '', 0),
(16, 'Ban Kiểm Tra', '', 0),
(17, 'Ban Công Nhân Lao Dộng', '', 0),
(18, 'Ban Thanh Niên Trường Học', '', 0),
(19, 'Ban Mặt Trận - An Ninh Quốc Phòng - Dịa Bàn Dân Cư', '', 0),
(20, 'Ban Kiểm Tra', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ly_lich`
--

CREATE TABLE IF NOT EXISTS `ly_lich` (
  `Ma_CB` int(11) NOT NULL,
  `So_Hieu_CB` varchar(30) DEFAULT NULL COMMENT 'dùng dể quản lý hồ sơ lý lịch (MaDoiTuong, MaKhuVuc, STT)',
  `Ho_Ten_Khai_Sinh` varchar(254) DEFAULT NULL,
  `Ten_Goi_Khac` varchar(254) DEFAULT NULL,
  `Gioi_Tinh` tinyint(1) DEFAULT NULL,
  `Cap_Uy_Hien_Tai` varchar(254) DEFAULT NULL,
  `Cap_Uy_Kiem` varchar(254) DEFAULT NULL,
  `Chuc_Danh` varchar(62) DEFAULT NULL COMMENT 'chức vụ, chức danh tại cấp uy',
  `Phu_Cap_Chuc_Vu` float DEFAULT NULL,
  `Ngay_Sinh` date DEFAULT NULL,
  `Noi_Sinh` varchar(254) DEFAULT NULL,
  `So_CMND` varchar(254) DEFAULT NULL,
  `Ngay_Cap_CMND` date DEFAULT NULL,
  `Noi_Cap_CMND` varchar(254) DEFAULT NULL,
  `Que_Quan` varchar(254) DEFAULT NULL,
  `Noi_O_Hien_Nay` varchar(254) DEFAULT NULL,
  `Dan_Toc` smallint(6) DEFAULT NULL,
  `Ton_Giao` smallint(6) DEFAULT NULL,
  `Dien_Thoai` varchar(254) DEFAULT NULL,
  `Thanh_Phan_Gia_Dinh_Xuat_Than` varchar(254) DEFAULT NULL,
  `Ngay_Tham_Gia_CM` date DEFAULT NULL,
  `Nghe_Nghiep_Truoc_Do` varchar(254) DEFAULT NULL,
  `Ngay_Duoc_Tuyen_Dung` date DEFAULT NULL,
  `Co_Quan_Tuyen_Dung` varchar(254) DEFAULT NULL,
  `Dia_Chi_Co_Quan_Tuyen_Dung` varchar(254) DEFAULT NULL,
  `Ngay_Vao_Dang` date DEFAULT NULL,
  `Ngay_Chinh_Thuc` date DEFAULT NULL,
  `Ngay_Tham_Gia_Cac_To_Chuc_Chinh_Tri_Xa_Hoi` varchar(254) DEFAULT NULL,
  `Ngay_Nhap_Ngu` date DEFAULT NULL,
  `Ngay_Xuat_Ngu` date DEFAULT NULL,
  `Quan_Ham_Chuc_Vu_Cao_Nhat` varchar(254) DEFAULT NULL,
  `Trinh_Do_Hoc_Van` varchar(254) DEFAULT '12/12',
  `Hoc_Ham` varchar(254) DEFAULT NULL,
  `Cap_Do_CTLL` decimal(4,2) DEFAULT NULL,
  `Cap_Do_TDCM` decimal(4,2) DEFAULT NULL,
  `Chuyen_Nganh` varchar(62) DEFAULT NULL,
  `Ngoai_Ngu` varchar(254) DEFAULT NULL,
  `Dac_Diem_Lich_Su` text,
  `Lam_Viec_Trong_Che_Do_Cu` varchar(254) DEFAULT NULL,
  `Co_Than_Nhan_Nuoc_Ngoai` varchar(254) DEFAULT NULL,
  `Tham_Gia_Cac_To_Chuc_Nuoc_Ngoai` varchar(254) DEFAULT NULL,
  `Cong_Tac_Chinh_Dang_Lam` varchar(254) DEFAULT NULL,
  `Danh_Hieu_Duoc_Phong` varchar(254) DEFAULT NULL,
  `So_Truong_Cong_Tac` varchar(254) DEFAULT NULL,
  `Cong_Viec_Lam_Lau_Nhat` varchar(254) DEFAULT NULL,
  `Khen_Thuong` varchar(254) DEFAULT NULL,
  `Ky_Luat` varchar(254) DEFAULT NULL,
  `Tinh_Trang_Suc_Khoe` varchar(254) DEFAULT NULL,
  `Chieu_Cao` float DEFAULT NULL,
  `Can_Nang` float DEFAULT NULL,
  `Nhom_Mau` varchar(30) DEFAULT NULL,
  `Loai_Thuong_Binh` varchar(254) DEFAULT NULL,
  `Gia_Dinh_Liet_Sy` tinyint(1) DEFAULT NULL,
  `Luong_Thu_Nhap_Nam` bigint(20) unsigned DEFAULT '0',
  `Nguon_Thu_Khac` varchar(254) DEFAULT NULL,
  `Loai_Nha_Duoc_Cap` varchar(62) DEFAULT NULL,
  `Dien_Tich_Nha_Duoc_Cap` int(10) unsigned DEFAULT '0',
  `Loai_Nha_Tu_Xay` varchar(62) DEFAULT NULL,
  `Dien_Tich_Nha_Tu_Xay` int(10) unsigned DEFAULT '0',
  `Dien_Tich_Dat_O_Duoc_Cap` int(10) unsigned DEFAULT '0',
  `Dien_Tich_Dat_O_Tu_Mua` int(10) unsigned DEFAULT '0',
  `Dien_Tich_Dat_San_Xuat` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ly_lich`
--

INSERT INTO `ly_lich` (`Ma_CB`, `So_Hieu_CB`, `Ho_Ten_Khai_Sinh`, `Ten_Goi_Khac`, `Gioi_Tinh`, `Cap_Uy_Hien_Tai`, `Cap_Uy_Kiem`, `Chuc_Danh`, `Phu_Cap_Chuc_Vu`, `Ngay_Sinh`, `Noi_Sinh`, `So_CMND`, `Ngay_Cap_CMND`, `Noi_Cap_CMND`, `Que_Quan`, `Noi_O_Hien_Nay`, `Dan_Toc`, `Ton_Giao`, `Dien_Thoai`, `Thanh_Phan_Gia_Dinh_Xuat_Than`, `Ngay_Tham_Gia_CM`, `Nghe_Nghiep_Truoc_Do`, `Ngay_Duoc_Tuyen_Dung`, `Co_Quan_Tuyen_Dung`, `Dia_Chi_Co_Quan_Tuyen_Dung`, `Ngay_Vao_Dang`, `Ngay_Chinh_Thuc`, `Ngay_Tham_Gia_Cac_To_Chuc_Chinh_Tri_Xa_Hoi`, `Ngay_Nhap_Ngu`, `Ngay_Xuat_Ngu`, `Quan_Ham_Chuc_Vu_Cao_Nhat`, `Trinh_Do_Hoc_Van`, `Hoc_Ham`, `Cap_Do_CTLL`, `Cap_Do_TDCM`, `Chuyen_Nganh`, `Ngoai_Ngu`, `Dac_Diem_Lich_Su`, `Lam_Viec_Trong_Che_Do_Cu`, `Co_Than_Nhan_Nuoc_Ngoai`, `Tham_Gia_Cac_To_Chuc_Nuoc_Ngoai`, `Cong_Tac_Chinh_Dang_Lam`, `Danh_Hieu_Duoc_Phong`, `So_Truong_Cong_Tac`, `Cong_Viec_Lam_Lau_Nhat`, `Khen_Thuong`, `Ky_Luat`, `Tinh_Trang_Suc_Khoe`, `Chieu_Cao`, `Can_Nang`, `Nhom_Mau`, `Loai_Thuong_Binh`, `Gia_Dinh_Liet_Sy`, `Luong_Thu_Nhap_Nam`, `Nguon_Thu_Khac`, `Loai_Nha_Duoc_Cap`, `Dien_Tich_Nha_Duoc_Cap`, `Loai_Nha_Tu_Xay`, `Dien_Tich_Nha_Tu_Xay`, `Dien_Tich_Dat_O_Duoc_Cap`, `Dien_Tich_Dat_O_Tu_Mua`, `Dien_Tich_Dat_San_Xuat`) VALUES
(1, 'A105', 'Vưu Chí Hào', 'Không', 0, 'Không', 'Không', '', NULL, '1992-11-10', 'Trà Vinh', '123789456', '2008-03-15', 'Trà Vinh', 'Trà Vinh', 'Trà Vinh', 0, 0, '12567455609', 'Buôn bán', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '3.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Tổ chức xây dựng', '', NULL, NULL, 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(2, 'A104', 'Nguyễn Tuấn Anh', 'Không', 0, 'Không', 'Không', '', NULL, '1992-11-10', 'Bình Dịnh', '123456589', '2008-03-15', 'Bình Dịnh', 'Bình Dịnh', 'Bình Dịnh', 0, 0, '12567455609', 'Y sỹ', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '2.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Tổ chức xây dựng', '', NULL, NULL, 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(3, 'A123', 'Trần Dình Thi', 'Không', 0, 'Không', 'Không', '', NULL, '1992-02-25', 'An Giang', '352039720', '2007-03-15', 'An Giang', 'An Giang', 'An Giang', 0, 0, '12567455609', 'Công nhân viên chức', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '1.00', '12.00', 'Công nghệ Thông tin', 'Anh, Hoa, Nhật', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Phong trào', '', NULL, NULL, 'Tốt', 1.67, 50, 'AB', 'Không', 1, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(4, 'A103', 'Doàn Thi Xuân Thu', 'Không', 1, 'Không', 'Không', '', NULL, '1992-11-10', 'Bình Dịnh', '321456789', '2008-03-15', 'Bình Dịnh', 'Bình Dịnh', 'Bình Dịnh', 0, 0, '12567455609', 'Y sỹ', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '1.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Tổ chức xây dựng', '', NULL, NULL, 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(5, 'A102', 'Trương Dăng Khoa', 'Không', 0, 'Không', 'Không', '', NULL, '1992-01-25', 'An Giang', '123456789', '2007-03-15', 'An Giang', 'An Giang', 'An Giang', 0, 0, '12567455609', 'Y sỹ', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '1.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Tổ chức xây dựng', '', NULL, NULL, 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(6, 'A104', 'Nguyễn Trác Thức', 'Không', 0, 'Không', 'Không', '', 0, '1982-11-10', 'TPHCM', '121456789', '2008-03-15', 'TPHCM', 'TPHCM', 'TPHCM', 0, 0, '12567455609', 'Viên chức', '1970-01-01', 'Sinh viên', '1970-01-01', 'Thành Doàn TPHCM', NULL, '2001-03-02', '2002-03-02', '', '1970-01-01', '1970-01-01', 'Không', '12/12', '', '3.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', '', '', 'Tổ chức xây dựng', '', '', '', 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(7, 'A107', 'Lê Dức Thịnh', 'Không', 0, 'Không', 'Không', '', NULL, '1982-11-10', 'Long An', '151456789', '2008-03-15', 'TPHCM', 'Long An', 'Long An', 0, 0, '12567455609', 'Viên chức', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, '2001-03-02', '2002-03-02', '', NULL, NULL, 'Không', '12/12', 'Không', '3.00', '12.00', 'Công nghệ Thông tin', 'Anh', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Tổ chức xây dựng', '', NULL, NULL, 'Tốt', 1.67, 50, 'O', 'Không', 0, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(8, 'A123', 'Trần Dình Thi', 'Không', 0, 'Không', 'Không', '', NULL, '1992-02-25', 'An Giang', '352039720', '2007-03-15', 'An Giang', 'An Giang', 'An Giang', 0, 0, '12567455609', 'Công nhân viên chức', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '1.00', '12.00', 'Công nghệ Thông tin', 'Anh, Hoa, Nhật', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Phong trào', '', NULL, NULL, 'Tốt', 1.67, 50, 'AB', 'Không', 1, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(9, 'A123', 'Trần Dình Thi 123', 'Không', 0, 'Không', 'Không', '', NULL, '1992-02-25', 'An Giang', '352039720', '2007-03-15', 'An Giang', 'An Giang', 'An Giang', 0, 0, '12567455609', 'Công nhân viên chức', NULL, 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, NULL, NULL, '', NULL, NULL, 'Không', '12/12', 'Không', '1.00', '12.00', 'Công nghệ Thông tin', 'Anh, Hoa, Nhật', 'Không', 'Không', 'Không', 'Không', NULL, '', 'Phong trào', '', NULL, NULL, 'Tốt', 1.67, 50, 'AB', 'Không', 1, 0, ' 20000000', 'Không', 0, 'Có', 100, 0, 800, 0),
(93, '123t', 'NGUYỄN THANH DOÀN', 'Không', 0, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy Bộ phận khối phong trào Thành Doàn, Bí thư chi bộ Trường học', 'Không', '', NULL, '1978-10-12', 'Tiền Giang', '123123', '1970-01-01', '', 'Tiền Giang', '52/2D Vạn Hạnh, Trung Chánh, Hóc Môn, TP. HCM', 0, 0, '0983.850585', 'Nông dân', '1970-01-01', 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, '2002-03-14', '2003-03-14', '26/3/1994 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '2.00', '12.00', 'Thạc sỹ Kinh tế chính trị', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', NULL, 'Không', 'Phong trào', 'Cán bộ Doàn - Hội, công tác chính trị sinh viên ', NULL, NULL, 'Tốt', 1, 65, 'O', 'Không', 0, 0, '0', 'Không', 0, 'Chung cư', 72, 0, 0, 0),
(94, '123r', 'AAAA', 'Không', 0, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy Bộ phận khối phong trào Thành Doàn, Bí thư chi bộ Trường học', 'Không', 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy Bộ', 0, '1978-10-12', 'Tiền Giang', '123123', '2015-05-01', '', 'Tiền Giang', '52/2D Vạn Hạnh, Trung Chánh, Hóc Môn, TP. HCM', 0, 0, '0983.850585', 'Nông dân', '1970-01-01', 'Sinh viên', '1970-01-01', 'Thành Doàn TPHCM', NULL, '2002-03-14', '2003-03-14', '26/3/1994 (Doàn TNCS Hồ Chí Minh) ', '2015-05-01', '2015-05-05', 'Không', '12/12', '', '2.00', '12.00', 'Thạc sỹ Kinh tế chính trị', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', '', 'Không', 'Phong trào', 'Cán bộ Doàn - Hội, công tác chính trị sinh viên ', '', '', 'Tốt', 1, 65, 'O', 'Không', 0, 0, '0', 'Không', 0, 'Chung cư', 72, 0, 0, 0),
(95, '', 'CHÂU MINH HÒA', 'Không', 0, 'Không', 'Không', '', NULL, '1984-02-11', 'TP. Hồ Chí Minh', '1231232132', '1970-01-01', '', 'xã Hòa Khánh, huyện Cái Bè, tỉnh Tiền Giang', '180B Phan Văn Khỏe, P.2, Q.6', 0, 0, '01673.902608', 'Công nhân lao dộng', '1970-01-01', '', NULL, 'Thành Doàn TPHCM', NULL, '2007-09-15', '2008-09-15', '01/4/1999 (Doàn TNCS Hồ Chí Minh) ', '2008-03-05', '2009-11-28', 'Thiếu úy', '12/12', 'Không', '0.00', '12.00', 'Cử nhân Ngữ văn', '', 'Không', 'Không', 'Không', 'Không', NULL, '', '', '', NULL, NULL, 'Tốt', 1, 81, 'O', 'Không', 0, 0, '0', 'Không', 0, '', 0, 0, 0, 0),
(96, '', 'VƯƠNG THANH LIỄU', 'Không', 1, 'Bí thư Chi bộ Xây dựng Doàn 1', 'Không', '', NULL, '1983-03-13', 'TP. Hồ Chí Minh', '123131231', '1970-01-01', '', 'TP. Hồ Chí Minh', '41/1/1 Dội Cung, P.11, Q. 11, TP. HCM', 0, 0, '0908.423704', 'Công nhân lao dộng', '1970-01-01', 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, '2006-12-04', '2007-12-04', '09/1/1998 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '2.00', '12.00', 'CN Kinh tế, Cử nhân Triết học', 'B Anh văn', 'Không', 'Không', 'Không', 'Chị ruột Vương Thị Thanh Vân dang dịnh cư tại Dài Loan', NULL, '', '', 'Cán bộ Doàn', NULL, NULL, 'Tốt', 1, 44, 'O', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0),
(97, '', 'NGUYỄN THANH DOÀN', 'Không', 0, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy Bộ phận khối phong trào Thành Doàn, Bí thư chi bộ Trường học', 'Không', '', NULL, '1978-10-12', 'Tiền Giang', '123', '1970-01-01', '', 'Tiền Giang', '52/2D Vạn Hạnh, Trung Chánh, Hóc Môn, TP. HCM', 0, 0, '0983.850585', 'Nông dân', '1970-01-01', 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, '2002-03-14', '2003-03-14', '26/3/1994 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '2.00', '12.00', 'Thạc sỹ Kinh tế chính trị', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', NULL, 'Không', 'Phong trào', 'Cán bộ Doàn - Hội, công tác chính trị sinh viên ', NULL, NULL, 'Tốt', 1, 65, 'O', 'Không', 0, 0, '0', 'Không', 0, 'Chung cư', 72, 0, 0, 0),
(98, 'RPXRPX', 'canbo', 'Không', 1, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Bí thư Chi bộ Xây dựng Doàn 2', 'Không', '', 0, '1982-08-24', 'TP. Hồ Chí Minh', '932123321', '1970-01-01', 'HCM', 'xã Phú Hữu, Nhơn Trạch, Dồng Nai', 'Q12 Bạch Mã, Cư xã Bắc Hải, P.15, Q.10', 0, 0, '0918.917182', 'Công nhân viên chức', '1970-01-01', 'Sinh viên', '1970-01-01', 'Thành Doàn TPHCM', NULL, '2007-05-07', '2008-05-07', '26/3/1997 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', '', '3.00', '12.00', 'Thạc sỹ Ngữ văn', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', '', '', 'biên tập, viết', 'Cán bộ Doàn', '', '', 'Tốt', 1, 58, 'B', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0),
(99, 'canbodemo', 'canbodemo', 'Không', 1, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Bí thư Chi bộ Xây dựng Doàn 2', 'Không', '', 0, '1982-08-24', 'TP. Hồ Chí Minh', '932123321', '1970-01-01', 'HCM', 'xã Phú Hữu, Nhơn Trạch, Dồng Nai', 'Q12 Bạch Mã, Cư xã Bắc Hải, P.15, Q.10', 0, 0, '0918.917182', 'Công nhân viên chức', '1970-01-01', 'Sinh viên', '1970-01-01', 'Thành Doàn TPHCM', NULL, '2007-05-07', '2008-05-07', '26/3/1997 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', '', '3.00', '12.00', 'Thạc sỹ Ngữ văn', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', '', '', 'biên tập, viết', 'Cán bộ Doàn', '', '', 'Tốt', 1, 58, 'B', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0),
(100, 'democanbo', 'democanbo', 'Không', 1, 'Dảng ủy viên Dảng ủy cơ quan Thành Doàn, Bí thư Chi bộ Xây dựng Doàn 2', 'Không', '', NULL, '1982-08-24', 'TP. Hồ Chí Minh', '9999991', '1970-01-01', 'HCM', 'xã Phú Hữu, Nhơn Trạch, Dồng Nai', 'Q12 Bạch Mã, Cư xã Bắc Hải, P.15, Q.10', 0, 0, '0918.917182', 'Công nhân viên chức', '1970-01-01', 'Sinh viên', NULL, 'Thành Doàn TPHCM', NULL, '2007-05-07', '2008-05-07', '26/3/1997 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '3.00', '12.00', 'Thạc sỹ Ngữ văn', 'C Anh văn', 'Không', 'Không', 'Không', 'Không', NULL, '', 'biên tập, viết', 'Cán bộ Doàn', NULL, NULL, 'Tốt', 1, 58, 'B', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0),
(101, '', 'NGUYỄN THỊ HỒNG YẾN', 'Không', 1, 'Phó Bí thư Dảng ủy Cơ quan Thành Doàn ', 'Không', '', NULL, '1976-08-15', 'TP. Hồ Chí Minh', '333', '1970-01-01', '', 'Bình Thuận ', '68B8 Dặng Nguyên Cẩn, P.14, Q.6, TP. HCM', 0, 0, '0918.204260', 'Nông dân', '1970-01-01', 'Học sinh', NULL, 'Thành Doàn TPHCM', NULL, '1998-06-05', '1999-06-05', '26/3/1990 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '2.00', '12.00', 'CN Luật', 'Anh văn', 'Không', 'Không', 'Không', 'Không', NULL, 'Chiến sĩ thi dua cấp Thành phố (2007), Người cán bộ Công doàn của chúng tôi, Chiến sĩ thi dua cơ sở năm 2010', '', 'Cán bộ Doàn', NULL, NULL, 'Tốt', 1, 58, 'B', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0),
(102, '', 'NGUYỄN THỊ HỒNG YẾN', 'Không', 1, 'Phó Bí thư Dảng ủy Cơ quan Thành Doàn ', 'Không', '', NULL, '1976-08-15', 'TP. Hồ Chí Minh', '333', '1970-01-01', '', 'Bình Thuận ', '68B8 Dặng Nguyên Cẩn, P.14, Q.6, TP. HCM', 0, 0, '0918.204260', 'Nông dân', '1970-01-01', 'Học sinh', NULL, 'Thành Doàn TPHCM', NULL, '1998-06-05', '1999-06-05', '26/3/1990 (Doàn TNCS Hồ Chí Minh) ', '1970-01-01', '1970-01-01', 'Không', '12/12', 'Không', '2.00', '12.00', 'CN Luật', 'Anh văn', 'Không', 'Không', 'Không', 'Không', NULL, 'Chiến sĩ thi dua cấp Thành phố (2007), Người cán bộ Công doàn của chúng tôi, Chiến sĩ thi dua cơ sở năm 2010', '', 'Cán bộ Doàn', NULL, NULL, 'Tốt', 1, 58, 'B', 'Không', 0, 0, '0', 'Không', 0, '0', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE IF NOT EXISTS `module` (
  `Module_Name` varchar(32) NOT NULL,
  `Module_Display_Name` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `muc_sua_doi`
--

CREATE TABLE IF NOT EXISTS `muc_sua_doi` (
  `Ma_Yeu_Cau` bigint(20) unsigned NOT NULL,
  `Ten_Cot_Thay_Doi` varchar(254) NOT NULL,
  `Gia_Tri_Thay_Doi` varchar(254) DEFAULT NULL,
  `Ten_Hien_Thi` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `muc_thuong_theo_dien`
--

CREATE TABLE IF NOT EXISTS `muc_thuong_theo_dien` (
  `Ma_Dien` smallint(6) NOT NULL,
  `Ma_DS_Khen_Thuong` int(10) unsigned NOT NULL,
  `Muc_Thuong` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `muc_do_hoan_thanh`
--

CREATE TABLE IF NOT EXISTS `muc_do_hoan_thanh` (
`Ma_MDHT` tinyint(4) NOT NULL,
  `Ten_MDHT` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `muc_do_hoan_thanh`
--

INSERT INTO `muc_do_hoan_thanh` (`Ma_MDHT`, `Ten_MDHT`) VALUES
(1, 'Hoàn thành xuất sắc chức trách, nhiệm vụ'),
(2, 'Hoàn thành tốt chức trách, nhiệm vụ'),
(3, 'Hoàn thành chức trách, nhiệm vụ'),
(4, 'Chưa hoàn thành chức trách, nhiệm vụ');

-- --------------------------------------------------------

--
-- Table structure for table `ngach_luong`
--

CREATE TABLE IF NOT EXISTS `ngach_luong` (
  `Ma_So_Ngach` varchar(32) NOT NULL,
  `Ky_Hieu_Ngach` varchar(32) DEFAULT NULL,
  `Ten_Ngach` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ngach_luong`
--

INSERT INTO `ngach_luong` (`Ma_So_Ngach`, `Ky_Hieu_Ngach`, `Ten_Ngach`) VALUES
('00000', NULL, '(không hưởng lương)'),
('01.001', '', 'Chuyên viên cao cấp'),
('01.002', '', 'Chuyên viên chính'),
('01.003', '', 'Chuyên viên'),
('01.004', '', 'Cán sự'),
('01.005', '', 'Kỹ thuật viên dánh máy'),
('01.006', '', 'Nhân viên dánh máy'),
('01.007', '', 'Nhân viên kỹ thuật'),
('01.008', '', 'Nhân viên văn thư'),
('01.009', '', 'Nhân viên phục vụ'),
('01.010', '', 'Lái xe cơ quan'),
('01.011', '', 'Nhân viên bảo vệ'),
('01.015', '', 'Kỹ thuật viên trung cấp'),
('02.012', '', 'Lưu trữ viên cao cấp'),
('02.013', '', 'Lưu trữ viên chính'),
('02.014', '', 'Lưu trữ viên'),
('02.016', '', 'Kỹ thuật viên lưu trữ'),
('03.017', '', 'Chấp hành viên tỉnh, thành phố trực thuộc Trung ương'),
('03.018', '', 'Chấp hành viên quận, huyện, thị xã, thành phố thuộc tỉnh'),
('03.019', '', 'Công chứng viên'),
('04.023', '', 'Thanh tra viên cao cấp'),
('04.024', '', 'Thanh tra viên chính'),
('04.025', '', 'Thanh tra viên'),
('06.029', '', 'Kế toán viên cao cấp'),
('06.030', '', 'Kế toán viên chính'),
('06.031', '', 'Kế toán viên'),
('06.032', '', 'Kế toán viên trung cấp'),
('06.033', '', 'Kế toán viên sơ cấp'),
('06.034', '', 'Thủ quỹ kho bạc, ngân hàng'),
('06.035', '', 'Thủ quỹ cơ quan dơn vị'),
('06.036', '', 'Kiểm soát viên cao cấp thuế'),
('06.037', '', 'Kiểm soát viên chính thuế'),
('06.038', '', 'Kiểm soát viên thuế'),
('06.039', '', 'Kiểm thu viên thuế'),
('06.040', '', 'Nhân viên thuế');

-- --------------------------------------------------------

--
-- Table structure for table `ngoai_ngu`
--

CREATE TABLE IF NOT EXISTS `ngoai_ngu` (
`Ma_Ngoai_Ngu` smallint(5) unsigned NOT NULL,
  `Ten_Ngoai_Ngu` varchar(63) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ngoai_ngu`
--

INSERT INTO `ngoai_ngu` (`Ma_Ngoai_Ngu`, `Ten_Ngoai_Ngu`) VALUES
(0, '(không)'),
(1, 'Anh'),
(2, 'Pháp'),
(3, 'Nhật'),
(4, 'Hàn Quốc'),
(5, 'Hoa'),
(6, 'Thái');

-- --------------------------------------------------------

--
-- Table structure for table `privilege`
--

CREATE TABLE IF NOT EXISTS `privilege` (
  `Privilege_Name` varchar(32) NOT NULL,
  `Controller_Name` varchar(32) DEFAULT NULL,
  `Privilege_Display_Name` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE IF NOT EXISTS `profile` (
  `UserID` int(11) NOT NULL,
  `Avatar_URL` varchar(254) DEFAULT NULL,
  `Surname` varchar(254) DEFAULT NULL,
  `Firstname` varchar(254) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  `Description` varchar(254) DEFAULT NULL,
  `Phone` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `qua_trinh_cong_tac`
--

CREATE TABLE IF NOT EXISTS `qua_trinh_cong_tac` (
  `Ma_CB` int(11) NOT NULL,
`Ma_QTCT` bigint(20) NOT NULL,
  `Tu_Ngay` date DEFAULT NULL,
  `Den_Ngay` date DEFAULT NULL,
  `So_Luoc` varchar(254) DEFAULT NULL,
  `Chuc_Danh` varchar(62) DEFAULT NULL,
  `Chuc_Vu` varchar(62) DEFAULT NULL,
  `Don_Vi_Cong_Tac` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=615 ;

--
-- Dumping data for table `qua_trinh_cong_tac`
--

INSERT INTO `qua_trinh_cong_tac` (`Ma_CB`, `Ma_QTCT`, `Tu_Ngay`, `Den_Ngay`, `So_Luoc`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`) VALUES
(3, 1, '2008-02-25', '2009-02-25', 'Chủ tịch HSV', NULL, NULL, NULL),
(3, 2, '2009-02-25', '2010-02-25', 'Bí thư Doàn trường', NULL, NULL, NULL),
(5, 3, '2009-02-25', '2010-02-25', 'P.Bí thư Doàn trường', NULL, NULL, NULL),
(8, 4, '2008-02-25', '2009-02-25', 'Chủ tịch HSV', NULL, NULL, NULL),
(8, 5, '2009-02-25', '2010-02-25', 'Bí thư Doàn trường', NULL, NULL, NULL),
(9, 6, '2008-02-25', '2009-02-25', 'Chủ tịch HSV', NULL, NULL, NULL),
(9, 7, '2009-02-25', '2010-02-25', 'Bí thư Doàn trường', NULL, NULL, NULL),
(10, 8, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(10, 9, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(10, 10, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(10, 11, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(10, 12, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(10, 13, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(10, 14, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(10, 15, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(10, 16, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(11, 17, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(11, 18, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(11, 19, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(11, 20, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(11, 21, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(11, 22, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(11, 23, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(11, 24, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(11, 25, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(12, 26, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(12, 27, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(12, 28, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(12, 29, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(12, 30, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(12, 31, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(12, 32, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(12, 33, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(12, 34, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(13, 35, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(13, 36, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(13, 37, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(13, 38, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(13, 39, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(13, 40, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(13, 41, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(13, 42, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(13, 43, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(14, 44, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(14, 45, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(14, 46, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(14, 47, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(14, 48, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(14, 49, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(14, 50, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(14, 51, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(14, 52, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(15, 53, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(15, 54, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(15, 55, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(15, 56, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(15, 57, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(15, 58, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(15, 59, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(15, 60, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(15, 61, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(16, 62, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(16, 63, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(16, 64, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(16, 65, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(16, 66, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(16, 67, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(16, 68, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(16, 69, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(16, 70, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(18, 71, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(18, 72, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(18, 73, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(18, 74, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(18, 75, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(18, 76, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(18, 77, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(18, 78, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(18, 79, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(19, 80, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(19, 81, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(19, 82, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(19, 83, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(19, 84, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(19, 85, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(19, 86, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(19, 87, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(19, 88, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(20, 89, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(20, 90, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(20, 91, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(20, 92, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(20, 93, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(20, 94, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(20, 95, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(20, 96, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(20, 97, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(21, 98, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(21, 99, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(21, 100, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(21, 101, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(21, 102, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(21, 103, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(21, 104, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(21, 105, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(21, 106, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(22, 107, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(22, 108, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(22, 109, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(22, 110, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(22, 111, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(22, 112, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(22, 113, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(22, 114, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(22, 115, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(23, 116, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(23, 117, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(23, 118, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(23, 119, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(23, 120, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(23, 121, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(23, 122, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(23, 123, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(23, 124, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(24, 125, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(24, 126, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(24, 127, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(24, 128, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(24, 129, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(24, 130, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(24, 131, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(24, 132, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(24, 133, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(25, 134, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(25, 135, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(25, 136, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(25, 137, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(25, 138, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(25, 139, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(25, 140, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(25, 141, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(25, 142, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(26, 143, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(26, 144, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(26, 145, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(26, 146, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(26, 147, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(26, 148, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(26, 149, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(26, 150, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(26, 151, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(27, 152, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(27, 153, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(27, 154, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(27, 155, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(27, 156, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(27, 157, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(27, 158, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(27, 159, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(27, 160, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(28, 161, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(28, 162, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(28, 163, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(28, 164, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(28, 165, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(28, 166, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(28, 167, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(28, 168, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(28, 169, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(29, 170, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(29, 171, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(29, 172, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(29, 173, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(29, 174, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(29, 175, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(29, 176, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(29, 177, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(29, 178, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(30, 179, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(30, 180, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(30, 181, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(30, 182, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(30, 183, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(30, 184, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(30, 185, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(30, 186, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(30, 187, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(31, 188, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(31, 189, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(31, 190, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(31, 191, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(31, 192, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(31, 193, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(31, 194, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(31, 195, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(31, 196, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(32, 197, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(32, 198, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(32, 199, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(32, 200, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(32, 201, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(32, 202, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(32, 203, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(32, 204, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(32, 205, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(33, 206, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(33, 207, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(33, 208, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(33, 209, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(33, 210, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(33, 211, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(33, 212, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(33, 213, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(33, 214, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(34, 215, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(34, 216, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(34, 217, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(34, 218, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(34, 219, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(34, 220, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(34, 221, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(34, 222, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(34, 223, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(35, 224, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(35, 225, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(35, 226, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(35, 227, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(35, 228, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL);
INSERT INTO `qua_trinh_cong_tac` (`Ma_CB`, `Ma_QTCT`, `Tu_Ngay`, `Den_Ngay`, `So_Luoc`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`) VALUES
(35, 229, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(35, 230, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(35, 231, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(35, 232, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(36, 233, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(36, 234, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(36, 235, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(36, 236, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(36, 237, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(36, 238, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(36, 239, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(36, 240, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(36, 241, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(37, 242, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(37, 243, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(37, 244, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(37, 245, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(37, 246, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(37, 247, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(37, 248, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(37, 249, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(37, 250, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(38, 251, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(38, 252, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(38, 253, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(38, 254, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(38, 255, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(38, 256, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(38, 257, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(38, 258, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(38, 259, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(39, 260, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(39, 261, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(39, 262, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(39, 263, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(39, 264, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(39, 265, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(39, 266, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(39, 267, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(39, 268, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(40, 269, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(40, 270, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(40, 271, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(40, 272, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(40, 273, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(40, 274, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(40, 275, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(40, 276, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(40, 277, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(41, 278, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(41, 279, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(41, 280, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(41, 281, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(41, 282, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(41, 283, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(41, 284, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(41, 285, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(41, 286, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(42, 287, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(42, 288, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(42, 289, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(42, 290, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(42, 291, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(42, 292, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(42, 293, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(42, 294, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(42, 295, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(43, 296, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(43, 297, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(43, 298, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(43, 299, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(43, 300, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(43, 301, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(43, 302, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(43, 303, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(43, 304, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(44, 305, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(44, 306, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(44, 307, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(44, 308, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(44, 309, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(44, 310, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(44, 311, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(44, 312, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(44, 313, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(46, 314, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(46, 315, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(46, 316, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(46, 317, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(46, 318, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(46, 319, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(46, 320, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(46, 321, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(46, 322, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(47, 323, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(47, 324, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(47, 325, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(47, 326, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(47, 327, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(47, 328, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(47, 329, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(47, 330, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(47, 331, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(48, 332, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(48, 333, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(48, 334, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(48, 335, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(48, 336, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(48, 337, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(48, 338, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(48, 339, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(48, 340, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(49, 341, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(49, 342, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(49, 343, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(49, 344, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(49, 345, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(49, 346, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(49, 347, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(49, 348, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(49, 349, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(50, 350, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(50, 351, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(50, 352, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(50, 353, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(50, 354, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(50, 355, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(50, 356, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(50, 357, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(50, 358, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(51, 359, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(51, 360, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(51, 361, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(51, 362, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(51, 363, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(51, 364, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(51, 365, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(51, 366, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(51, 367, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(52, 368, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(52, 369, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(52, 370, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(52, 371, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(52, 372, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(52, 373, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(52, 374, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(52, 375, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(52, 376, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(53, 377, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(53, 378, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(53, 379, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(53, 380, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(53, 381, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(53, 382, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(53, 383, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(53, 384, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(53, 385, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(54, 386, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(54, 387, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(54, 388, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(54, 389, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(54, 390, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(54, 391, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(54, 392, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(54, 393, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(54, 394, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(55, 395, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(55, 396, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(55, 397, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(55, 398, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(55, 399, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(55, 400, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(55, 401, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(55, 402, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(55, 403, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(56, 404, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(56, 405, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(56, 406, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(56, 407, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(56, 408, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(56, 409, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(56, 410, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(56, 411, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(56, 412, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(57, 413, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(57, 414, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(57, 415, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(57, 416, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(57, 417, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(57, 418, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(57, 419, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(57, 420, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(57, 421, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(59, 422, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(59, 423, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(59, 424, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(59, 425, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(59, 426, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(59, 427, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(59, 428, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(59, 429, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(59, 430, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(60, 431, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(60, 432, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(60, 433, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(60, 434, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(60, 435, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(60, 436, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(60, 437, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(60, 438, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(60, 439, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(61, 440, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(61, 441, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(61, 442, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(61, 443, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(61, 444, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(61, 445, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(61, 446, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(61, 447, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(61, 448, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(62, 449, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(62, 450, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(62, 451, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL);
INSERT INTO `qua_trinh_cong_tac` (`Ma_CB`, `Ma_QTCT`, `Tu_Ngay`, `Den_Ngay`, `So_Luoc`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`) VALUES
(62, 452, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(62, 453, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(62, 454, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(62, 455, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(62, 456, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(62, 457, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(63, 458, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(63, 459, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(63, 460, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(63, 461, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(63, 462, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(63, 463, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(63, 464, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(63, 465, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(63, 466, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(64, 467, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(64, 468, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(64, 469, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(64, 470, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(64, 471, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(64, 472, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(64, 473, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(64, 474, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(64, 475, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(65, 476, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(65, 477, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(65, 478, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(65, 479, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(65, 480, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(65, 481, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(65, 482, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(65, 483, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(65, 484, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(66, 485, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(66, 486, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(66, 487, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(66, 488, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(66, 489, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(66, 490, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(66, 491, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(66, 492, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(66, 493, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(67, 494, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(67, 495, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(67, 496, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(67, 497, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(67, 498, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(67, 499, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(67, 500, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(67, 501, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(67, 502, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(68, 503, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(68, 504, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(68, 505, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(68, 506, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(68, 507, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(68, 508, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(68, 509, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(68, 510, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(68, 511, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(71, 512, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(71, 513, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(71, 514, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(71, 515, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(71, 516, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(71, 517, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(71, 518, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(71, 519, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(71, 520, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(72, 521, '1996-05-22', '2015-05-22', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(72, 522, '1999-05-22', '2015-05-22', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(72, 523, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(72, 524, '2015-05-22', '2015-05-22', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(72, 525, '2015-05-22', '2015-05-22', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(72, 526, '2015-05-22', '2015-05-22', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(72, 527, '2015-05-22', '2015-05-22', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(72, 528, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(72, 529, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(76, 530, '1996-05-23', '2015-05-23', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(76, 531, '1999-05-23', '2015-05-23', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(76, 532, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(76, 533, '2015-05-23', '2015-05-23', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(76, 534, '2015-05-23', '2015-05-23', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(76, 535, '2015-05-23', '2015-05-23', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(76, 536, '2015-05-23', '2015-05-23', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(76, 537, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(76, 538, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(77, 539, '1996-05-23', '2015-05-23', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(77, 540, '1999-05-23', '2015-05-23', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(77, 541, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(77, 542, '2015-05-23', '2015-05-23', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(77, 543, '2015-05-23', '2015-05-23', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(77, 544, '2015-05-23', '2015-05-23', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(77, 545, '2015-05-23', '2015-05-23', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(77, 546, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(77, 547, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(78, 548, '1996-05-23', '2015-05-23', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(78, 549, '1999-05-23', '2015-05-23', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(78, 550, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(78, 551, '2015-05-23', '2015-05-23', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(78, 552, '2015-05-23', '2015-05-23', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(78, 553, '2015-05-23', '2015-05-23', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(78, 554, '2015-05-23', '2015-05-23', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(78, 555, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(78, 556, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(94, 557, '1996-05-23', '2015-05-23', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(94, 558, '1999-05-23', '2015-05-23', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(94, 559, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(94, 560, '2015-05-23', '2015-05-23', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(94, 561, '2015-05-23', '2015-05-23', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(94, 562, '2015-05-23', '2015-05-23', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(94, 563, '2015-05-23', '2015-05-23', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(94, 564, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(94, 565, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(95, 566, '1999-05-23', '2015-05-23', 'Phó Bí thư Chi doàn TTGDTX Q.5', NULL, NULL, NULL),
(95, 567, '2015-05-23', '2015-05-23', 'UVBCH Liên chi doàn khoa Ngữ văn trường CD Sư phạm TP', NULL, NULL, NULL),
(95, 568, '2015-05-23', '2015-05-23', 'Bí thư chi doàn Khu phố 3, P.2, Q.6, Cán bộ Quận Doàn 6', NULL, NULL, NULL),
(95, 569, '2015-05-23', '2015-05-23', 'UVBCH Liên chi doàn Tiểu doàn Bộ binh 2 Trung doàn Gia Dịnh', NULL, NULL, NULL),
(95, 570, '2015-05-23', '2015-05-23', 'UVBCH Quận Doàn, Bí thư Doàn Phường 4, Q.6', NULL, NULL, NULL),
(95, 571, '2015-05-23', '2015-05-23', 'UVBTV Quận Doàn 6', NULL, NULL, NULL),
(95, 572, '2015-05-23', '2015-05-23', 'Cán bộ Văn phòng Thành Doàn', NULL, NULL, NULL),
(95, 573, '2015-05-23', '1970-01-01', 'Phó Ban Kiểm tra Thành Doàn', NULL, NULL, NULL),
(96, 574, '2002-02-01', '2004-05-01', 'Phó Bí thư Doàn phường, Phó Chủ tịch Hội LHTN VN P. 11 Q.11', NULL, NULL, NULL),
(96, 575, '2004-05-01', '2006-03-01', 'Phó Bí thư Doàn phường, Phó Chủ tịch Hội LHTN VN P. 11 Q.11. Kiêm nhiệm vụ chuyên trách Xóa dói giảm nghèo phường.', NULL, NULL, NULL),
(96, 576, '2005-02-01', '2010-05-01', 'UV UBTW Hội LHTN VN nhiệm kỳ V (2005 - 2010)', NULL, NULL, NULL),
(96, 577, '2006-03-01', '2007-07-01', 'Bí thư Doàn phường, Chủ tịch Hội LHTNVN P.11, Q.11. Từ 6/2006: UVBCH Quận Doàn 11.', NULL, NULL, NULL),
(96, 578, '2007-07-01', '2008-07-01', 'UVBTV Quận Doàn 11. Từ 10/2007: UVBCH Thành Doàn nhiệm kỳ VIII (2007 - 2012).', NULL, NULL, NULL),
(96, 579, '2008-07-01', '2010-11-01', 'UVBCH Thành Doàn, Phó Bí thư Quận Doàn 11. Từ 12/2008: Chủ tịch Hội LHTN VN Quận 11. Từ 12/2009: Bí thư Chi bộ Quận Doàn 11.', NULL, NULL, NULL),
(96, 580, '2010-11-01', '2012-11-01', 'UVBCH, Phó Ban Tổ chức Thành Doàn. Từ 7/2012: Phó Bí thư Chi bộ Xây dựng Doàn 1', NULL, NULL, NULL),
(96, 581, '2012-11-01', '2014-04-01', 'UVBTV, Phó Ban Tổ chức Thành Doàn, Phó Bí thư Chi bộ Xây dựng Doàn 1.', NULL, NULL, NULL),
(96, 582, '2014-04-01', '1970-01-01', 'UVBTV, Trưởng Ban Kiểm tra Thành Doàn.', NULL, NULL, NULL),
(97, 583, '1996-06-04', '2015-06-04', 'Học tập và sinh hoạt tại trường DH Kỹ thuật Công nghệ TP. HCM: Doàn viên, Bí thư Liên chi doàn, Bí thư Doàn khoa Quản trị Kinh doanh', NULL, NULL, NULL),
(97, 584, '1999-06-04', '2015-06-04', 'UVBCH Doàn trường, UVBTV, Chánh văn phòng Doàn trường DH Kỹ thuật Công nghệ nhiệm kỳ 2, 3', NULL, NULL, NULL),
(97, 585, '1970-01-01', '1970-01-01', 'Chủ tịch lâm thời, Chủ tịch nhiệm kỳ 1 Hội Sinh viên tường DH Kỹ thuật Công nghệ TP. HCMUVBCH Hội Sinh viên TP. HCM nhiệm kỳ 2', NULL, NULL, NULL),
(97, 586, '2015-06-04', '2015-06-04', 'Phó Bí thư Thường trực Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 2, 3Giám dốc Trung tâm Hỗ trợ Sinh viên trường DH Kỹ thuật Công nghệ', NULL, NULL, NULL),
(97, 587, '2015-06-04', '2015-06-04', 'Bí thư Doàn trường DH Kỹ thuật Công nghệ TP. HCM nhiệm kỳ 3, 4Phó Bí thư Chi bộ (2004, 2005), Bí thư Chi bộ khối chính trị và khối sinh viên (2006, 2007)', NULL, NULL, NULL),
(97, 588, '2015-06-04', '2015-06-04', 'Dảng ủy viên Dảng ủy trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(97, 589, '2015-06-04', '2015-06-04', 'Phó Trưởng phòng Công tác Chính trị sinh viên Trường DH Kỹ thuật Công nghệ TP. HCM', NULL, NULL, NULL),
(97, 590, '1970-01-01', '1970-01-01', 'UVBCH Thành Doàn nhiệm kỳ VIII, Phó Ban Thanh niên trường học Thành Doàn, Phó Chủ tịch Hội Sinh viên TP, UVBTK TW Hội Sinh viên VN', NULL, NULL, NULL),
(97, 591, '1970-01-01', '1970-01-01', 'UVBTK, Phó trưởng Ban Kiểm tra TW Hội Sinh viên VN, Phó Chủ tịch thường trực Hội Sinh viên TPUVBTK Hội LHTN TPUVBTV, Trưởng Ban Thanh niên trường học Thành DoànGiám dốc KTX Sinh viên Lào tại TP. HCMUVBCH Dảng ủy cơ quan Thành Doàn, Phó Bí thư Dảng ủy bộ ', NULL, NULL, NULL),
(98, 592, '2004-09-01', '2008-08-01', 'Lần lượt giữ các nhiệm vụ: Cán bộ, Phó Ban, UVBTV, Trưởng Ban Tư tưởng Văn hóa Quận Doàn Phú Nhuận7/2007 - 1/8/2008: Phó Bí thư Quận Doàn Phú Nhuận7/2007 dến nay và Dảng viên, Doàn viên, Công doàn viên', NULL, NULL, NULL),
(98, 593, '2008-08-01', '2009-03-01', 'Cán bộ Ban Tuyên giáo Thành Doàn', NULL, NULL, NULL),
(98, 594, '2009-03-01', '1970-01-01', 'Phó Ban Tuyên giáo Thành Doàn8/2012: UVBCH Thành Doàn', NULL, NULL, NULL),
(99, 595, '2004-09-01', '2008-08-01', 'Lần lượt giữ các nhiệm vụ: Cán bộ, Phó Ban, UVBTV, Trưởng Ban Tư tưởng Văn hóa Quận Doàn Phú Nhuận7/2007 - 1/8/2008: Phó Bí thư Quận Doàn Phú Nhuận7/2007 dến nay và Dảng viên, Doàn viên, Công doàn viên', NULL, NULL, NULL),
(99, 596, '2008-08-01', '2009-03-01', 'Cán bộ Ban Tuyên giáo Thành Doàn', NULL, NULL, NULL),
(99, 597, '2009-03-01', '1970-01-01', 'Phó Ban Tuyên giáo Thành Doàn8/2012: UVBCH Thành Doàn', NULL, NULL, NULL),
(100, 598, '2004-09-01', '2008-08-01', 'Lần lượt giữ các nhiệm vụ: Cán bộ, Phó Ban, UVBTV, Trưởng Ban Tư tưởng Văn hóa Quận Doàn Phú Nhuận7/2007 - 1/8/2008: Phó Bí thư Quận Doàn Phú Nhuận7/2007 dến nay và Dảng viên, Doàn viên, Công doàn viên', NULL, NULL, NULL),
(100, 599, '2008-08-01', '2009-03-01', 'Cán bộ Ban Tuyên giáo Thành Doàn', NULL, NULL, NULL),
(100, 600, '2009-03-01', '1970-01-01', 'Phó Ban Tuyên giáo Thành Doàn8/2012: UVBCH Thành Doàn', NULL, NULL, NULL),
(101, 601, '1996-09-01', '1998-06-25', 'Chuyên trách Doàn, Phó Bí thư Doàn phường 12 Q.6', NULL, NULL, NULL),
(101, 602, '1998-06-25', '2002-09-01', 'Lần lượt là cán bộ Văn phòng, Chánh văn phòng, UVBTV - Trưởng Ban Công nhân lao dộng Quận Doàn 6', NULL, NULL, NULL),
(101, 603, '2002-10-01', '2007-12-01', 'Cán bộ thi dua - tổng hợp - Văn phòng Thành Doàn', NULL, NULL, NULL),
(101, 604, '2007-12-01', '1970-01-01', 'UVBCH, Phó Văn phòng Thành Doàn', NULL, NULL, NULL),
(101, 605, '2006-05-01', '2009-06-01', 'UVBCH, Phó Văn phòng Thành Doàn kiêm Phó Chủ tịch Công doàn CSTV Khối Phong trào Thành Doàn', NULL, NULL, NULL),
(101, 606, '2009-06-01', '2014-06-01', 'Phó Chủ tịch Công doàn cơ sở cơ quan Thành Doàn (cán bộ công doàn chuyên trách). Từ 07/7/2010: Kiêm Bí thư chi bộ Xây dựng Doàn 1, Dảng ủy viên Dảng bộ Bộ phận khối Phong trào thuộc Dảng bộ cơ quan Thành Doàn.', NULL, NULL, NULL),
(101, 607, '2014-06-01', '1970-01-01', 'Phó Bí thư Dảng ủy cơ quan Thành Doàn', NULL, NULL, NULL),
(102, 608, '1996-09-01', '1998-06-25', 'Chuyên trách Doàn, Phó Bí thư Doàn phường 12 Q.6', NULL, NULL, NULL),
(102, 609, '1998-06-25', '2002-09-01', 'Lần lượt là cán bộ Văn phòng, Chánh văn phòng, UVBTV - Trưởng Ban Công nhân lao dộng Quận Doàn 6', NULL, NULL, NULL),
(102, 610, '2002-10-01', '2007-12-01', 'Cán bộ thi dua - tổng hợp - Văn phòng Thành Doàn', NULL, NULL, NULL),
(102, 611, '2007-12-01', '1970-01-01', 'UVBCH, Phó Văn phòng Thành Doàn', NULL, NULL, NULL),
(102, 612, '2006-05-01', '2009-06-01', 'UVBCH, Phó Văn phòng Thành Doàn kiêm Phó Chủ tịch Công doàn CSTV Khối Phong trào Thành Doàn', NULL, NULL, NULL),
(102, 613, '2009-06-01', '2014-06-01', 'Phó Chủ tịch Công doàn cơ sở cơ quan Thành Doàn (cán bộ công doàn chuyên trách). Từ 07/7/2010: Kiêm Bí thư chi bộ Xây dựng Doàn 1, Dảng ủy viên Dảng bộ Bộ phận khối Phong trào thuộc Dảng bộ cơ quan Thành Doàn.', NULL, NULL, NULL),
(102, 614, '2014-06-01', '1970-01-01', 'Phó Bí thư Dảng ủy cơ quan Thành Doàn', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `qua_trinh_luong`
--

CREATE TABLE IF NOT EXISTS `qua_trinh_luong` (
  `Ma_CB` int(11) NOT NULL,
  `Thoi_Gian_Nang_Luong` date NOT NULL DEFAULT '0001-01-01',
  `Ma_So_Ngach` varchar(254) DEFAULT NULL,
  `Bac_Luong` varchar(32) DEFAULT NULL,
  `He_So_Luong` float DEFAULT NULL,
  `Phu_Cap_Vuot_Khung` float DEFAULT NULL,
  `He_So_Phu_Cap` float DEFAULT NULL,
  `Muc_Luong_Khoang` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qua_trinh_luong`
--

INSERT INTO `qua_trinh_luong` (`Ma_CB`, `Thoi_Gian_Nang_Luong`, `Ma_So_Ngach`, `Bac_Luong`, `He_So_Luong`, `Phu_Cap_Vuot_Khung`, `He_So_Phu_Cap`, `Muc_Luong_Khoang`) VALUES
(1, '2009-02-23', '01.006', '1', 1, 1, 1, 0),
(2, '2009-02-23', '01.006', '1', 1, 1, 1, 0),
(3, '2009-02-23', '01.003', '1', 1, 1, 1, 0),
(4, '2009-02-23', '01.006', '1', 1, 1, 1, 0),
(5, '2009-02-23', '01.004', '1', 1, 1, 1, 0),
(6, '2009-02-23', '01.006', '1', 1, 1, 1, 0),
(7, '2009-02-23', '01.006', '1', 1, 1, 1, 0),
(8, '2009-02-23', '01.003', '1', 1, 1, 1, 0),
(9, '2009-02-23', '01.003', '1', 1, 1, 1, 0),
(9, '2015-06-04', '01.003', '2', 2.34, 0, 0, 0),
(93, '1970-01-01', '00000', '6-Sep', 3.99, 0, 0, 0),
(94, '2015-05-01', '00000', '6-Sep', 3.99, 0, 0, 0),
(95, '1970-01-01', '00000', '', 0, 0, 0, 0),
(96, '1970-01-01', '00000', '', 0, 0, 0, 0),
(97, '1970-01-01', '00000', '6-Sep', 3.99, 0, 0, 0),
(98, '1970-01-01', '00000', '3/9', 3, 0, 0.4, 0),
(99, '1970-01-01', '00000', '3/9', 3, 0, 0.4, 0),
(100, '1970-01-01', '00000', '3/9', 3, 0, 0.4, 0),
(101, '1970-01-01', '00000', '', 0, 0, 0, 0),
(102, '1970-01-01', '00000', '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `Role_Name` varchar(32) NOT NULL,
  `Role_Display_Name` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`Role_Name`, `Role_Display_Name`) VALUES
('admin', 'Quản trị cao cấp'),
('cadre', 'Cán Bộ'),
('manager', 'Cán Bộ Quản lý');

-- --------------------------------------------------------

--
-- Table structure for table `role_privilege_relation`
--

CREATE TABLE IF NOT EXISTS `role_privilege_relation` (
  `Role_Name` varchar(32) NOT NULL,
  `Privilege_Name` varchar(32) NOT NULL,
  `isAllowed` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `Status_Code` tinyint(4) NOT NULL,
  `Status_Name` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`Status_Code`, `Status_Name`) VALUES
(-1, 'blocked'),
(0, 'unconfirmed'),
(1, 'actived');

-- --------------------------------------------------------

--
-- Table structure for table `thanh_vien_gia_dinh`
--

CREATE TABLE IF NOT EXISTS `thanh_vien_gia_dinh` (
`Ma_Quan_He` bigint(20) unsigned NOT NULL,
  `Ma_CB` int(11) NOT NULL,
  `Ben_Vo` tinyint(1) NOT NULL,
  `Quan_He` varchar(62) NOT NULL,
  `Ho_Ten` varchar(62) DEFAULT NULL,
  `Nam_Sinh` date DEFAULT NULL,
  `Thong_Tin_So_Luoc` text,
  `Que_Quan` varchar(254) DEFAULT NULL,
  `Nghe_Nghiep` varchar(254) DEFAULT NULL,
  `Chuc_Danh` varchar(254) DEFAULT NULL,
  `Chuc_Vu` varchar(254) DEFAULT NULL,
  `Don_Vi_Cong_Tac` varchar(254) DEFAULT NULL,
  `Hoc_Tap` varchar(254) DEFAULT NULL,
  `Noi_O` varchar(254) DEFAULT NULL,
  `Thanh_Vien_Cac_To_Chuc` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=634 ;

--
-- Dumping data for table `thanh_vien_gia_dinh`
--

INSERT INTO `thanh_vien_gia_dinh` (`Ma_Quan_He`, `Ma_CB`, `Ben_Vo`, `Quan_He`, `Ho_Ten`, `Nam_Sinh`, `Thong_Tin_So_Luoc`, `Que_Quan`, `Nghe_Nghiep`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`, `Hoc_Tap`, `Noi_O`, `Thanh_Vien_Cac_To_Chuc`) VALUES
(1, 1, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 2, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 2, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 3, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 4, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 4, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 5, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 5, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 6, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 6, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 7, 0, 'Cha', 'Nguyễn Văn A', '1992-05-24', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 7, 1, 'Cha', 'Trần Văn B', '1965-05-24', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 8, 0, 'Cha', 'Nguyễn Văn A', '1992-03-15', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 8, 1, 'Cha', 'Trần Văn B', '1965-03-15', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 9, 0, 'Cha', 'Nguyễn Văn A', '1992-03-15', '………', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 9, 1, 'Cha', 'Trần Văn B', '1965-03-15', '…….', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 10, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 10, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 10, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 10, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 10, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 10, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 10, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 10, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 10, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 11, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 11, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 11, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 11, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 11, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 11, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 11, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 11, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 11, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 12, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 12, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 12, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 12, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 12, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 12, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 12, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 12, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 12, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 13, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 13, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 13, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 13, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 13, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 13, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 13, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 13, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 13, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 14, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 14, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 14, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 14, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 14, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 14, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 14, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 14, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 14, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(64, 15, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 15, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 15, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 15, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 15, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(69, 15, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 15, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 15, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 15, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, 16, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 16, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 16, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 16, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 16, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 16, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 16, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 16, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 16, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 18, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 18, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 18, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 18, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 18, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 18, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 18, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 18, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 18, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 19, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 19, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 19, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 19, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, 19, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 19, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 19, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(98, 19, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 19, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 20, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 20, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, 20, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 20, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 20, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 20, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(106, 20, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 20, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 20, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 21, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 21, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(111, 21, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 21, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 21, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(114, 21, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 21, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 21, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 21, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 22, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 22, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 22, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 22, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(122, 22, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(123, 22, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 22, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 22, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(126, 22, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 23, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(128, 23, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(129, 23, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 23, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(131, 23, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(132, 23, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 23, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(134, 23, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(135, 23, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(136, 24, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(137, 24, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(138, 24, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(139, 24, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(140, 24, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(141, 24, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(142, 24, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 24, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(144, 24, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(145, 25, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(146, 25, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(147, 25, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(148, 25, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(149, 25, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(150, 25, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(151, 25, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(152, 25, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(153, 25, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(154, 26, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(155, 26, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(156, 26, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(157, 26, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(158, 26, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(159, 26, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(160, 26, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 26, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(162, 26, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(163, 27, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(164, 27, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(165, 27, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(166, 27, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(167, 27, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(168, 27, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(169, 27, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(170, 27, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(171, 27, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(172, 28, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(173, 28, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(174, 28, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(175, 28, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(176, 28, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(177, 28, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(178, 28, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(179, 28, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(180, 28, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(181, 29, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(182, 29, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(183, 29, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(184, 29, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(185, 29, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(186, 29, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(187, 29, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(188, 29, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(189, 29, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(190, 30, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(191, 30, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(192, 30, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(193, 30, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(194, 30, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(195, 30, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(196, 30, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(197, 30, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(198, 30, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(199, 31, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 31, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(201, 31, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 31, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(203, 31, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(204, 31, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(205, 31, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(206, 31, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(207, 31, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(208, 32, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(209, 32, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(210, 32, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(211, 32, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(212, 32, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(213, 32, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(214, 32, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(215, 32, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(216, 32, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(217, 33, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(218, 33, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(219, 33, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(220, 33, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 33, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(222, 33, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(223, 33, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(224, 33, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(225, 33, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(226, 34, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(227, 34, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(228, 34, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(229, 34, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(230, 34, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(231, 34, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(232, 34, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(233, 34, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(234, 34, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(235, 35, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(236, 35, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(237, 35, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(238, 35, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(239, 35, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(240, 35, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(241, 35, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(242, 35, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(243, 35, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(244, 36, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(245, 36, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(246, 36, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(247, 36, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(248, 36, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(249, 36, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(250, 36, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(251, 36, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `thanh_vien_gia_dinh` (`Ma_Quan_He`, `Ma_CB`, `Ben_Vo`, `Quan_He`, `Ho_Ten`, `Nam_Sinh`, `Thong_Tin_So_Luoc`, `Que_Quan`, `Nghe_Nghiep`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`, `Hoc_Tap`, `Noi_O`, `Thanh_Vien_Cac_To_Chuc`) VALUES
(252, 36, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(253, 37, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(254, 37, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(255, 37, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(256, 37, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(257, 37, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(258, 37, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(259, 37, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(260, 37, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(261, 37, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(262, 38, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(263, 38, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(264, 38, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(265, 38, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(266, 38, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(267, 38, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(268, 38, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(269, 38, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(270, 38, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(271, 39, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(272, 39, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(273, 39, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(274, 39, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(275, 39, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(276, 39, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(277, 39, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(278, 39, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(279, 39, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(280, 40, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(281, 40, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(282, 40, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(283, 40, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(284, 40, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(285, 40, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(286, 40, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(287, 40, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(288, 40, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(289, 41, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(290, 41, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(291, 41, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(292, 41, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(293, 41, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(294, 41, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(295, 41, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(296, 41, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(297, 41, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(298, 42, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(299, 42, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(300, 42, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(301, 42, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(302, 42, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(303, 42, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(304, 42, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(305, 42, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(306, 42, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(307, 43, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(308, 43, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(309, 43, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(310, 43, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(311, 43, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(312, 43, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(313, 43, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(314, 43, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(315, 43, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(316, 44, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(317, 44, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(318, 44, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(319, 44, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(320, 44, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(321, 44, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(322, 44, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(323, 44, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(324, 44, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(325, 46, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(326, 46, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(327, 46, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(328, 46, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(329, 46, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(330, 46, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331, 46, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(332, 46, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(333, 46, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(334, 47, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(335, 47, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(336, 47, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(337, 47, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(338, 47, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(339, 47, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(340, 47, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(341, 47, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(342, 47, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(343, 48, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(344, 48, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(345, 48, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(346, 48, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(347, 48, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(348, 48, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(349, 48, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(350, 48, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(351, 48, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(352, 49, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(353, 49, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(354, 49, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(355, 49, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(356, 49, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(357, 49, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(358, 49, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(359, 49, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(360, 49, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(361, 50, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(362, 50, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(363, 50, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(364, 50, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(365, 50, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(366, 50, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(367, 50, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(368, 50, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(369, 50, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(370, 51, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(371, 51, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(372, 51, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(373, 51, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(374, 51, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(375, 51, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(376, 51, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(377, 51, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(378, 51, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(379, 52, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(380, 52, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(381, 52, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(382, 52, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(383, 52, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(384, 52, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(385, 52, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(386, 52, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(387, 52, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(388, 53, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(389, 53, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(390, 53, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(391, 53, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(392, 53, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(393, 53, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(394, 53, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(395, 53, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(396, 53, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(397, 54, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(398, 54, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(399, 54, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(400, 54, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(401, 54, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(402, 54, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(403, 54, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(404, 54, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(405, 54, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(406, 55, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(407, 55, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(408, 55, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(409, 55, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(410, 55, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(411, 55, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(412, 55, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(413, 55, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(414, 55, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(415, 56, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(416, 56, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(417, 56, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(418, 56, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(419, 56, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(420, 56, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(421, 56, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(422, 56, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(423, 56, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(424, 57, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(425, 57, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(426, 57, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(427, 57, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(428, 57, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(429, 57, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(430, 57, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(431, 57, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(432, 57, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(433, 59, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(434, 59, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(435, 59, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(436, 59, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(437, 59, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(438, 59, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(439, 59, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(440, 59, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(441, 59, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(442, 60, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(443, 60, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(444, 60, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(445, 60, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(446, 60, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(447, 60, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(448, 60, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(449, 60, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(450, 60, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(451, 61, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(452, 61, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(453, 61, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(454, 61, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(455, 61, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(456, 61, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(457, 61, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(458, 61, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(459, 61, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(460, 62, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(461, 62, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(462, 62, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(463, 62, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(464, 62, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(465, 62, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(466, 62, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(467, 62, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(468, 62, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(469, 63, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(470, 63, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(471, 63, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(472, 63, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(473, 63, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(474, 63, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(475, 63, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(476, 63, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(477, 63, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(478, 64, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(479, 64, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(480, 64, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(481, 64, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(482, 64, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(483, 64, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(484, 64, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(485, 64, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(486, 64, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(487, 65, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(488, 65, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(489, 65, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(490, 65, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(491, 65, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(492, 65, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(493, 65, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(494, 65, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `thanh_vien_gia_dinh` (`Ma_Quan_He`, `Ma_CB`, `Ben_Vo`, `Quan_He`, `Ho_Ten`, `Nam_Sinh`, `Thong_Tin_So_Luoc`, `Que_Quan`, `Nghe_Nghiep`, `Chuc_Danh`, `Chuc_Vu`, `Don_Vi_Cong_Tac`, `Hoc_Tap`, `Noi_O`, `Thanh_Vien_Cac_To_Chuc`) VALUES
(495, 65, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(496, 66, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(497, 66, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(498, 66, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(499, 66, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(500, 66, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(501, 66, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(502, 66, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(503, 66, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(504, 66, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(505, 67, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(506, 67, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(507, 67, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(508, 67, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(509, 67, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(510, 67, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(511, 67, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(512, 67, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(513, 67, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(514, 68, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(515, 68, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(516, 68, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(517, 68, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(518, 68, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(519, 68, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(520, 68, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(521, 68, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(522, 68, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(523, 71, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(524, 71, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(525, 71, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(526, 71, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(527, 71, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(528, 71, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(529, 71, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(530, 71, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(531, 71, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(532, 72, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-22', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(533, 72, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(534, 72, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-22', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(535, 72, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(536, 72, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(537, 72, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(538, 72, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-22', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(539, 72, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(540, 72, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-22', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(541, 76, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-23', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(542, 76, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(543, 76, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-23', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(544, 76, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(545, 76, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(546, 76, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(547, 76, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-23', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(548, 76, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(549, 76, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(550, 77, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-23', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(551, 77, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(552, 77, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-23', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(553, 77, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(554, 77, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(555, 77, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(556, 77, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-23', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(557, 77, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(558, 77, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(559, 78, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-23', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(560, 78, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(561, 78, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-23', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(562, 78, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(563, 78, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(564, 78, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(565, 78, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-23', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(566, 78, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(567, 78, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(568, 94, 0, 'Cha', 'Nguyễn Văn Ký', '2015-05-23', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(569, 94, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(570, 94, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-05-23', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(571, 94, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(572, 94, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(573, 94, 0, 'Anh', 'Nguyễn Trung Tín', '1962-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(574, 94, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-05-23', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(575, 94, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(576, 94, 0, 'Chị', 'Nguyễn Thị Vân', '1974-05-23', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(577, 95, 0, 'Cha', 'Châu Văn Lành', '1963-05-23', 'Quê quán: xã Hòa Khánh, huyện Cái Bè, tỉnh Tiền GiangNghề nghiệp: Thợ mộcNơi ở:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(578, 95, 0, 'Mẹ', 'Trần Mộng Huyền Trang', '1964-05-23', 'Quê quán: Chợ Gạo, huyện Mỹ Tho, tỉnh Tiền GiangNghề nghiệp: Nội trợNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(579, 95, 0, 'Chị ', 'Trần Mộng Bích Thuận', '1982-05-23', 'Quê quán: xã Hòa Khánh, huyện Cái Bè, tỉnh Tiền GiangNghề nghiệp: Công nhânNơi ở:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(580, 96, 0, 'Cha', 'Vương Lai Long', '2015-05-23', 'Quê quán: Trung QuốcNghề nghiệp: Thợ máy. Hiện nay nghỉ ở nhà.Nơi ở: 41/1/1 Dội Cung, P.11, Q.11, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(581, 96, 0, 'Mẹ', 'Dỗ Thị Muối', '2015-05-23', 'Quê quán: Trung QuốcNghề nghiệp: Nội trợNơi ở: 41/1/1 Dội Cung, P.11, Q.11, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(582, 96, 0, 'Chồng', 'Nguyễn Văn Trí', '1982-05-23', 'Quê quán: Long AnNghề nghiệp: CBCNVNơi ở: 220/10 Lê Thị Bạch Cát, P.11, Q.11. TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(583, 96, 0, 'Con', 'Nguyễn Ngọc Minh Hiếu', '2015-05-23', 'Nơi ở: 41/1/1 Dội Cung, P.11, Q.11, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(584, 96, 0, 'Con', 'Nguyễn Ngọc Minh Thảo', '2015-05-23', 'Nơi ở: 41/1/1 Dội Cung, P.11, Q.11, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(585, 96, 0, 'Chị', 'Vương Thanh Vân', '1977-05-23', 'Quê quán: TP. HCMNghề nghiệp: Nội trợNơi ở: Dài Bắc - Dài Loan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(586, 96, 0, 'Anh', 'Vương Thanh Phong', '1978-05-23', 'Quê quán: TP. HCMNghề nghiệp: Kinh doanh dịch vụ InternetNơi ở: P. Bình Trị Dông, Q. Bình Tân, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(587, 96, 0, 'Em', 'Vương Thanh Thuận', '1985-05-23', 'Quê quán: TP. HCMNghề nghiệp: Kinh doanh dịch vụ InternetNơi ở: 41/1/1 Dội Cung, P.11, Q.11, TP. HCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(588, 97, 0, 'Cha', 'Nguyễn Văn Ký', '2015-06-04', 'Nơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang Nghề nghiệp: Làm ruộngMất 4/2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(589, 97, 0, 'Mẹ', 'Nguyễn Thị Nhãn', '2015-06-04', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(590, 97, 0, 'Vợ', 'Huỳnh Thị Ngọc Diễm', '1979-06-04', 'Quê quán: Thạnh Phú, Bến TreCông tác tại Nhà khách Quân khu 7, 52/2D Vạn Hạnh, Trung Chánh, Hóc MônDảng viên Dảng Cộng sản Việt NamNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(591, 97, 0, 'Con', 'Nguyễn Thanh Phú', '2015-06-05', 'Còn nhỏ ở cùng cha mẹ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592, 97, 0, 'Chị', 'Nguyễn Thị Trọng', '1960-06-04', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(593, 97, 0, 'Anh', 'Nguyễn Trung Tín', '1962-06-04', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(594, 97, 0, 'Anh', 'Nguyễn Thành Nghĩa', '1965-06-04', 'Mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(595, 97, 0, 'Anh', 'Nguyễn Thành Nhân', '1971-06-04', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(596, 97, 0, 'Chị', 'Nguyễn Thị Vân', '1974-06-04', 'Nghề nghiệp: Làm ruộngNơi ở: ấp Thanh Hiệp, An Thạnh Thủy, Chợ Gạo, Tiền Giang ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(597, 98, 0, 'Cha', 'Nguyễn Thành Sương', '2015-06-04', 'Quê quán: Phú Hữu, Nhơn Trạch, Dồng NaiDảng viên Dảng Cộng sản Việt Nam 50 năm tuổi Dảng, nguyên cán bộ Công ty Xuất nhập khẩu Ngoại thương Hải Phòng và TP. HCM. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(598, 98, 0, 'Mẹ', 'Nguyễn Kim Hoàng', '2015-06-04', 'Quê quán: Trung An - Củ ChiDảng viên Dảng Cộng sản Việt Nam. Nguyên cán bộ, kế toán trưởng Ban Tổ chức Thành ủy. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(599, 98, 0, 'Chồng', 'Nguyễn Khánh Hòa', '1979-06-04', 'Quê quán: Khánh Hòa, Thạnh Trị, Sóc TrăngDảng viên Dảng Cộng sản Việt Nam. Dảng ủy viên, Phường Dội trưởng P.15, Q.10Nơi ở: Q12 Bạch Mã, cư xá Bắc Hải, P.15, Q.10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(600, 98, 0, 'Con', 'Nguyễn Ái Trân', '2015-06-04', 'Còn nhỏ ở với gia dình', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(601, 98, 0, 'Anh', 'Nguyễn Thành Long', '1965-06-04', 'Dảng viên, Phó Ban Tổ chức Quận ủy 12Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(602, 98, 0, 'Chị', 'Nguyễn Kim Phượng', '1966-06-04', 'CNV siêu thị Coop Mart Nguyễn Dình ChiểuNơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(603, 98, 0, 'Chị', 'Nguyễn Hải Châu', '1970-06-04', 'Nghề nghiệp: Nội trợNơi ở: Lô C, Chung cư Bộ Công an, P. Bình An, Q.2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(604, 99, 0, 'Cha', 'Nguyễn Thành Sương', '2015-06-04', 'Quê quán: Phú Hữu, Nhơn Trạch, Dồng NaiDảng viên Dảng Cộng sản Việt Nam 50 năm tuổi Dảng, nguyên cán bộ Công ty Xuất nhập khẩu Ngoại thương Hải Phòng và TP. HCM. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(605, 99, 0, 'Mẹ', 'Nguyễn Kim Hoàng', '2015-06-04', 'Quê quán: Trung An - Củ ChiDảng viên Dảng Cộng sản Việt Nam. Nguyên cán bộ, kế toán trưởng Ban Tổ chức Thành ủy. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(606, 99, 0, 'Chồng', 'Nguyễn Khánh Hòa', '1979-06-04', 'Quê quán: Khánh Hòa, Thạnh Trị, Sóc TrăngDảng viên Dảng Cộng sản Việt Nam. Dảng ủy viên, Phường Dội trưởng P.15, Q.10Nơi ở: Q12 Bạch Mã, cư xá Bắc Hải, P.15, Q.10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(607, 99, 0, 'Con', 'Nguyễn Ái Trân', '2015-06-04', 'Còn nhỏ ở với gia dình', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(608, 99, 0, 'Anh', 'Nguyễn Thành Long', '1965-06-04', 'Dảng viên, Phó Ban Tổ chức Quận ủy 12Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(609, 99, 0, 'Chị', 'Nguyễn Kim Phượng', '1966-06-04', 'CNV siêu thị Coop Mart Nguyễn Dình ChiểuNơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(610, 99, 0, 'Chị', 'Nguyễn Hải Châu', '1970-06-04', 'Nghề nghiệp: Nội trợNơi ở: Lô C, Chung cư Bộ Công an, P. Bình An, Q.2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(611, 100, 0, 'Cha', 'Nguyễn Thành Sương', '2015-06-04', 'Quê quán: Phú Hữu, Nhơn Trạch, Dồng NaiDảng viên Dảng Cộng sản Việt Nam 50 năm tuổi Dảng, nguyên cán bộ Công ty Xuất nhập khẩu Ngoại thương Hải Phòng và TP. HCM. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(612, 100, 0, 'Mẹ', 'Nguyễn Kim Hoàng', '2015-06-04', 'Quê quán: Trung An - Củ ChiDảng viên Dảng Cộng sản Việt Nam. Nguyên cán bộ, kế toán trưởng Ban Tổ chức Thành ủy. Nay là cán bộ hưu trí P.14, Q.3Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(613, 100, 0, 'Chồng', 'Nguyễn Khánh Hòa', '1979-06-04', 'Quê quán: Khánh Hòa, Thạnh Trị, Sóc TrăngDảng viên Dảng Cộng sản Việt Nam. Dảng ủy viên, Phường Dội trưởng P.15, Q.10Nơi ở: Q12 Bạch Mã, cư xá Bắc Hải, P.15, Q.10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(614, 100, 0, 'Con', 'Nguyễn Ái Trân', '2015-06-04', 'Còn nhỏ ở với gia dình', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(615, 100, 0, 'Anh', 'Nguyễn Thành Long', '1965-06-04', 'Dảng viên, Phó Ban Tổ chức Quận ủy 12Nơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(616, 100, 0, 'Chị', 'Nguyễn Kim Phượng', '1966-06-04', 'CNV siêu thị Coop Mart Nguyễn Dình ChiểuNơi ở: 220/174B Lê Văn Sĩ, P.14, Q.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(617, 100, 0, 'Chị', 'Nguyễn Hải Châu', '1970-06-04', 'Nghề nghiệp: Nội trợNơi ở: Lô C, Chung cư Bộ Công an, P. Bình An, Q.2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(618, 101, 0, 'Cha', 'Nguyễn Văn Thiền', '2015-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Thành viên Hội dồng Nhân dân P.12, Q.6 nhiều khóa liên tục. Là Dảng viên, trưởng ban Mặt trận KP8, P.12, Q.6Bệnh mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(619, 101, 0, 'Mẹ', 'Lê Thị Tuyết', '2015-06-25', 'Quê quán: xã Mỹ Dức Dông, huyện Cái Bè, tỉnh Tiền GiangNghề nghiệp: Buôn bán trái cây tại chợ Bình DiềnNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(620, 101, 0, 'Chồng', 'Nguyễn Văn Dức', '1967-06-25', 'Quê quán: Dồng ThápNghề nghiệp: Phó Giám dốc Công ty CP Thương mại tổng hợp thuộc Tổng Công ty Thương mại Sài GònNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(621, 101, 0, 'Con', 'Nguyễn Dức Gia Bảo', '2015-06-25', 'Học sinh trường Tiểu học Phú Lâm, P.14, Q.6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(622, 101, 0, 'Con', 'Nguyễn Dức Hoàng Phi', '2015-06-25', 'Trường Tư thục mầm non Tuổi Hồng, P.13, Q.6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(623, 101, 0, 'Em', 'Nguyễn Huỳnh Lê Xuân', '1979-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Phụ mẹ bán trái cây tại chợ Bình DiềnNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(624, 101, 0, 'Em', 'Nguyễn Lê Huỳnh Sơn', '1981-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Công nhân viên công ty Cấp nước TPNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(625, 101, 0, 'Em', 'Nguyễn Huỳnh Lê Sang', '1983-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Trung sĩ Dội Cảnh sát thuộc Phòng Cảnh sát PC65, Công an TPNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(626, 102, 0, 'Cha', 'Nguyễn Văn Thiền', '2015-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Thành viên Hội dồng Nhân dân P.12, Q.6 nhiều khóa liên tục. Là Dảng viên, trưởng ban Mặt trận KP8, P.12, Q.6Bệnh mất năm 2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(627, 102, 0, 'Mẹ', 'Lê Thị Tuyết', '2015-06-25', 'Quê quán: xã Mỹ Dức Dông, huyện Cái Bè, tỉnh Tiền GiangNghề nghiệp: Buôn bán trái cây tại chợ Bình DiềnNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(628, 102, 0, 'Chồng', 'Nguyễn Văn Dức', '1967-06-25', 'Quê quán: Dồng ThápNghề nghiệp: Phó Giám dốc Công ty CP Thương mại tổng hợp thuộc Tổng Công ty Thương mại Sài GònNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(629, 102, 0, 'Con', 'Nguyễn Dức Gia Bảo', '2015-06-25', 'Học sinh trường Tiểu học Phú Lâm, P.14, Q.6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(630, 102, 0, 'Con', 'Nguyễn Dức Hoàng Phi', '2015-06-25', 'Trường Tư thục mầm non Tuổi Hồng, P.13, Q.6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(631, 102, 0, 'Em', 'Nguyễn Huỳnh Lê Xuân', '1979-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Phụ mẹ bán trái cây tại chợ Bình DiềnNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(632, 102, 0, 'Em', 'Nguyễn Lê Huỳnh Sơn', '1981-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Công nhân viên công ty Cấp nước TPNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(633, 102, 0, 'Em', 'Nguyễn Huỳnh Lê Sang', '1983-06-25', 'Quê quán: xã Hà Liêm, huyện Hàm Thuận, tỉnh Bình ThuậnNghề nghiệp: Trung sĩ Dội Cảnh sát thuộc Phòng Cảnh sát PC65, Công an TPNơi ở: ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `thong_tin_tham_gia_ban`
--

CREATE TABLE IF NOT EXISTS `thong_tin_tham_gia_ban` (
  `Ma_CB` int(11) NOT NULL,
  `Ma_Ban` int(11) NOT NULL,
  `Ngay_Gia_Nhap` date NOT NULL,
  `Ngay_Roi_Khoi` date DEFAULT NULL,
  `Ly_Do_Chuyen_Den` varchar(254) DEFAULT NULL,
  `Ma_CV` smallint(5) unsigned DEFAULT NULL,
  `La_Cong_Tac_Chinh` tinyint(4) NOT NULL DEFAULT '1',
  `STT_To` tinyint(4) DEFAULT NULL,
  `Ma_Ban_Truoc_Do` int(11) DEFAULT NULL,
  `Ngay_GN_Ban_Truoc_Do` date DEFAULT NULL,
  `Trang_Thai` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1-Dang công tác, 0-dã chuyển di'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `thong_tin_tham_gia_ban`
--

INSERT INTO `thong_tin_tham_gia_ban` (`Ma_CB`, `Ma_Ban`, `Ngay_Gia_Nhap`, `Ngay_Roi_Khoi`, `Ly_Do_Chuyen_Den`, `Ma_CV`, `La_Cong_Tac_Chinh`, `STT_To`, `Ma_Ban_Truoc_Do`, `Ngay_GN_Ban_Truoc_Do`, `Trang_Thai`) VALUES
(1, 1, '2014-04-01', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(1, 2, '2014-04-01', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(1, 5, '2014-04-01', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 9, '2014-05-24', NULL, ' ', 9, 1, NULL, 0, NULL, 1),
(1, 11, '2014-05-24', NULL, NULL, 8, 1, NULL, NULL, NULL, 1),
(1, 13, '2015-05-13', NULL, NULL, 11, 1, NULL, NULL, NULL, 1),
(1, 14, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 15, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 16, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 17, '2015-05-22', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(1, 18, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 19, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 20, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 21, '2015-05-22', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 22, '2015-06-04', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 23, '2015-06-04', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(1, 24, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 25, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 26, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 27, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 28, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 29, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 30, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 31, '2015-06-04', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 32, '2015-06-29', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 33, '2015-06-30', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 34, '2015-06-29', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 35, '2015-06-23', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 36, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 37, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(1, 38, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(2, 1, '2014-04-01', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(2, 2, '2014-04-01', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(2, 5, '2014-04-01', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(2, 7, '2014-05-24', NULL, ' ', 0, 1, NULL, 0, NULL, 1),
(2, 11, '2014-05-24', NULL, NULL, 8, 1, NULL, NULL, NULL, 1),
(2, 13, '2015-05-13', NULL, NULL, 7, 1, NULL, NULL, NULL, 1),
(2, 15, '2015-05-22', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(2, 18, '2015-05-22', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(2, 22, '2015-06-04', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(2, 36, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(2, 37, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(2, 38, '2015-06-16', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(3, 1, '2014-04-01', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(3, 8, '2014-05-24', NULL, ' ', 9, 1, NULL, 0, NULL, 1),
(3, 11, '2014-05-24', NULL, NULL, 6, 1, NULL, NULL, NULL, 1),
(3, 13, '2015-05-13', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(3, 18, '2015-05-22', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(3, 22, '2015-06-04', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(3, 23, '2015-06-04', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(4, 1, '2014-04-01', NULL, NULL, 2, 1, NULL, NULL, NULL, 1),
(4, 13, '2015-05-13', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(4, 23, '2015-06-04', NULL, NULL, 3, 1, NULL, NULL, NULL, 1),
(5, 6, '2014-05-24', NULL, ' ', 9, 1, NULL, 0, NULL, 1),
(6, 4, '2014-05-24', NULL, ' ', 0, 1, NULL, 0, NULL, 1),
(6, 11, '2014-05-24', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(6, 13, '2015-05-13', NULL, NULL, 1, 1, NULL, NULL, NULL, 1),
(7, 5, '2015-06-24', '2015-06-24', ' ', 1, 1, NULL, 11, '2014-05-24', 0),
(7, 10, '2015-06-25', NULL, ' ', 2, 1, NULL, 18, '2015-06-24', 1),
(7, 11, '2014-05-24', '2015-06-24', NULL, 3, 1, NULL, NULL, NULL, 0),
(7, 18, '2015-06-24', '2015-06-25', ' ', 5, 1, NULL, 5, '2015-06-24', 0),
(9, 12, '2015-03-15', NULL, NULL, 0, 1, NULL, NULL, NULL, 1),
(9, 13, '2015-05-13', NULL, NULL, 16, 1, NULL, NULL, NULL, 1),
(11, 8, '2015-06-04', '2015-06-25', ' phu hop', 0, 1, NULL, 23, '2015-06-04', 0),
(11, 23, '2015-06-04', '2015-06-04', NULL, 7, 1, NULL, NULL, NULL, 0),
(94, 21, '2015-06-25', NULL, '', 3, 1, NULL, 0, '1970-01-01', 1),
(96, 23, '2015-06-04', NULL, NULL, 15, 1, NULL, NULL, NULL, 1),
(99, 7, '2015-06-25', NULL, ' ', 4, 1, NULL, 0, '1970-01-01', 1);

--
-- Triggers `thong_tin_tham_gia_ban`
--
DELIMITER //
CREATE TRIGGER `tg_ngayroikhoi` BEFORE INSERT ON `thong_tin_tham_gia_ban`
 FOR EACH ROW IF(NEW.Ngay_Gia_Nhap>NEW.Ngay_Roi_Khoi) THEN

	SET NEW.Ngay_Roi_Khoi = null;
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ton_giao`
--

CREATE TABLE IF NOT EXISTS `ton_giao` (
`Ma_Ton_Giao` smallint(6) NOT NULL,
  `Ten_Ton_Giao` varchar(62) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ton_giao`
--

INSERT INTO `ton_giao` (`Ma_Ton_Giao`, `Ten_Ton_Giao`) VALUES
(0, '(không)'),
(1, '(khác)'),
(2, 'Phật Giáo'),
(3, 'Cao Dài'),
(4, 'Hòa Hảo'),
(5, 'Thiên Chúa'),
(6, 'Ấn Dộ Giáo'),
(7, 'Hiếu Nghĩa');

-- --------------------------------------------------------

--
-- Table structure for table `to_cong_tac`
--

CREATE TABLE IF NOT EXISTS `to_cong_tac` (
  `Ma_Ban` int(11) NOT NULL,
  `STT_To` tinyint(4) NOT NULL,
  `Ten_To` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trinh_do_chuyen_mon`
--

CREATE TABLE IF NOT EXISTS `trinh_do_chuyen_mon` (
  `Cap_Do_TDCM` decimal(4,2) NOT NULL DEFAULT '0.00',
  `Ten_TDCM` varchar(254) DEFAULT NULL,
  `Viet_Tat_TDCM` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trinh_do_chuyen_mon`
--

INSERT INTO `trinh_do_chuyen_mon` (`Cap_Do_TDCM`, `Ten_TDCM`, `Viet_Tat_TDCM`) VALUES
('12.00', '(chưa có bằng CM)', ''),
('14.00', 'Trung cấp', 'TC'),
('14.50', 'TC Chuyên Nghiệp', 'TCCN'),
('15.00', 'Cao dẳng', 'CD'),
('16.00', 'Cử nhân', 'CN DH'),
('16.50', 'Kỹ sư', 'KS DH'),
('18.00', 'Thạc Sỹ', 'ThS'),
('20.00', 'Tiến Sỹ', 'TS'),
('22.00', 'Tiến Sỹ Khoa Học', 'TSKH');

-- --------------------------------------------------------

--
-- Table structure for table `trinh_do_ly_luan_chinh_tri`
--

CREATE TABLE IF NOT EXISTS `trinh_do_ly_luan_chinh_tri` (
  `Cap_Do_LLCT` decimal(4,2) NOT NULL DEFAULT '0.00',
  `Ten_CTLL` varchar(254) DEFAULT NULL,
  `Viet_Tat_CTLL` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trinh_do_ly_luan_chinh_tri`
--

INSERT INTO `trinh_do_ly_luan_chinh_tri` (`Cap_Do_LLCT`, `Ten_CTLL`, `Viet_Tat_CTLL`) VALUES
('0.00', '(chưa có)', ''),
('1.00', 'Sơ cấp', 'SC'),
('2.00', 'Trung cấp', 'TC'),
('3.00', 'Cao cấp', 'CC');

-- --------------------------------------------------------

--
-- Table structure for table `tt_tai_don_vi`
--

CREATE TABLE IF NOT EXISTS `tt_tai_don_vi` (
  `NgayDen` datetime DEFAULT NULL,
  `LidoChuyenDen` varchar(254) DEFAULT NULL,
  `HoSoXacNhan` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`UserID` int(11) NOT NULL,
  `Username` varchar(254) NOT NULL,
  `Password` varchar(254) DEFAULT NULL,
  `Identifier_Info` int(11) DEFAULT NULL,
  `Status_Code` tinyint(4) DEFAULT '1',
  `Role_Name` varchar(32) DEFAULT NULL,
  `Password_Key` varchar(254) NOT NULL DEFAULT 'dk'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=108 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `Username`, `Password`, `Identifier_Info`, `Status_Code`, `Role_Name`, `Password_Key`) VALUES
(1, 'admin', '66579284dd25f62cde52b036108c4bd6', NULL, 1, 'admin', 'dk'),
(2, 'manager', '6a232067ffa0524527d7b12634648f77', NULL, 1, 'manager', '01/04/2014 02:04:18:0418'),
(3, '123789456', 'f9e68030fbe761f4ffed1a8c7dc1f98e', 1, 1, 'cadre', '24/05/2014 06:05:35:0535'),
(4, '123456589', '63796fc51177f2dc1ecf1841d04e9c8e', 2, 1, 'cadre', '24/05/2014 06:05:11:0511'),
(5, '352039720', 'ee6e64d7b089f093c88e462ddcd8aad9', 3, 1, 'cadre', '24/05/2014 06:05:23:0523'),
(6, '321456789', '9a78402cd2fef808b6f1611851654d02', 4, 1, 'cadre', '24/05/2014 06:05:36:0536'),
(7, '123456789', '50c84698f1f2ac4675d55aabad6912e8', 5, 1, 'cadre', '24/05/2014 06:05:37:0537'),
(8, '121456789', '51a804b56a37baab4c04268f26dfad03', 6, 1, 'cadre', '04/06/2015 05:06:40:0640'),
(9, '151456789', 'f471810d42aad0be9ffc2cc7814588fa', 7, 1, 'cadre', '24/05/2014 06:05:40:0540'),
(10, '334516187', '2aaf3fc1f3624a7438227460f0bafd42', 10, 1, 'cadre', '22/05/2015 09:05:23:0523'),
(15, '3345121212', '77a2fe734311287cb453c5628f6eb19d', 15, 1, 'cadre', '22/05/2015 10:05:35:0535'),
(16, '33455454', '94e60e43f2c61ae64c0ddcd6caa991d8', 16, 1, 'cadre', '22/05/2015 10:05:02:0502'),
(17, '123123123', '032fc10e1448dfaf2bccfc0c2abf6866', 18, 1, 'cadre', '22/05/2015 10:05:47:0547'),
(29, '1231231', '721ac847009e7a176a2f6d6a10321974', 30, 1, 'cadre', '22/05/2015 11:05:07:0507'),
(34, '123123', '94110c2c589c87f3a2157ffcaea4520b', 35, 1, 'cadre', '22/05/2015 11:05:16:0516'),
(49, '321321', '72714441837d7e97c566824044738953', 51, 1, 'cadre', '22/05/2015 12:05:55:0555'),
(51, '234234', '19283a28518abfb1a0b95ae18a32e176', 53, 1, 'cadre', '22/05/2015 12:05:48:0548'),
(55, '789789', '43c5af56bff42d5f5526ae725ae59307', 57, 1, 'cadre', '22/05/2015 12:05:52:0552'),
(56, '78978', '45b9ea00502ab561339b773224df86a8', 59, 1, 'cadre', '22/05/2015 12:05:57:0557'),
(60, '321123', 'c61a7062bb0e96766eb711a1b1a591d6', 63, 1, 'cadre', '22/05/2015 12:05:11:0511'),
(62, '123321', 'fe0d8d5e665ebfcce110ae1ad2edd8e1', 65, 1, 'cadre', '22/05/2015 12:05:56:0556'),
(68, '321', '3a0dba068f2a5ed12afcf26886c869e3', NULL, 1, 'cadre', '22/05/2015 02:05:19:0519'),
(85, '312312', 'b29968ecbfe57f9a6f4fbda5bade7c78', NULL, 1, 'cadre', '22/05/2015 06:05:59:0559'),
(90, '12313321', 'a80ce524426c464f032401051109b955', NULL, 1, 'cadre', '22/05/2015 06:05:08:0508'),
(95, '1231232132', 'dacc41c05b9b352f78994016ecd9d864', 95, 1, 'cadre', '23/05/2015 07:05:22:0522'),
(96, '123131231', '6150a1d4251c0ddcc50d876c90072d08', 96, 1, 'cadre', '23/05/2015 07:05:44:0544'),
(97, '123', '202cb962ac59075b964b07152d234b70', 97, 1, 'cadre', '04/06/2015 03:06:44:0644'),
(98, '932123321', '202cb962ac59075b964b07152d234b70', 98, 1, 'cadre', '04/06/2015 04:06:31:0631'),
(100, 'democanbo', '63ee451939ed580ef3c4b6f0109d1fd0', 100, 1, 'cadre', '04/06/2015 04:06:54:0654'),
(101, '333', 'b45ab0b0579fe045c4a854fb78236254', 101, 1, 'cadre', '25/06/2015 06:06:35:0635'),
(103, 'canbo', '1421888a567b7500d0cba5d9ccebb752', 102, 1, 'manager', '25/06/2015 06:06:50:0650'),
(106, 'canboquanly', 'c0415be28ad8a3c18b2fdaf019140780', 102, 1, 'manager', '25/06/2015 06:06:45:0645'),
(107, 'canbothuong', '2233607ee1ab86455545ef10b385467a', 14, 1, 'cadre', '25/06/2015 06:06:16:0616');

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE IF NOT EXISTS `user_log` (
  `Thoi_Gian` datetime NOT NULL,
  `Ma_User_Thuc_Hien` int(11) NOT NULL,
  `Ma_CB_Thuc_Hien` int(11) DEFAULT NULL,
  `Chuc_Nang` varchar(254) DEFAULT NULL,
  `Noi_Dung` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`Thoi_Gian`, `Ma_User_Thuc_Hien`, `Ma_CB_Thuc_Hien`, `Chuc_Nang`, `Noi_Dung`) VALUES
('2014-05-24 19:04:32', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Lê Dức Thịnh'),
('2014-05-24 19:04:47', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Nguyễn Trác Thức'),
('2014-05-24 19:05:01', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Nguyễn Tuấn Anh'),
('2014-05-24 19:05:17', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Trương Dăng Khoa'),
('2014-05-24 19:06:01', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Trần Dình Thi'),
('2014-05-24 19:06:16', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Vưu Chí Hào'),
('2014-05-24 19:06:30', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Doàn Thi Xuân Thu'),
('2014-05-25 10:42:03', 2, 6, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: Nguyễn Trác Thức'),
('2015-05-08 14:05:22', 1, NULL, 'Thêm công tác nước ngoài', 'Thêm công tác nước ngoài cho cán bộ: '),
('2015-05-08 14:05:52', 1, NULL, 'Thêm công tác nước ngoài', 'Thêm công tác nước ngoài cho cán bộ: '),
('2015-06-04 16:10:50', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: '),
('2015-06-04 16:17:54', 1, NULL, 'Nâng lương', 'Nâng lương cán bộ: Trần Dình Thi 123'),
('2015-06-04 16:20:10', 1, NULL, 'Thêm công tác nước ngoài', 'Thêm công tác nước ngoài cho cán bộ: AAAA'),
('2015-06-04 17:07:55', 1, 6, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: Nguyễn Trác Thức'),
('2015-06-24 14:21:16', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Lê Dức Thịnh'),
('2015-06-24 14:22:08', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Lê Dức Thịnh'),
('2015-06-25 05:35:26', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: Lê Dức Thịnh'),
('2015-06-25 05:51:13', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: '),
('2015-06-25 06:20:14', 1, NULL, 'Luân chuyển', 'Cập nhật luân chuyển cán bộ: canbodemo'),
('2015-06-25 06:37:37', 1, 94, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: AAAA'),
('2015-06-25 06:38:09', 1, 98, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: canbo'),
('2015-06-25 06:38:27', 1, 99, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: canbodemo'),
('2015-06-25 07:12:49', 1, 10, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: '),
('2015-06-25 07:13:08', 1, 11, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: '),
('2015-06-25 07:13:33', 1, 15, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: '),
('2015-06-25 07:14:03', 1, 16, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: '),
('2015-06-25 07:14:24', 1, 17, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: '),
('2015-06-25 07:14:39', 1, 19, 'Sửa thông tin lý lịch', 'Sửa thông tin của cán bộ: ');

-- --------------------------------------------------------

--
-- Table structure for table `yeu_cau_thay_doi_tt_cb`
--

CREATE TABLE IF NOT EXISTS `yeu_cau_thay_doi_tt_cb` (
`Ma_Yeu_Cau` bigint(20) unsigned NOT NULL,
  `Ma_CB_Anh_Huong` int(11) NOT NULL,
  `Ma_CB_Yeu_Cau` int(11) NOT NULL,
  `Ten_Yeu_Cau` varchar(254) DEFAULT NULL,
  `Loi_Noi` varchar(254) DEFAULT NULL,
  `Trang_Thai` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `dac_diem_lich_su`
--

CREATE TABLE IF NOT EXISTS `dac_diem_lich_su` (
  `Ma_CB` int(11) NOT NULL,
  `Ma_DDLS` bigint(20) NOT NULL,
  `Su_Kien` varchar(254) DEFAULT NULL,
  `Tu_Thoi_Diem` date DEFAULT NULL,
  `Den_Thoi_Diem` date DEFAULT NULL,
  `Nguoi_Nhan_Khai_Bao` varchar(254) DEFAULT NULL,
  `Noi_Dung` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia_can_bo`
--

CREATE TABLE IF NOT EXISTS `danh_gia_can_bo` (
  `Ma_CB_Tu_Danh_Gia` int(11) NOT NULL,
  `Ngay_Danh_Gia` date NOT NULL,
  `Noi_Dung_Tu_Danh_Gia` text,
  `Ma_MDHT_Tu_Danh_Gia` tinyint(4) DEFAULT NULL,
  `Ma_DV_Muon_Den` smallint(5) unsigned DEFAULT NULL,
  `Ma_Ban_Muon_Den` int(11) DEFAULT NULL,
  `Thoi_Gian_Muon_Chuyen` date DEFAULT NULL,
  `Nguyen_Vong_Dao_Tao` text,
  `Ma_CB_Danh_Gia` int(11) DEFAULT NULL,
  `Noi_Dung_Danh_Gia` text,
  `Ma_MDHT` tinyint(4) DEFAULT NULL,
  `Ma_CHPT` tinyint(4) DEFAULT NULL,
  `Dinh_Huong` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dao_tao_boi_duong`
--

CREATE TABLE IF NOT EXISTS `dao_tao_boi_duong` (
  `Ma_CB` int(11) NOT NULL,
`Ma_DTBD` bigint(20) unsigned NOT NULL,
  `Ten_Truong` varchar(254) DEFAULT NULL,
  `Nganh_Hoc` varchar(254) DEFAULT NULL,
  `Thoi_Gian_Hoc` date DEFAULT NULL,
  `TG_Ket_Thuc` date DEFAULT NULL,
  `Hinh_Thuc_Hoc` varchar(254) DEFAULT NULL,
  `Van_Bang_Chung_Chi` varchar(254) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=608 ;

--
-- Dumping data for table `dao_tao_boi_duong`
--

INSERT INTO `dao_tao_boi_duong` (`Ma_CB`, `Ma_DTBD`, `Ten_Truong`, `Nganh_Hoc`, `Thoi_Gian_Hoc`, `TG_Ket_Thuc`, `Hinh_Thuc_Hoc`, `Van_Bang_Chung_Chi`) VALUES
(3, 1, 'NewStar', 'Mạng máy tính', '2010-12-22', '2011-01-21', 'Tập trung', 'CCNA'),
(3, 2, 'VUS', 'Toeic', '2010-12-22', '2011-01-21', 'Tập trung', 'Toeic 600'),
(5, 3, 'NewStar', 'Mạng máy tính', '2010-12-22', '2011-01-21', 'Tập trung', 'CCNA'),
(5, 4, 'VUS', 'Toeic', '2010-12-22', '2011-01-21', 'Tập trung', 'Toeic 600'),
(8, 5, 'NewStar', 'Mạng máy tính', '2010-12-22', '2011-01-21', 'Tập trung', 'CCNA'),
(8, 6, 'VUS', 'Toeic', '2010-12-22', '2011-01-21', 'Tập trung', 'Toeic 600'),
(9, 7, 'NewStar', 'Mạng máy tính', '2010-12-22', '2011-01-21', 'Tập trung', 'CCNA'),
(9, 8, 'VUS', 'Toeic', '2010-12-22', '2011-01-21', 'Tập trung', 'Toeic 600'),
(10, 9, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', NULL, 'Chính quy', 'Cử nhân'),
(10, 10, '', 'Anh văn', '1999-05-22', NULL, '', 'Chứng chỉ B'),
(10, 11, '', 'Tin học', '1999-05-22', NULL, '', 'Chứng chỉ B'),
(10, 12, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', NULL, '', 'Chứng chỉ '),
(10, 13, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', NULL, '', 'Giấy Chứng nhận'),
(10, 14, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', NULL, 'Tập trung', 'Giấy Chứng nhận'),
(10, 15, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', NULL, 'Tập trung', 'Giấy chứng nhận'),
(10, 16, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', NULL, 'Tập trung', 'Giấy Chứng nhận'),
(10, 17, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', NULL, 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(11, 18, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(11, 19, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(11, 20, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(11, 21, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(11, 22, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(11, 23, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(11, 24, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(11, 25, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(11, 26, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(12, 27, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(12, 28, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(12, 29, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(12, 30, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(12, 31, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(12, 32, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(12, 33, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(12, 34, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(12, 35, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(13, 36, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(13, 37, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(13, 38, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(13, 39, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(13, 40, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(13, 41, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(13, 42, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(13, 43, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(13, 44, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(14, 45, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(14, 46, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(14, 47, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(14, 48, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(14, 49, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(14, 50, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(14, 51, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(14, 52, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(14, 53, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(15, 54, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(15, 55, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(15, 56, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(15, 57, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(15, 58, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(15, 59, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(15, 60, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(15, 61, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(15, 62, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(16, 63, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(16, 64, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(16, 65, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(16, 66, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(16, 67, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(16, 68, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(16, 69, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(16, 70, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(16, 71, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(18, 72, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(18, 73, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(18, 74, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(18, 75, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(18, 76, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(18, 77, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(18, 78, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(18, 79, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(18, 80, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(19, 81, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(19, 82, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(19, 83, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(19, 84, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(19, 85, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(19, 86, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(19, 87, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(19, 88, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(19, 89, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(20, 90, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(20, 91, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(20, 92, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(20, 93, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(20, 94, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(20, 95, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(20, 96, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(20, 97, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(20, 98, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(21, 99, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(21, 100, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(21, 101, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(21, 102, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(21, 103, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(21, 104, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(21, 105, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(21, 106, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(21, 107, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(22, 108, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(22, 109, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(22, 110, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(22, 111, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(22, 112, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(22, 113, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(22, 114, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(22, 115, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(22, 116, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(23, 117, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(23, 118, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(23, 119, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(23, 120, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(23, 121, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(23, 122, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(23, 123, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(23, 124, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(23, 125, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(24, 126, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(24, 127, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(24, 128, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(24, 129, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(24, 130, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(24, 131, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(24, 132, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(24, 133, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(24, 134, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(25, 135, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(25, 136, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(25, 137, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(25, 138, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(25, 139, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(25, 140, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(25, 141, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(25, 142, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(25, 143, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(26, 144, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(26, 145, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(26, 146, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(26, 147, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(26, 148, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(26, 149, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(26, 150, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(26, 151, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(26, 152, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(27, 153, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(27, 154, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(27, 155, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(27, 156, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(27, 157, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(27, 158, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(27, 159, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(27, 160, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(27, 161, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(28, 162, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(28, 163, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(28, 164, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(28, 165, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(28, 166, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(28, 167, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(28, 168, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(28, 169, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(28, 170, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(29, 171, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(29, 172, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(29, 173, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(29, 174, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(29, 175, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(29, 176, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(29, 177, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(29, 178, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(29, 179, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(30, 180, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(30, 181, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(30, 182, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(30, 183, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(30, 184, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(30, 185, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(30, 186, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(30, 187, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(30, 188, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(31, 189, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(31, 190, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(31, 191, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(31, 192, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(31, 193, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(31, 194, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(31, 195, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(31, 196, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(31, 197, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(32, 198, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(32, 199, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(32, 200, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(32, 201, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(32, 202, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(32, 203, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(32, 204, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(32, 205, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(32, 206, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(33, 207, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(33, 208, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(33, 209, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(33, 210, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(33, 211, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(33, 212, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(33, 213, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(33, 214, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(33, 215, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(34, 216, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(34, 217, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(34, 218, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(34, 219, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(34, 220, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(34, 221, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(34, 222, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(34, 223, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(34, 224, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(35, 225, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(35, 226, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(35, 227, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(35, 228, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(35, 229, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(35, 230, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(35, 231, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(35, 232, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(35, 233, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(36, 234, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(36, 235, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(36, 236, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(36, 237, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(36, 238, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(36, 239, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(36, 240, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(36, 241, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(36, 242, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(37, 243, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(37, 244, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(37, 245, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(37, 246, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(37, 247, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(37, 248, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(37, 249, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(37, 250, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(37, 251, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(38, 252, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(38, 253, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(38, 254, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(38, 255, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(38, 256, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(38, 257, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(38, 258, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(38, 259, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(38, 260, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(39, 261, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(39, 262, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(39, 263, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(39, 264, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(39, 265, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(39, 266, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(39, 267, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(39, 268, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(39, 269, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(40, 270, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(40, 271, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(40, 272, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(40, 273, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(40, 274, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(40, 275, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(40, 276, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(40, 277, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(40, 278, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(41, 279, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(41, 280, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(41, 281, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(41, 282, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(41, 283, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(41, 284, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(41, 285, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(41, 286, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(41, 287, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(42, 288, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(42, 289, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(42, 290, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(42, 291, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(42, 292, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(42, 293, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(42, 294, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(42, 295, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(42, 296, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(43, 297, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(43, 298, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(43, 299, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(43, 300, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(43, 301, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(43, 302, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(43, 303, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(43, 304, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(43, 305, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(44, 306, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(44, 307, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(44, 308, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(44, 309, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(44, 310, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(44, 311, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(44, 312, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(44, 313, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(44, 314, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(46, 315, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(46, 316, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(46, 317, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(46, 318, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(46, 319, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(46, 320, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(46, 321, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(46, 322, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(46, 323, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(47, 324, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(47, 325, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(47, 326, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(47, 327, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(47, 328, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(47, 329, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(47, 330, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(47, 331, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(47, 332, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(48, 333, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(48, 334, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(48, 335, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(48, 336, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(48, 337, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(48, 338, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(48, 339, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(48, 340, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(48, 341, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị');
INSERT INTO `dao_tao_boi_duong` (`Ma_CB`, `Ma_DTBD`, `Ten_Truong`, `Nganh_Hoc`, `Thoi_Gian_Hoc`, `TG_Ket_Thuc`, `Hinh_Thuc_Hoc`, `Van_Bang_Chung_Chi`) VALUES
(49, 342, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(49, 343, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(49, 344, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(49, 345, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(49, 346, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(49, 347, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(49, 348, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(49, 349, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(49, 350, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(50, 351, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(50, 352, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(50, 353, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(50, 354, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(50, 355, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(50, 356, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(50, 357, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(50, 358, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(50, 359, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(51, 360, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(51, 361, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(51, 362, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(51, 363, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(51, 364, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(51, 365, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(51, 366, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(51, 367, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(51, 368, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(52, 369, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(52, 370, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(52, 371, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(52, 372, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(52, 373, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(52, 374, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(52, 375, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(52, 376, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(52, 377, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(53, 378, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(53, 379, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(53, 380, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(53, 381, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(53, 382, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(53, 383, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(53, 384, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(53, 385, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(53, 386, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(54, 387, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(54, 388, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(54, 389, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(54, 390, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(54, 391, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(54, 392, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(54, 393, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(54, 394, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(54, 395, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(55, 396, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(55, 397, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(55, 398, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(55, 399, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(55, 400, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(55, 401, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(55, 402, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(55, 403, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(55, 404, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(56, 405, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(56, 406, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(56, 407, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(56, 408, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(56, 409, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(56, 410, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(56, 411, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(56, 412, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(56, 413, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(57, 414, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(57, 415, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(57, 416, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(57, 417, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(57, 418, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(57, 419, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(57, 420, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(57, 421, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(57, 422, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(59, 423, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(59, 424, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(59, 425, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(59, 426, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(59, 427, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(59, 428, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(59, 429, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(59, 430, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(59, 431, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(60, 432, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(60, 433, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(60, 434, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(60, 435, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(60, 436, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(60, 437, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(60, 438, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(60, 439, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(60, 440, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(61, 441, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(61, 442, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(61, 443, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(61, 444, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(61, 445, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(61, 446, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(61, 447, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(61, 448, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(61, 449, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(62, 450, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(62, 451, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(62, 452, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(62, 453, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(62, 454, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(62, 455, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(62, 456, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(62, 457, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(62, 458, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(63, 459, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(63, 460, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(63, 461, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(63, 462, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(63, 463, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(63, 464, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(63, 465, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(63, 466, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(63, 467, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(64, 468, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(64, 469, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(64, 470, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(64, 471, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(64, 472, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(64, 473, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(64, 474, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(64, 475, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(64, 476, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(65, 477, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(65, 478, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(65, 479, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(65, 480, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(65, 481, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(65, 482, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(65, 483, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(65, 484, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(65, 485, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(66, 486, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(66, 487, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(66, 488, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(66, 489, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(66, 490, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(66, 491, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(66, 492, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(66, 493, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(66, 494, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(67, 495, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(67, 496, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(67, 497, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(67, 498, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(67, 499, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(67, 500, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(67, 501, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(67, 502, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(67, 503, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(68, 504, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(68, 505, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(68, 506, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(68, 507, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(68, 508, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(68, 509, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(68, 510, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(68, 511, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(68, 512, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(71, 513, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(71, 514, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(71, 515, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(71, 516, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(71, 517, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(71, 518, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(71, 519, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(71, 520, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(71, 521, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(72, 522, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(72, 523, '', 'Anh văn', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(72, 524, '', 'Tin học', '1999-05-22', '1999-05-22', '', 'Chứng chỉ B'),
(72, 525, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-22', '1999-05-22', '', 'Chứng chỉ '),
(72, 526, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(72, 527, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-22', '2015-05-22', 'Tập trung', 'Giấy Chứng nhận'),
(72, 528, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(72, 529, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(72, 530, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-22', '2015-05-22', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(76, 531, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(76, 532, '', 'Anh văn', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(76, 533, '', 'Tin học', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(76, 534, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-23', '1999-05-23', '', 'Chứng chỉ '),
(76, 535, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(76, 536, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-23', '2015-05-23', 'Tập trung', 'Giấy Chứng nhận'),
(76, 537, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(76, 538, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(76, 539, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-23', '2015-05-23', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(77, 540, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(77, 541, '', 'Anh văn', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(77, 542, '', 'Tin học', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(77, 543, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-23', '1999-05-23', '', 'Chứng chỉ '),
(77, 544, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(77, 545, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-23', '2015-05-23', 'Tập trung', 'Giấy Chứng nhận'),
(77, 546, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(77, 547, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(77, 548, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-23', '2015-05-23', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(78, 549, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(78, 550, '', 'Anh văn', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(78, 551, '', 'Tin học', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(78, 552, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-23', '1999-05-23', '', 'Chứng chỉ '),
(78, 553, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(78, 554, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-23', '2015-05-23', 'Tập trung', 'Giấy Chứng nhận'),
(78, 555, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(78, 556, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(78, 557, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-23', '2015-05-23', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(94, 558, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(94, 559, '', 'Anh văn', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(94, 560, '', 'Tin học', '1999-05-23', '1999-05-23', '', 'Chứng chỉ B'),
(94, 561, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-05-23', '1999-05-23', '', 'Chứng chỉ '),
(94, 562, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(94, 563, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-05-23', '2015-05-23', 'Tập trung', 'Giấy Chứng nhận'),
(94, 564, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(94, 565, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(94, 566, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-05-23', '2015-05-23', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(95, 567, 'Trường Cao dẳng Sư phạm TP. HCM', 'Ngữ văn', '2015-05-23', '2015-05-23', 'Chính quy', 'Cử nhân Cao dẳng'),
(95, 568, 'Trường DH Sư phạm Huế', 'Ngữ văn', '2015-05-23', '2015-05-23', 'Chuyên tu', 'Cử nhân Dại học'),
(96, 569, 'DH Kinh tế TP. HCM', 'Kế toán - Kiểm toán', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân Cao dẳng'),
(96, 570, 'DH Kinh tế TP. HCM', 'Kế toán - Kiểm toán', '1970-01-01', '1970-01-01', 'Hoàn chỉnh', 'Cử nhân Dại học'),
(96, 571, 'Trường Cán bộ Thành phố', 'Trung cấp Lý luận Chính trị ', '1970-01-01', '1970-01-01', 'Tại chức', 'Bằng tốt nghiệp'),
(96, 572, 'Trường Doàn Lý Tự Trọng', 'Trung cấp Lý luận nghiệp vụ công tác Thanh vận', '1970-01-01', '1970-01-01', 'Tại chức', 'Bằng tốt nghiệp'),
(96, 573, 'Trường DH KHXH & NV', 'Chính trị học', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân VB2'),
(97, 574, 'Trường DH Kỹ thuật Công nghệ TP. HCM', 'Quản trị kinh doanh', '1970-01-01', '1970-01-01', 'Chính quy', 'Cử nhân'),
(97, 575, '', 'Anh văn', '1999-06-04', '1999-06-04', '', 'Chứng chỉ B'),
(97, 576, '', 'Tin học', '1999-06-04', '1999-06-04', '', 'Chứng chỉ B'),
(97, 577, 'Dại học Kinh tế', 'Quản trị văn phòng', '1999-06-04', '1999-06-04', '', 'Chứng chỉ '),
(97, 578, 'Trường Doàn Lý Tự Trọng', 'Các lớp bồi dưỡng cán bộ Doàn - Hội', '1970-01-01', '1970-01-01', '', 'Giấy Chứng nhận'),
(97, 579, 'Tổ chức các Bộ trưởng Bộ Giáo dục các nước châu Á SEAMEO tại Thái Lan', 'Công tác tư vấn, hướng nghiệp, hỗ trợ sinh viên', '2015-06-04', '2015-06-04', 'Tập trung', 'Giấy Chứng nhận'),
(97, 580, 'TT nghiên cứu, bồi dưỡng nghiệp vụ công tác tôn giáo - Ban Tôn giáo chính phủ', 'Nghiệp vụ công tác tôn giáo', '2008-09-01', '2008-09-01', 'Tập trung', 'Giấy chứng nhận'),
(97, 581, 'Trường Cán bộ TP', 'Lớp Quản lý Nhà nước về Hội', '2015-11-08', '2015-11-08', 'Tập trung', 'Giấy Chứng nhận'),
(97, 582, 'Trường DH Kinh tế - Luật', 'Cao học Kinh tế chính trị', '2015-06-04', '2015-06-04', 'Tập trung', 'Thạc sĩ Kinh tế Chính trị'),
(98, 583, 'Trường Doàn Lý Tự Trọng', 'Bồi dưỡng nghiệp vụ công tác Doàn', '1998-10-01', '1998-10-01', 'Tập trung', 'Chứng chỉ'),
(98, 584, 'Ban Tôn giáo chính phủ', 'Bồi dưỡng công tác tôn giáo', '2008-08-01', '2008-08-01', 'Tập trung', 'Chứng chỉ'),
(98, 585, 'DH Khoa học Xã hội và Nhân văn', 'Cử nhân Ngữ văn', '2015-06-05', '2015-06-05', 'Chính quy tập trung', 'Bằng Cử nhân'),
(98, 586, 'DH Khoa học Xã hội và Nhân văn', 'Cao học chuyên ngành Văn học nước ngoài', '1970-01-01', '1970-01-01', 'Chính quy tập trung', 'Bằng Thạc sĩ'),
(98, 587, 'Học viện Chính trị Hành chính Quốc gia Hồ Chí Minh (khu vực II)', 'Cao cấp chính trị', '1970-01-01', '1970-01-01', 'Tập trung', 'Bằng Cao cấp lý luận chính trị - Hành chính'),
(99, 588, 'Trường Doàn Lý Tự Trọng', 'Bồi dưỡng nghiệp vụ công tác Doàn', '1998-10-01', '1998-10-01', 'Tập trung', 'Chứng chỉ'),
(99, 589, 'Ban Tôn giáo chính phủ', 'Bồi dưỡng công tác tôn giáo', '2008-08-01', '2008-08-01', 'Tập trung', 'Chứng chỉ'),
(99, 590, 'DH Khoa học Xã hội và Nhân văn', 'Cử nhân Ngữ văn', '2015-06-05', '2015-06-05', 'Chính quy tập trung', 'Bằng Cử nhân'),
(99, 591, 'DH Khoa học Xã hội và Nhân văn', 'Cao học chuyên ngành Văn học nước ngoài', '1970-01-01', '1970-01-01', 'Chính quy tập trung', 'Bằng Thạc sĩ'),
(99, 592, 'Học viện Chính trị Hành chính Quốc gia Hồ Chí Minh (khu vực II)', 'Cao cấp chính trị', '1970-01-01', '1970-01-01', 'Tập trung', 'Bằng Cao cấp lý luận chính trị - Hành chính'),
(100, 593, 'Trường Doàn Lý Tự Trọng', 'Bồi dưỡng nghiệp vụ công tác Doàn', '1998-10-01', '1998-10-01', 'Tập trung', 'Chứng chỉ'),
(100, 594, 'Ban Tôn giáo chính phủ', 'Bồi dưỡng công tác tôn giáo', '2008-08-01', '2008-08-01', 'Tập trung', 'Chứng chỉ'),
(100, 595, 'DH Khoa học Xã hội và Nhân văn', 'Cử nhân Ngữ văn', '2015-06-05', '2015-06-05', 'Chính quy tập trung', 'Bằng Cử nhân'),
(100, 596, 'DH Khoa học Xã hội và Nhân văn', 'Cao học chuyên ngành Văn học nước ngoài', '1970-01-01', '1970-01-01', 'Chính quy tập trung', 'Bằng Thạc sĩ'),
(100, 597, 'Học viện Chính trị Hành chính Quốc gia Hồ Chí Minh (khu vực II)', 'Cao cấp chính trị', '1970-01-01', '1970-01-01', 'Tập trung', 'Bằng Cao cấp lý luận chính trị - Hành chính'),
(101, 598, 'Trường Doàn Lý Tự Trọng', 'Lớp bồi dưỡng kỹ năng, nghiệp vụ thanh niên', '1997-02-25', '1997-03-26', 'Tập trung', 'Giấy chứng nhận'),
(101, 599, 'Trường Lưu trữ và Nghiệp vụ Văn phòng II', 'Bồi dưỡng nghiệp vụ quản lý và diều hành hoạt dộng văn phòng', '1998-10-15', '1998-10-24', 'Tập trung', 'Giấy chứng nhận'),
(101, 600, 'TT Bồi dưỡng chính trị Quận 6', 'Lý luận chính trị', '1996-06-25', '1970-01-01', 'Tập trung', 'Sơ cấp'),
(101, 601, 'DH Luật TP. HCM', 'Luật Dân sự', '2015-06-25', '2015-06-25', 'Tại chức', 'Cử nhân Luật'),
(101, 602, 'Trường Cán bộ TP', 'Lý luận chính trị', '2015-06-07', '2015-12-08', 'Tại chức', 'Trung cấp'),
(102, 603, 'Trường Doàn Lý Tự Trọng', 'Lớp bồi dưỡng kỹ năng, nghiệp vụ thanh niên', '1997-02-25', '1997-03-26', 'Tập trung', 'Giấy chứng nhận'),
(102, 604, 'Trường Lưu trữ và Nghiệp vụ Văn phòng II', 'Bồi dưỡng nghiệp vụ quản lý và diều hành hoạt dộng văn phòng', '1998-10-15', '1998-10-24', 'Tập trung', 'Giấy chứng nhận'),
(102, 605, 'TT Bồi dưỡng chính trị Quận 6', 'Lý luận chính trị', '1996-06-25', '1970-01-01', 'Tập trung', 'Sơ cấp'),
(102, 606, 'DH Luật TP. HCM', 'Luật Dân sự', '2015-06-25', '2015-06-25', 'Tại chức', 'Cử nhân Luật'),
(102, 607, 'Trường Cán bộ TP', 'Lý luận chính trị', '2015-06-07', '2015-12-08', 'Tại chức', 'Trung cấp');

-- --------------------------------------------------------

--
-- Table structure for table `don_vi`
--

CREATE TABLE IF NOT EXISTS `don_vi` (
`Ma_DV` smallint(6) unsigned NOT NULL,
  `Ky_Hieu_DV` varchar(32) NOT NULL,
  `Ten_Don_Vi` varchar(254) DEFAULT NULL,
  `Ma_Khoi` tinyint(3) unsigned DEFAULT NULL,
  `Ma_Truong_DV` int(11) DEFAULT NULL,
  `Ma_Ban_Chap_Hanh` int(11) DEFAULT NULL,
  `Ngay_Thanh_Lap` date DEFAULT NULL,
  `Chuc_Nang_DV` varchar(254) DEFAULT NULL,
  `Dia_Chi` varchar(254) DEFAULT NULL,
  `Email` varchar(126) DEFAULT NULL,
  `So_Dien_Thoai` varchar(62) DEFAULT NULL,
  `Mo_Ta` varchar(254) DEFAULT NULL,
  `Trang_Thai` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `don_vi`
--

INSERT INTO `don_vi` (`Ma_DV`, `Ky_Hieu_DV`, `Ten_Don_Vi`, `Ma_Khoi`, `Ma_Truong_DV`, `Ma_Ban_Chap_Hanh`, `Ngay_Thanh_Lap`, `Chuc_Nang_DV`, `Dia_Chi`, `Email`, `So_Dien_Thoai`, `Mo_Ta`, `Trang_Thai`) VALUES
(0, '', 'Chuyên Trách Thành Doàn', 4, NULL, 18, NULL, NULL, '', '', '+84', '', 1),
(1, 'UIT', 'Trường DH Công nghệ Thông tin', 4, NULL, 20, '2006-06-08', NULL, 'KM20, Xa lộ Hà Nội, phường Linh Trung, quận Thủ Dức, TPHCM', 'info@uit.edu.vn', '+84123456', '<p>M&ocirc; tả cho Trường DH C&ocirc;ng nghệ Th&ocirc;ng tin</p>\r\n', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ban`
--
ALTER TABLE `ban`
 ADD PRIMARY KEY (`Ma_Ban`), ADD KEY `FK_loai_cua_ban` (`Ma_Loai_Ban`), ADD KEY `FK_thuoc_DV` (`Ma_Don_Vi`);

--
-- Indexes for table `can_bo`
--
ALTER TABLE `can_bo`
 ADD PRIMARY KEY (`Ma_Can_Bo`), ADD KEY `FK_co_Chuc_Vu_Chinh` (`Ma_CV_Chinh`), ADD KEY `FK_co_DVCT_Chinh` (`Ma_DVCT_Chinh`);

--
-- Indexes for table `cap_chuc_vu`
--
ALTER TABLE `cap_chuc_vu`
 ADD PRIMARY KEY (`Ma_Cap`);

--
-- Indexes for table `chieu_huong_phat_trien`
--
ALTER TABLE `chieu_huong_phat_trien`
 ADD PRIMARY KEY (`Ma_CHPT`);

--
-- Indexes for table `chuc_vu`
--
ALTER TABLE `chuc_vu`
 ADD PRIMARY KEY (`Ma_Chuc_Vu`), ADD KEY `FK_cap_do_cua_CV` (`Ma_Cap`);

--
-- Indexes for table `cong_tac_nuoc_ngoai`
--
ALTER TABLE `cong_tac_nuoc_ngoai`
 ADD PRIMARY KEY (`Ma_CTNN`,`Ma_CB`), ADD KEY `Ma_CTNN` (`Ma_CTNN`);

--
-- Indexes for table `cong_tac_vien`
--
ALTER TABLE `cong_tac_vien`
 ADD PRIMARY KEY (`Ma_CTV`);

--
-- Indexes for table `controller`
--
ALTER TABLE `controller`
 ADD PRIMARY KEY (`Controller_Name`), ADD KEY `FK_of_module` (`Module_Name`);

--
-- Indexes for table `dan_toc`
--
ALTER TABLE `dan_toc`
 ADD PRIMARY KEY (`Ma_Dan_Toc`);

--
-- Indexes for table `dien_khen_thuong`
--
ALTER TABLE `dien_khen_thuong`
 ADD PRIMARY KEY (`Ma_Dien`);

--
-- Indexes for table `hop_dong_cong_tac`
--
ALTER TABLE `hop_dong_cong_tac`
 ADD PRIMARY KEY (`Ma_Ban`,`Ma_CTV`,`Ngay_Bat_Dau`), ADD KEY `FK_CTV_Hop_Dong` (`Ma_CTV`);

--
-- Indexes for table `khen_thuong`
--
ALTER TABLE `khen_thuong`
 ADD PRIMARY KEY (`Ma_Khen_Thuong`,`Ma_CB`), ADD KEY `FK_thuoc_dien` (`Ma_Dien`), ADD KEY `FK_thuoc_kq_xet` (`Ma_DS_Khen_Thuong`), ADD KEY `Ma_CB` (`Ma_CB`);

--
-- Indexes for table `khoi`
--
ALTER TABLE `khoi`
 ADD PRIMARY KEY (`Ma_Khoi`), ADD KEY `FK_khoi_cap_tren_truc_thuoc` (`Ma_Khoi_Cap_Tren`);

--
-- Indexes for table `kien_nghi`
--
ALTER TABLE `kien_nghi`
 ADD PRIMARY KEY (`Thoi_Gian`,`Ma_CB_Kien_Nghi`), ADD KEY `FK_duoc_can_bo_yeu_cau` (`Ma_CB_Kien_Nghi`), ADD KEY `Trang_Thai` (`Trang_Thai`), ADD KEY `Thoi_Gian` (`Thoi_Gian`), ADD KEY `FK_co_CB_kiennghi` (`Ma_CB_Kien_Nghi`);

--
-- Indexes for table `kieu_loai_hinh_ban`
--
ALTER TABLE `kieu_loai_hinh_ban`
 ADD PRIMARY KEY (`Ma_KLHB`);

--
-- Indexes for table `kq_xet_thi_dua`
--
ALTER TABLE `kq_xet_thi_dua`
 ADD PRIMARY KEY (`Ma_DS_Khen_Thuong`);

--
-- Indexes for table `ky_luat`
--
ALTER TABLE `ky_luat`
 ADD PRIMARY KEY (`Ma_Ky_Luat`,`Ma_CB`), ADD KEY `FK_ky_luat_cua_can_bo` (`Ma_CB`), ADD KEY `Ma_CB` (`Ma_CB`);

--
-- Indexes for table `loai_hinh_ban`
--
ALTER TABLE `loai_hinh_ban`
 ADD PRIMARY KEY (`Ma_Loai_Ban`), ADD KEY `FK_co_KieuLHB` (`Ma_Kieu_Loai_Hinh`);

--
-- Indexes for table `ly_lich`
--
ALTER TABLE `ly_lich`
 ADD PRIMARY KEY (`Ma_CB`), ADD KEY `FK_co_TD_HV` (`Cap_Do_TDCM`), ADD KEY `FK_co_TD_LLCT` (`Cap_Do_CTLL`), ADD KEY `FK_co_Dan_Toc` (`Dan_Toc`), ADD KEY `FK_co_Ton_Giao` (`Ton_Giao`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
 ADD PRIMARY KEY (`Module_Name`);

--
-- Indexes for table `muc_sua_doi`
--
ALTER TABLE `muc_sua_doi`
 ADD PRIMARY KEY (`Ma_Yeu_Cau`,`Ten_Cot_Thay_Doi`);

--
-- Indexes for table `muc_thuong_theo_dien`
--
ALTER TABLE `muc_thuong_theo_dien`
 ADD PRIMARY KEY (`Ma_Dien`,`Ma_DS_Khen_Thuong`), ADD KEY `FK_kq_xet` (`Ma_DS_Khen_Thuong`);

--
-- Indexes for table `muc_do_hoan_thanh`
--
ALTER TABLE `muc_do_hoan_thanh`
 ADD PRIMARY KEY (`Ma_MDHT`);

--
-- Indexes for table `ngach_luong`
--
ALTER TABLE `ngach_luong`
 ADD PRIMARY KEY (`Ma_So_Ngach`);

--
-- Indexes for table `ngoai_ngu`
--
ALTER TABLE `ngoai_ngu`
 ADD PRIMARY KEY (`Ma_Ngoai_Ngu`);

--
-- Indexes for table `privilege`
--
ALTER TABLE `privilege`
 ADD PRIMARY KEY (`Privilege_Name`), ADD KEY `FK_of_controller` (`Controller_Name`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
 ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `qua_trinh_cong_tac`
--
ALTER TABLE `qua_trinh_cong_tac`
 ADD PRIMARY KEY (`Ma_QTCT`,`Ma_CB`), ADD KEY `Ma_CB` (`Ma_CB`);

--
-- Indexes for table `qua_trinh_luong`
--
ALTER TABLE `qua_trinh_luong`
 ADD PRIMARY KEY (`Ma_CB`,`Thoi_Gian_Nang_Luong`), ADD KEY `FK_co_Ngach` (`Ma_So_Ngach`), ADD KEY `INDEX_NgayNangLuong` (`Thoi_Gian_Nang_Luong`), ADD KEY `INDEX_MaCanBO` (`Ma_CB`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
 ADD PRIMARY KEY (`Role_Name`);

--
-- Indexes for table `role_privilege_relation`
--
ALTER TABLE `role_privilege_relation`
 ADD PRIMARY KEY (`Role_Name`,`Privilege_Name`), ADD KEY `FK_for_role` (`Privilege_Name`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
 ADD PRIMARY KEY (`Status_Code`);

--
-- Indexes for table `thanh_vien_gia_dinh`
--
ALTER TABLE `thanh_vien_gia_dinh`
 ADD PRIMARY KEY (`Ma_Quan_He`,`Ma_CB`), ADD KEY `Ben_Vo` (`Ben_Vo`), ADD KEY `Ma_CB` (`Ma_CB`), ADD KEY `Ma_Quan_He` (`Ma_Quan_He`);

--
-- Indexes for table `thong_tin_tham_gia_ban`
--
ALTER TABLE `thong_tin_tham_gia_ban`
 ADD PRIMARY KEY (`Ma_CB`,`Ma_Ban`,`Ngay_Gia_Nhap`), ADD KEY `FK_cv_tai_ban` (`Ma_CV`), ADD KEY `FK_to_cong_tac_cua_CB_tai_ban` (`Ma_Ban`,`STT_To`), ADD KEY `La_Cong_Tac_Chinh` (`La_Cong_Tac_Chinh`), ADD KEY `Ngay_Roi_Khoi` (`Ngay_Roi_Khoi`), ADD KEY `Ma_Ban` (`Ma_Ban`), ADD KEY `Ngay_Gia_Nhap` (`Ngay_Gia_Nhap`), ADD KEY `Ma_Ban__NgayRK` (`Ma_Ban`,`Ngay_Roi_Khoi`), ADD KEY `Ma_CB___NgayRK__Ma_CV` (`Ma_CB`,`Ngay_Roi_Khoi`,`Ma_CV`), ADD KEY `Trang_Thai` (`Trang_Thai`);

--
-- Indexes for table `ton_giao`
--
ALTER TABLE `ton_giao`
 ADD PRIMARY KEY (`Ma_Ton_Giao`);

--
-- Indexes for table `to_cong_tac`
--
ALTER TABLE `to_cong_tac`
 ADD PRIMARY KEY (`Ma_Ban`,`STT_To`);

--
-- Indexes for table `trinh_do_chuyen_mon`
--
ALTER TABLE `trinh_do_chuyen_mon`
 ADD PRIMARY KEY (`Cap_Do_TDCM`);

--
-- Indexes for table `trinh_do_ly_luan_chinh_tri`
--
ALTER TABLE `trinh_do_ly_luan_chinh_tri`
 ADD PRIMARY KEY (`Cap_Do_LLCT`), ADD KEY `cap_do_lltt` (`Cap_Do_LLCT`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`UserID`), ADD UNIQUE KEY `Username` (`Username`), ADD KEY `FK_have_role` (`Role_Name`), ADD KEY `FK_have_status` (`Status_Code`), ADD KEY `Identifier_Info` (`Identifier_Info`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
 ADD PRIMARY KEY (`Thoi_Gian`,`Ma_User_Thuc_Hien`);

--
-- Indexes for table `yeu_cau_thay_doi_tt_cb`
--
ALTER TABLE `yeu_cau_thay_doi_tt_cb`
 ADD PRIMARY KEY (`Ma_Yeu_Cau`), ADD KEY `FK_Anh_Huong_Can_bo` (`Ma_CB_Anh_Huong`), ADD KEY `FK_duoc_can_bo_yeu_cau` (`Ma_CB_Yeu_Cau`);

--
-- Indexes for table `dac_diem_lich_su`
--
ALTER TABLE `dac_diem_lich_su`
 ADD PRIMARY KEY (`Ma_DDLS`,`Ma_CB`), ADD KEY `FK_cua_Can_Bo_1` (`Ma_CB`);

--
-- Indexes for table `danh_gia_can_bo`
--
ALTER TABLE `danh_gia_can_bo`
 ADD PRIMARY KEY (`Ma_CB_Tu_Danh_Gia`,`Ngay_Danh_Gia`), ADD KEY `FK_Ban_muon_den` (`Ma_Ban_Muon_Den`), ADD KEY `FK_Can_Bo_danh_gia` (`Ma_CB_Danh_Gia`), ADD KEY `FK_chieu_huong_phat_trien_cua_CB` (`Ma_MDHT`), ADD KEY `FK_chieu_huong_phat_trien_cua_CB_tu_danh_gia` (`Ma_CHPT`), ADD KEY `FK_muc_do_hoan_thanh_cua_CB` (`Ma_MDHT_Tu_Danh_Gia`), ADD KEY `FK_DV_MuonDen` (`Ma_DV_Muon_Den`);

--
-- Indexes for table `dao_tao_boi_duong`
--
ALTER TABLE `dao_tao_boi_duong`
 ADD PRIMARY KEY (`Ma_DTBD`,`Ma_CB`), ADD KEY `Ma_CB` (`Ma_CB`);

--
-- Indexes for table `don_vi`
--
ALTER TABLE `don_vi`
 ADD PRIMARY KEY (`Ma_DV`), ADD KEY `FK_Co_Ban_Chap_Hanh` (`Ma_Ban_Chap_Hanh`), ADD KEY `FK_co_Truong_Don_Vi` (`Ma_Truong_DV`), ADD KEY `FK_khoi_truc_thuoc` (`Ma_Khoi`), ADD KEY `Ma_Don_Vi` (`Ky_Hieu_DV`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ban`
--
ALTER TABLE `ban`
MODIFY `Ma_Ban` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `can_bo`
--
ALTER TABLE `can_bo`
MODIFY `Ma_Can_Bo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `cap_chuc_vu`
--
ALTER TABLE `cap_chuc_vu`
MODIFY `Ma_Cap` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `chieu_huong_phat_trien`
--
ALTER TABLE `chieu_huong_phat_trien`
MODIFY `Ma_CHPT` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `chuc_vu`
--
ALTER TABLE `chuc_vu`
MODIFY `Ma_Chuc_Vu` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `cong_tac_nuoc_ngoai`
--
ALTER TABLE `cong_tac_nuoc_ngoai`
MODIFY `Ma_CTNN` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `cong_tac_vien`
--
ALTER TABLE `cong_tac_vien`
MODIFY `Ma_CTV` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dan_toc`
--
ALTER TABLE `dan_toc`
MODIFY `Ma_Dan_Toc` smallint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `dien_khen_thuong`
--
ALTER TABLE `dien_khen_thuong`
MODIFY `Ma_Dien` smallint(6) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `khen_thuong`
--
ALTER TABLE `khen_thuong`
MODIFY `Ma_Khen_Thuong` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=617;
--
-- AUTO_INCREMENT for table `khoi`
--
ALTER TABLE `khoi`
MODIFY `Ma_Khoi` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `kq_xet_thi_dua`
--
ALTER TABLE `kq_xet_thi_dua`
MODIFY `Ma_DS_Khen_Thuong` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ky_luat`
--
ALTER TABLE `ky_luat`
MODIFY `Ma_Ky_Luat` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=130;
--
-- AUTO_INCREMENT for table `loai_hinh_ban`
--
ALTER TABLE `loai_hinh_ban`
MODIFY `Ma_Loai_Ban` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `muc_do_hoan_thanh`
--
ALTER TABLE `muc_do_hoan_thanh`
MODIFY `Ma_MDHT` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `ngoai_ngu`
--
ALTER TABLE `ngoai_ngu`
MODIFY `Ma_Ngoai_Ngu` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `qua_trinh_cong_tac`
--
ALTER TABLE `qua_trinh_cong_tac`
MODIFY `Ma_QTCT` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=615;
--
-- AUTO_INCREMENT for table `thanh_vien_gia_dinh`
--
ALTER TABLE `thanh_vien_gia_dinh`
MODIFY `Ma_Quan_He` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=634;
--
-- AUTO_INCREMENT for table `ton_giao`
--
ALTER TABLE `ton_giao`
MODIFY `Ma_Ton_Giao` smallint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=108;
--
-- AUTO_INCREMENT for table `yeu_cau_thay_doi_tt_cb`
--
ALTER TABLE `yeu_cau_thay_doi_tt_cb`
MODIFY `Ma_Yeu_Cau` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dao_tao_boi_duong`
--
ALTER TABLE `dao_tao_boi_duong`
MODIFY `Ma_DTBD` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=608;
--
-- AUTO_INCREMENT for table `don_vi`
--
ALTER TABLE `don_vi`
MODIFY `Ma_DV` smallint(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `ban`
--
ALTER TABLE `ban`
ADD CONSTRAINT `FK_loai_cua_ban` FOREIGN KEY (`Ma_Loai_Ban`) REFERENCES `loai_hinh_ban` (`Ma_Loai_Ban`),
ADD CONSTRAINT `FK_thuoc_Don_Vi` FOREIGN KEY (`Ma_Don_Vi`) REFERENCES `don_vi` (`Ma_DV`);

--
-- Constraints for table `can_bo`
--
ALTER TABLE `can_bo`
ADD CONSTRAINT `FK_co_Chuc_Vu_Chinh` FOREIGN KEY (`Ma_CV_Chinh`) REFERENCES `chuc_vu` (`Ma_Chuc_Vu`),
ADD CONSTRAINT `FK_thuoc_DonViChinh` FOREIGN KEY (`Ma_DVCT_Chinh`) REFERENCES `don_vi` (`Ma_DV`);

--
-- Constraints for table `chuc_vu`
--
ALTER TABLE `chuc_vu`
ADD CONSTRAINT `FK_cap_do_cua_CV` FOREIGN KEY (`Ma_Cap`) REFERENCES `cap_chuc_vu` (`Ma_Cap`);

--
-- Constraints for table `controller`
--
ALTER TABLE `controller`
ADD CONSTRAINT `FK_of_module` FOREIGN KEY (`Module_Name`) REFERENCES `module` (`Module_Name`);

--
-- Constraints for table `hop_dong_cong_tac`
--
ALTER TABLE `hop_dong_cong_tac`
ADD CONSTRAINT `FK_Ban_Hop_Dong` FOREIGN KEY (`Ma_Ban`) REFERENCES `ban` (`Ma_Ban`),
ADD CONSTRAINT `FK_CTV_Hop_Dong` FOREIGN KEY (`Ma_CTV`) REFERENCES `cong_tac_vien` (`Ma_CTV`);

--
-- Constraints for table `khen_thuong`
--
ALTER TABLE `khen_thuong`
ADD CONSTRAINT `FK_khen_thuong_can_bo` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_thuoc_dien` FOREIGN KEY (`Ma_Dien`) REFERENCES `dien_khen_thuong` (`Ma_Dien`),
ADD CONSTRAINT `khen_thuong_ibfk_1` FOREIGN KEY (`Ma_DS_Khen_Thuong`) REFERENCES `kq_xet_thi_dua` (`Ma_DS_Khen_Thuong`);

--
-- Constraints for table `khoi`
--
ALTER TABLE `khoi`
ADD CONSTRAINT `FK_khoi_cap_tren_truc_thuoc` FOREIGN KEY (`Ma_Khoi_Cap_Tren`) REFERENCES `khoi` (`Ma_Khoi`);

--
-- Constraints for table `kien_nghi`
--
ALTER TABLE `kien_nghi`
ADD CONSTRAINT `FK_co_CB_kiennghi` FOREIGN KEY (`Ma_CB_Kien_Nghi`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `ky_luat`
--
ALTER TABLE `ky_luat`
ADD CONSTRAINT `FK_ky_luat_cua_can_bo` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `loai_hinh_ban`
--
ALTER TABLE `loai_hinh_ban`
ADD CONSTRAINT `FK_co_KieuLHB` FOREIGN KEY (`Ma_Kieu_Loai_Hinh`) REFERENCES `kieu_loai_hinh_ban` (`Ma_KLHB`);

--
-- Constraints for table `ly_lich`
--
ALTER TABLE `ly_lich`
ADD CONSTRAINT `FK_co_Dan_Toc` FOREIGN KEY (`Dan_Toc`) REFERENCES `dan_toc` (`Ma_Dan_Toc`),
ADD CONSTRAINT `FK_co_Ly_Lich` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_co_Ton_Giao` FOREIGN KEY (`Ton_Giao`) REFERENCES `ton_giao` (`Ma_Ton_Giao`),
ADD CONSTRAINT `FK_co_TD_HV` FOREIGN KEY (`Cap_Do_TDCM`) REFERENCES `trinh_do_chuyen_mon` (`Cap_Do_TDCM`),
ADD CONSTRAINT `FK_co_TD_LLCT` FOREIGN KEY (`Cap_Do_CTLL`) REFERENCES `trinh_do_ly_luan_chinh_tri` (`Cap_Do_LLCT`);

--
-- Constraints for table `muc_sua_doi`
--
ALTER TABLE `muc_sua_doi`
ADD CONSTRAINT `FK_muc_thay_doi_cua_yeu_cau` FOREIGN KEY (`Ma_Yeu_Cau`) REFERENCES `yeu_cau_thay_doi_tt_cb` (`Ma_Yeu_Cau`);

--
-- Constraints for table `muc_thuong_theo_dien`
--
ALTER TABLE `muc_thuong_theo_dien`
ADD CONSTRAINT `FK_dien_nhan_thuong` FOREIGN KEY (`Ma_Dien`) REFERENCES `dien_khen_thuong` (`Ma_Dien`),
ADD CONSTRAINT `FK_kq_xet` FOREIGN KEY (`Ma_DS_Khen_Thuong`) REFERENCES `kq_xet_thi_dua` (`Ma_DS_Khen_Thuong`);

--
-- Constraints for table `privilege`
--
ALTER TABLE `privilege`
ADD CONSTRAINT `FK_of_controller` FOREIGN KEY (`Controller_Name`) REFERENCES `controller` (`Controller_Name`);

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
ADD CONSTRAINT `FK_of_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `qua_trinh_cong_tac`
--
ALTER TABLE `qua_trinh_cong_tac`
ADD CONSTRAINT `qua_trinh_cong_tac_ibfk_1` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `qua_trinh_luong`
--
ALTER TABLE `qua_trinh_luong`
ADD CONSTRAINT `FK_co_Ngach` FOREIGN KEY (`Ma_So_Ngach`) REFERENCES `ngach_luong` (`Ma_So_Ngach`),
ADD CONSTRAINT `FK_luong_cua_can_bo` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `role_privilege_relation`
--
ALTER TABLE `role_privilege_relation`
ADD CONSTRAINT `FK_for_role` FOREIGN KEY (`Privilege_Name`) REFERENCES `privilege` (`Privilege_Name`),
ADD CONSTRAINT `FK_have_privilege` FOREIGN KEY (`Role_Name`) REFERENCES `role` (`Role_Name`);

--
-- Constraints for table `thanh_vien_gia_dinh`
--
ALTER TABLE `thanh_vien_gia_dinh`
ADD CONSTRAINT `FK_cua_can_bo` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `thong_tin_tham_gia_ban`
--
ALTER TABLE `thong_tin_tham_gia_ban`
ADD CONSTRAINT `FK_Ban_Tham_Gia` FOREIGN KEY (`Ma_Ban`) REFERENCES `ban` (`Ma_Ban`),
ADD CONSTRAINT `FK_Can_Bo_Tai_Ban` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_cv_tai_ban` FOREIGN KEY (`Ma_CV`) REFERENCES `chuc_vu` (`Ma_Chuc_Vu`),
ADD CONSTRAINT `FK_to_cong_tac_cua_CB_tai_ban` FOREIGN KEY (`Ma_Ban`, `STT_To`) REFERENCES `to_cong_tac` (`Ma_Ban`, `STT_To`);

--
-- Constraints for table `to_cong_tac`
--
ALTER TABLE `to_cong_tac`
ADD CONSTRAINT `FK_ban_truc_thuoc` FOREIGN KEY (`Ma_Ban`) REFERENCES `ban` (`Ma_Ban`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
ADD CONSTRAINT `FK_have_role` FOREIGN KEY (`Role_Name`) REFERENCES `role` (`Role_Name`),
ADD CONSTRAINT `FK_have_status` FOREIGN KEY (`Status_Code`) REFERENCES `status` (`Status_Code`);

--
-- Constraints for table `yeu_cau_thay_doi_tt_cb`
--
ALTER TABLE `yeu_cau_thay_doi_tt_cb`
ADD CONSTRAINT `FK_Anh_Huong_Can_bo` FOREIGN KEY (`Ma_CB_Anh_Huong`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_duoc_can_bo_yeu_cau` FOREIGN KEY (`Ma_CB_Yeu_Cau`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `dac_diem_lich_su`
--
ALTER TABLE `dac_diem_lich_su`
ADD CONSTRAINT `FK_cua_Can_Bo_1` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `danh_gia_can_bo`
--
ALTER TABLE `danh_gia_can_bo`
ADD CONSTRAINT `FK_Ban_muon_den` FOREIGN KEY (`Ma_Ban_Muon_Den`) REFERENCES `ban` (`Ma_Ban`),
ADD CONSTRAINT `FK_Can_Bo_danh_gia` FOREIGN KEY (`Ma_CB_Danh_Gia`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_chieu_huong_phat_trien_cua_CB` FOREIGN KEY (`Ma_MDHT`) REFERENCES `muc_do_hoan_thanh` (`Ma_MDHT`),
ADD CONSTRAINT `FK_chieu_huong_phat_trien_cua_CB_tu_danh_gia` FOREIGN KEY (`Ma_CHPT`) REFERENCES `chieu_huong_phat_trien` (`Ma_CHPT`),
ADD CONSTRAINT `FK_co_KQKT` FOREIGN KEY (`Ma_CB_Tu_Danh_Gia`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_donvi_muonden` FOREIGN KEY (`Ma_DV_Muon_Den`) REFERENCES `don_vi` (`Ma_DV`),
ADD CONSTRAINT `FK_muc_do_hoan_thanh_cua_CB` FOREIGN KEY (`Ma_MDHT_Tu_Danh_Gia`) REFERENCES `muc_do_hoan_thanh` (`Ma_MDHT`);

--
-- Constraints for table `dao_tao_boi_duong`
--
ALTER TABLE `dao_tao_boi_duong`
ADD CONSTRAINT `FK_DTBD_cua_Can_Bo` FOREIGN KEY (`Ma_CB`) REFERENCES `can_bo` (`Ma_Can_Bo`);

--
-- Constraints for table `don_vi`
--
ALTER TABLE `don_vi`
ADD CONSTRAINT `FK_Co_Ban_Chap_Hanh` FOREIGN KEY (`Ma_Ban_Chap_Hanh`) REFERENCES `ban` (`Ma_Ban`),
ADD CONSTRAINT `FK_co_Truong_Don_Vi` FOREIGN KEY (`Ma_Truong_DV`) REFERENCES `can_bo` (`Ma_Can_Bo`),
ADD CONSTRAINT `FK_khoi_truc_thuoc` FOREIGN KEY (`Ma_Khoi`) REFERENCES `khoi` (`Ma_Khoi`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
