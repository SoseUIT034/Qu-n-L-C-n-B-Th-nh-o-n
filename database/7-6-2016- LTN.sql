CREATE DATABASE  IF NOT EXISTS `qlcb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `qlcb`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: qlcb
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `MaBan` int(11) NOT NULL,
  `MaDonVi` int(11) NOT NULL,
  `TenBan` varchar(45) NOT NULL,
  `NgayThanhLap` date NOT NULL,
  `MaTruongBan` int(11) DEFAULT NULL,
  PRIMARY KEY (`MaBan`),
  KEY `fk_ban_donvi1_idx` (`MaDonVi`),
  CONSTRAINT `FK8yo9aho1mfb37nwxpe31jgox4` FOREIGN KEY (`MaDonVi`) REFERENCES `donvi` (`MaDonVi`),
  CONSTRAINT `fk_ban_donvi1` FOREIGN KEY (`MaDonVi`) REFERENCES `donvi` (`MaDonVi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban`
--

LOCK TABLES `ban` WRITE;
/*!40000 ALTER TABLE `ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canbo`
--

DROP TABLE IF EXISTS `canbo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canbo` (
  `MaCanBo` int(11) NOT NULL,
  `TrangThai` bit(1) DEFAULT NULL,
  PRIMARY KEY (`MaCanBo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canbo`
--

LOCK TABLES `canbo` WRITE;
/*!40000 ALTER TABLE `canbo` DISABLE KEYS */;
INSERT INTO `canbo` VALUES (0,''),(1,''),(2,''),(3,''),(4,''),(5,''),(6,''),(7,''),(8,''),(9,'');
/*!40000 ALTER TABLE `canbo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canbo_ban`
--

DROP TABLE IF EXISTS `canbo_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canbo_ban` (
  `IDBan` int(11) NOT NULL,
  `IDCanBo` int(11) NOT NULL,
  `ChucVu` int(11) NOT NULL,
  PRIMARY KEY (`IDBan`,`IDCanBo`),
  KEY `fk_Ban_has_CanBo_Ban_idx` (`IDBan`),
  KEY `FK8cwwrrglip8fe0nwpiw1hk1ns` (`IDCanBo`),
  KEY `FKy72mwvyixqy9tnumxqnesraw` (`ChucVu`),
  CONSTRAINT `FK2ule3fuhtq8sxmeqllhh0s5wr` FOREIGN KEY (`IDBan`) REFERENCES `ban` (`MaBan`),
  CONSTRAINT `FK8cwwrrglip8fe0nwpiw1hk1ns` FOREIGN KEY (`IDCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `FKy72mwvyixqy9tnumxqnesraw` FOREIGN KEY (`ChucVu`) REFERENCES `chucvuban` (`MaChucVu`),
  CONSTRAINT `fk_Ban_has_CanBo_Ban` FOREIGN KEY (`IDBan`) REFERENCES `ban` (`MaBan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ban_has_CanBo_CanBo1` FOREIGN KEY (`IDCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CanBo_Ban_ChucVuBan1` FOREIGN KEY (`ChucVu`) REFERENCES `chucvuban` (`MaChucVu`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canbo_ban`
--

LOCK TABLES `canbo_ban` WRITE;
/*!40000 ALTER TABLE `canbo_ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `canbo_ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canbo_donvi`
--

DROP TABLE IF EXISTS `canbo_donvi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canbo_donvi` (
  `MaCanBo` int(11) NOT NULL,
  `MaDonVi` int(11) NOT NULL,
  `ChucVu` int(11) NOT NULL,
  PRIMARY KEY (`MaCanBo`,`MaDonVi`),
  KEY `fk_CanBo_has_DonVi_CanBo1_idx` (`MaCanBo`),
  KEY `FKpay2y18bwyw8drpebnhr043fg` (`ChucVu`),
  KEY `FKlq1vlohs5dfvy9oyc9wiargxe` (`MaDonVi`),
  CONSTRAINT `FKlq1vlohs5dfvy9oyc9wiargxe` FOREIGN KEY (`MaDonVi`) REFERENCES `donvi` (`MaDonVi`),
  CONSTRAINT `FKpay2y18bwyw8drpebnhr043fg` FOREIGN KEY (`ChucVu`) REFERENCES `chucvudonvi` (`MaChucVu`),
  CONSTRAINT `FKrddgsexljss3o6pe5prkn76fh` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_CanBo_DonVi_ChucVuDonVi1` FOREIGN KEY (`ChucVu`) REFERENCES `chucvudonvi` (`MaChucVu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CanBo_has_DonVi_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CanBo_has_DonVi_DonVi1` FOREIGN KEY (`MaDonVi`) REFERENCES `donvi` (`MaDonVi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canbo_donvi`
--

LOCK TABLES `canbo_donvi` WRITE;
/*!40000 ALTER TABLE `canbo_donvi` DISABLE KEYS */;
/*!40000 ALTER TABLE `canbo_donvi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canbo_giadinh_banthan`
--

DROP TABLE IF EXISTS `canbo_giadinh_banthan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canbo_giadinh_banthan` (
  `ID` int(11) NOT NULL,
  `MaThanhVienGiaDinh` int(11) DEFAULT NULL,
  `MaCanBo` int(11) DEFAULT NULL,
  `QuanHe` varchar(505) DEFAULT NULL,
  `HoTen` varchar(45) DEFAULT NULL,
  `NgaySinh` varchar(45) DEFAULT NULL,
  `GhiChu` text,
  PRIMARY KEY (`ID`),
  KEY `fk_ThanhVienGiaDinh_has_CanBo_ThanhVienGiaDinh1_idx` (`MaThanhVienGiaDinh`),
  KEY `FKewubim8m2dkfb4ke00eh3u0om` (`MaCanBo`),
  CONSTRAINT `FKewubim8m2dkfb4ke00eh3u0om` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_ThanhVienGiaDinh_has_CanBo_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canbo_giadinh_banthan`
--

LOCK TABLES `canbo_giadinh_banthan` WRITE;
/*!40000 ALTER TABLE `canbo_giadinh_banthan` DISABLE KEYS */;
INSERT INTO `canbo_giadinh_banthan` VALUES (0,NULL,5,'sdf','sdf','06/07/2016','r'),(1,NULL,4,'asd','asd','06/07/2016','asd'),(2,NULL,4,'asd','asd','06/01/2016','asdasd'),(4,NULL,5,'d','s','06/14/2016','r'),(5,NULL,8,'1','1','06/06/2016','1'),(6,NULL,8,'2','2','06/06/2016','2'),(7,NULL,8,'3','3','06/06/2016','4'),(8,NULL,8,'','','',''),(9,NULL,9,'9','9','06/01/2016','9'),(10,NULL,9,'999','999','06/22/2016','999'),(11,NULL,9,'99','99','06/15/2016','99');
/*!40000 ALTER TABLE `canbo_giadinh_banthan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canbo_giadinh_doitac`
--

DROP TABLE IF EXISTS `canbo_giadinh_doitac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canbo_giadinh_doitac` (
  `ID` int(11) NOT NULL,
  `MaCanBo` int(11) DEFAULT NULL,
  `MaThanhVienGiaDinh` int(11) NOT NULL,
  `QuanHe` varchar(455) DEFAULT NULL,
  `HoTen` varchar(45) DEFAULT NULL,
  `NgaySinh` varchar(45) DEFAULT NULL,
  `GhiChu` text,
  PRIMARY KEY (`ID`),
  KEY `fk_canbo_giadinh_doitac_canbo1_idx` (`MaCanBo`),
  CONSTRAINT `FK17hoolqerb7bp6murc7154v5p` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_canbo_giadinh_doitac_canbo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canbo_giadinh_doitac`
--

LOCK TABLES `canbo_giadinh_doitac` WRITE;
/*!40000 ALTER TABLE `canbo_giadinh_doitac` DISABLE KEYS */;
INSERT INTO `canbo_giadinh_doitac` VALUES (0,5,0,'ád','ád','06/06/2016','11'),(3,4,0,'sd','asd','06/07/2016','asd'),(4,4,0,'asd','asd','06/08/2016','asd'),(5,5,0,'ád','asd','06/08/2016','11'),(6,8,0,'1','1','06/08/2016','21'),(7,8,0,'3','3','06/14/2016','123'),(8,9,0,'9','9','06/06/2016','9'),(9,9,0,'999','999','06/20/2016','999'),(10,9,0,'99','99','06/21/2016','99');
/*!40000 ALTER TABLE `canbo_giadinh_doitac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chucvuban`
--

DROP TABLE IF EXISTS `chucvuban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chucvuban` (
  `MaChucVu` int(11) NOT NULL,
  `TenChucVu` varchar(200) NOT NULL,
  PRIMARY KEY (`MaChucVu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chucvuban`
--

LOCK TABLES `chucvuban` WRITE;
/*!40000 ALTER TABLE `chucvuban` DISABLE KEYS */;
/*!40000 ALTER TABLE `chucvuban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chucvudonvi`
--

DROP TABLE IF EXISTS `chucvudonvi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chucvudonvi` (
  `MaChucVu` int(11) NOT NULL,
  `TenChucVu` varchar(200) NOT NULL,
  PRIMARY KEY (`MaChucVu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chucvudonvi`
--

LOCK TABLES `chucvudonvi` WRITE;
/*!40000 ALTER TABLE `chucvudonvi` DISABLE KEYS */;
/*!40000 ALTER TABLE `chucvudonvi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chuyencongtac`
--

DROP TABLE IF EXISTS `chuyencongtac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chuyencongtac` (
  `MaChuyenCongTac` int(11) NOT NULL,
  `MaCanBoDuocChuyen` int(11) NOT NULL,
  `MaNoiCongTacHienTai` int(11) NOT NULL,
  `MaNoiCongTacChuyenToi` int(11) NOT NULL,
  `NgayChuyen` date NOT NULL,
  `NguoiXacNhan` int(11) DEFAULT NULL,
  `DaXacNhan` bit(1) NOT NULL,
  `LyDoChuyen` text,
  PRIMARY KEY (`MaChuyenCongTac`),
  KEY `FKfsiau6eie7cl9p30q9ao5m5ys` (`MaCanBoDuocChuyen`),
  KEY `FK5nlvxps3wumbukw4edmut3q0a` (`NguoiXacNhan`),
  CONSTRAINT `FK5nlvxps3wumbukw4edmut3q0a` FOREIGN KEY (`NguoiXacNhan`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `FKfsiau6eie7cl9p30q9ao5m5ys` FOREIGN KEY (`MaCanBoDuocChuyen`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_ChuyenCongTac_CanBo1` FOREIGN KEY (`MaCanBoDuocChuyen`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ChuyenCongTac_CanBo2` FOREIGN KEY (`NguoiXacNhan`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuyencongtac`
--

LOCK TABLES `chuyencongtac` WRITE;
/*!40000 ALTER TABLE `chuyencongtac` DISABLE KEYS */;
/*!40000 ALTER TABLE `chuyencongtac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `congtacnuocngoai`
--

DROP TABLE IF EXISTS `congtacnuocngoai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `congtacnuocngoai` (
  `MaCTNN` int(11) NOT NULL,
  `MaCanBo` int(11) NOT NULL,
  `TuNgay` date DEFAULT NULL,
  `ToiNgay` date DEFAULT NULL,
  `DiaDiem` varchar(200) DEFAULT NULL,
  `NoiDung` varchar(2000) DEFAULT NULL,
  `KinhPhi` double DEFAULT NULL,
  PRIMARY KEY (`MaCTNN`),
  KEY `FK9ot0um4r957ckoo3xx40w7gf5` (`MaCanBo`),
  CONSTRAINT `FK9ot0um4r957ckoo3xx40w7gf5` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_CongTacNuocNgoai_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `congtacnuocngoai`
--

LOCK TABLES `congtacnuocngoai` WRITE;
/*!40000 ALTER TABLE `congtacnuocngoai` DISABLE KEYS */;
/*!40000 ALTER TABLE `congtacnuocngoai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dacdienlichsubanthan`
--

DROP TABLE IF EXISTS `dacdienlichsubanthan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dacdienlichsubanthan` (
  `MaDDLS` int(11) NOT NULL,
  `MaCanBo` int(11) NOT NULL,
  `Noidung1` text,
  `Noidung2` text,
  `NoiDung3` text,
  `Ghichu` text,
  PRIMARY KEY (`MaDDLS`),
  KEY `FKd0smb6jxm6yc43832ckho943l` (`MaCanBo`),
  CONSTRAINT `FKd0smb6jxm6yc43832ckho943l` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_KyLuat_CanBo11` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dacdienlichsubanthan`
--

LOCK TABLES `dacdienlichsubanthan` WRITE;
/*!40000 ALTER TABLE `dacdienlichsubanthan` DISABLE KEYS */;
INSERT INTO `dacdienlichsubanthan` VALUES (0,0,'','','',NULL),(1,1,'','','',NULL),(2,2,NULL,NULL,NULL,NULL),(3,3,'','','',NULL),(4,4,'hai rõ: Bị bắt, bị tù (từ ngày thángn ăm nào đến ngày tháng năm nào, ở đâu), đã khai báo cho ai, những vấn đề gì? Bản thân có làm việc tỏng chế độ cũ(cơ quan, đơn vị nào, địa điểm, chức danh, chức vụ, thời gian làm việc...)','ham gia hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)\r\n\r\n2\r\n','2Có thân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (làm gì, địa chỉ....)?\r\n',NULL),(5,5,'h sử bản thân\r\nKhai rõ: Bị bắt, bị tù (từ ngày thángn ă',' hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)\r\n','ân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (là',NULL),(6,6,'','','',NULL),(7,7,'','','',NULL),(8,8,'29) Đặc điểm lịch sử bản thân\r\nKhai rõ: Bị bắt, bị tù (từ ngày thángn ăm nào đến ngày tháng năm nào, ở đâu), đã khai báo cho ai, những vấn đề gì? Bản thân có làm việc tỏng chế độ cũ(cơ quan, đơn vị nào, địa điểm, chức danh, chức vụ, thời gian làm việc...)','Tham gia hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)','Có thân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (làm gì, địa chỉ....)?',NULL),(9,9,'9) Đặc điểm lịch sử bản thân\r\nKhai rõ: Bị bắt, bị tù (từ ngày thángn ăm nào đến ngày tháng năm nào, ở đâu), đã khai báo cho ai, những vấn đề gì? Bản thân có làm việc tỏng chế độ cũ(cơ quan, đơn vị nào, địa điểm, chức danh, chức vụ, thời gian làm việc...)','Tham gia hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)','Có thân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (làm gì, địa chỉ....)?',NULL);
/*!40000 ALTER TABLE `dacdienlichsubanthan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danhgiacanbo`
--

DROP TABLE IF EXISTS `danhgiacanbo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `danhgiacanbo` (
  `MaDanhGiaCanBo` int(11) NOT NULL,
  `MaCanBoDuocDanhGia` int(11) NOT NULL,
  `NoiDung` text,
  `NgayDanhGia` date DEFAULT NULL,
  `MucDoHoanThanh` int(11) DEFAULT NULL,
  `Quy` int(11) NOT NULL,
  `Nam` int(11) NOT NULL,
  `LaQuanLyHienTai` bit(1) NOT NULL,
  `MaNguoiDanhGia` int(11) NOT NULL,
  `ChucVuHienTaiNguoiDanhGia` text,
  PRIMARY KEY (`MaDanhGiaCanBo`),
  KEY `FKntwy2c7u7jnovbxnoqt01b1kd` (`MaCanBoDuocDanhGia`),
  KEY `FKdibk7c16ai6s6qcvhiyx9e3ds` (`MaNguoiDanhGia`),
  KEY `FKm6h4fy7n8l6s12hvkbfn9pobq` (`MucDoHoanThanh`),
  KEY `FK4qsj53l2qw3fnd3035akksjv3` (`Quy`),
  CONSTRAINT `FK4qsj53l2qw3fnd3035akksjv3` FOREIGN KEY (`Quy`) REFERENCES `quy` (`MaQuy`),
  CONSTRAINT `FKdibk7c16ai6s6qcvhiyx9e3ds` FOREIGN KEY (`MaNguoiDanhGia`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `FKm6h4fy7n8l6s12hvkbfn9pobq` FOREIGN KEY (`MucDoHoanThanh`) REFERENCES `mucdohoanthanh` (`MaMucDoHoanThanh`),
  CONSTRAINT `FKntwy2c7u7jnovbxnoqt01b1kd` FOREIGN KEY (`MaCanBoDuocDanhGia`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_DanhGiaCanBo_CanBo1` FOREIGN KEY (`MaCanBoDuocDanhGia`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DanhGiaCanBo_CanBo2` FOREIGN KEY (`MaNguoiDanhGia`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DanhGiaCanBo_MucDoHoanThanh1` FOREIGN KEY (`MucDoHoanThanh`) REFERENCES `mucdohoanthanh` (`MaMucDoHoanThanh`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DanhGiaCanBo_Quy1` FOREIGN KEY (`Quy`) REFERENCES `quy` (`MaQuy`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danhgiacanbo`
--

LOCK TABLES `danhgiacanbo` WRITE;
/*!40000 ALTER TABLE `danhgiacanbo` DISABLE KEYS */;
/*!40000 ALTER TABLE `danhgiacanbo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dantoc`
--

DROP TABLE IF EXISTS `dantoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dantoc` (
  `MaDanToc` int(11) NOT NULL,
  `TenDanToc` varchar(200) NOT NULL,
  PRIMARY KEY (`MaDanToc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dantoc`
--

LOCK TABLES `dantoc` WRITE;
/*!40000 ALTER TABLE `dantoc` DISABLE KEYS */;
INSERT INTO `dantoc` VALUES (1,'Kinh'),(2,'Tay'),(3,'nung');
/*!40000 ALTER TABLE `dantoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daotaochuyenmon`
--

DROP TABLE IF EXISTS `daotaochuyenmon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daotaochuyenmon` (
  `MaDaoTao` int(11) NOT NULL,
  `MaCanBo` int(11) DEFAULT NULL,
  `TuNgay` varchar(50) DEFAULT NULL,
  `ToiNgay` varchar(50) DEFAULT NULL,
  `HinhThucDaoTao` varchar(200) DEFAULT NULL,
  `ChuyenNganhDaoTao` varchar(200) DEFAULT NULL,
  `Truong` varchar(200) DEFAULT NULL,
  `ChungChiDatDuoc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`MaDaoTao`),
  KEY `FK7xbdgtdl2wpwddgce83xcftlw` (`MaCanBo`),
  CONSTRAINT `FK7xbdgtdl2wpwddgce83xcftlw` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_DaoTaoChuyenMon_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daotaochuyenmon`
--

LOCK TABLES `daotaochuyenmon` WRITE;
/*!40000 ALTER TABLE `daotaochuyenmon` DISABLE KEYS */;
INSERT INTO `daotaochuyenmon` VALUES (2,5,'04/13/2016','04/12/2016','Chính quy','tien su ','tien su ','Tiến sĩ'),(3,4,'06/01/2016','06/07/2016','Chính quy','asd','asd','Tiến sĩ khoa học'),(4,4,'06/02/2016','06/08/2016','Chính quy','asd','asd','Tiến sĩ khoa học'),(5,5,'05/11/2016','04/12/2016','Chính quy','thac si','thac si','Thạc sĩ'),(6,8,'06/02/2016','06/14/2016','Chính quy','q','q','Tiến sĩ khoa học'),(7,8,'06/08/2016','06/09/2016','Chính quy','5','5','Tiến sĩ khoa học'),(8,9,'06/10/2016','06/22/2016','Bồi dưỡng','9','9','Kỹ sư'),(9,9,'06/08/2016','06/01/2016','Tại chức','999','999','Tiến sĩ');
/*!40000 ALTER TABLE `daotaochuyenmon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dienbienluong`
--

DROP TABLE IF EXISTS `dienbienluong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dienbienluong` (
  `ID` int(11) NOT NULL,
  `CanBo` int(11) NOT NULL,
  `Thang` int(11) DEFAULT NULL,
  `Nam` int(11) DEFAULT NULL,
  `Bac` float DEFAULT NULL,
  `Ngach` float DEFAULT NULL,
  `HeSoLuong` float DEFAULT NULL,
  `lmangach_bac` varchar(255) DEFAULT NULL,
  `lngaythang` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_DienBienLuong_lylich1_idx` (`CanBo`),
  CONSTRAINT `FK59cebcb4ofx5h0p46324y7q84` FOREIGN KEY (`CanBo`) REFERENCES `lylich` (`Macanbo`),
  CONSTRAINT `fk_DienBienLuong_lylich1` FOREIGN KEY (`CanBo`) REFERENCES `lylich` (`Macanbo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dienbienluong`
--

LOCK TABLES `dienbienluong` WRITE;
/*!40000 ALTER TABLE `dienbienluong` DISABLE KEYS */;
INSERT INTO `dienbienluong` VALUES (0,5,NULL,NULL,NULL,NULL,3,'2','06/03/2016'),(3,5,NULL,NULL,NULL,NULL,3,'2','06/10/2016'),(4,8,NULL,NULL,NULL,NULL,1,'1','06/02/2016'),(5,4,NULL,NULL,NULL,NULL,5,'5','04/09/2016'),(6,8,NULL,NULL,NULL,NULL,5.5,'1','04/09/2016'),(7,8,NULL,NULL,NULL,NULL,NULL,'',''),(8,9,NULL,NULL,NULL,NULL,9,'9','06/18/2016'),(9,9,NULL,NULL,NULL,NULL,999,'999','06/23/2016');
/*!40000 ALTER TABLE `dienbienluong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donvi`
--

DROP TABLE IF EXISTS `donvi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donvi` (
  `MaDonVi` int(11) NOT NULL,
  `TenDonVi` varchar(250) NOT NULL,
  `MaKhoi` int(11) DEFAULT NULL,
  `MaTruongDonVi` int(11) DEFAULT NULL,
  `NgayThanhLap` date NOT NULL,
  `MoTa` text,
  PRIMARY KEY (`MaDonVi`),
  KEY `fk_idx` (`MaKhoi`),
  CONSTRAINT `FK19p8x2gvxoimj74d9dh47nvb2` FOREIGN KEY (`MaKhoi`) REFERENCES `khoi` (`MaKhoi`),
  CONSTRAINT `fk` FOREIGN KEY (`MaKhoi`) REFERENCES `khoi` (`MaKhoi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donvi`
--

LOCK TABLES `donvi` WRITE;
/*!40000 ALTER TABLE `donvi` DISABLE KEYS */;
/*!40000 ALTER TABLE `donvi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khenthuong`
--

DROP TABLE IF EXISTS `khenthuong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khenthuong` (
  `MaKhenThuong` int(11) NOT NULL,
  `MaCanBo` int(11) NOT NULL,
  `NgayKhenThuong` date NOT NULL,
  `NoiDung` text,
  `LyDo` text,
  `HinhThucKhenThuong` text NOT NULL,
  `NguoiXacNhan` int(11) DEFAULT NULL,
  `DaXacNhan` bit(1) NOT NULL,
  PRIMARY KEY (`MaKhenThuong`),
  KEY `FKej130b81nh9y5ypxlnxowq6xv` (`MaCanBo`),
  CONSTRAINT `FKej130b81nh9y5ypxlnxowq6xv` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_KyLuat_CanBo10` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khenthuong`
--

LOCK TABLES `khenthuong` WRITE;
/*!40000 ALTER TABLE `khenthuong` DISABLE KEYS */;
/*!40000 ALTER TABLE `khenthuong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khoi`
--

DROP TABLE IF EXISTS `khoi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khoi` (
  `MaKhoi` int(11) NOT NULL,
  `TenKhoi` varchar(505) NOT NULL,
  PRIMARY KEY (`MaKhoi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khoi`
--

LOCK TABLES `khoi` WRITE;
/*!40000 ALTER TABLE `khoi` DISABLE KEYS */;
/*!40000 ALTER TABLE `khoi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kyluat`
--

DROP TABLE IF EXISTS `kyluat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kyluat` (
  `MaKyLuat` int(11) NOT NULL,
  `MaCanBo` int(11) NOT NULL,
  `NgayKyLuat` date NOT NULL,
  `NoiDung` text,
  `LyDo` text,
  `HinhThucKyLuat` text NOT NULL,
  `NguoiXacNhanKyLuat` int(11) DEFAULT NULL,
  `DaXacNhan` bit(1) NOT NULL,
  PRIMARY KEY (`MaKyLuat`),
  KEY `FK2insxcr5vr91skddjdgp8rkyi` (`MaCanBo`),
  CONSTRAINT `FK2insxcr5vr91skddjdgp8rkyi` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_KyLuat_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kyluat`
--

LOCK TABLES `kyluat` WRITE;
/*!40000 ALTER TABLE `kyluat` DISABLE KEYS */;
/*!40000 ALTER TABLE `kyluat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lichsucongtac`
--

DROP TABLE IF EXISTS `lichsucongtac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lichsucongtac` (
  `MaLSCT` int(11) NOT NULL,
  `MaCanBo` int(11) NOT NULL,
  `TuNgay` varchar(50) DEFAULT NULL,
  `ToiNgay` varchar(50) DEFAULT NULL,
  `ChucVu` text,
  PRIMARY KEY (`MaLSCT`),
  KEY `FKs4esg8sp05m72bwy3fe3594bj` (`MaCanBo`),
  CONSTRAINT `FKs4esg8sp05m72bwy3fe3594bj` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `fk_LichSuCongTac_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lichsucongtac`
--

LOCK TABLES `lichsucongtac` WRITE;
/*!40000 ALTER TABLE `lichsucongtac` DISABLE KEYS */;
INSERT INTO `lichsucongtac` VALUES (4,4,'06/06/2016','06/06/2016','asdasd'),(5,5,'06/16/2016','06/01/2016','987'),(6,4,'06/06/2016','06/06/2016','11'),(7,8,'06/08/2016','06/06/2016','wer'),(8,4,'06/09/2016','06/09/2016','asd'),(9,5,'','','987'),(10,8,'06/01/2016','06/01/2016','werqr'),(11,8,'06/01/2016','06/15/2016','ertertert'),(12,9,'06/01/2016','06/07/2016','9'),(13,9,'06/01/2016','06/06/2016','999');
/*!40000 ALTER TABLE `lichsucongtac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lylich`
--

DROP TABLE IF EXISTS `lylich`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lylich` (
  `MaTrinhDoChinhTri` int(11) DEFAULT NULL,
  `MaTonGiao` int(11) DEFAULT NULL,
  `MaTrinhDoChuyenMon` int(11) DEFAULT NULL,
  `MaDanToc` int(11) DEFAULT NULL,
  `TenGoiKhac` varchar(200) DEFAULT NULL,
  `TenCanBo` varchar(200) DEFAULT NULL,
  `NgaySinh` varchar(50) DEFAULT NULL,
  `GioiTinh` bit(1) DEFAULT NULL,
  `NoiSinh` varchar(200) DEFAULT NULL,
  `QueQuan` varchar(200) DEFAULT NULL,
  `HoKhauThuongTru` varchar(500) DEFAULT NULL,
  `NoiOHienNay` varchar(500) DEFAULT NULL,
  `NgheNgiepKhiDuocTuyenDung` varchar(200) DEFAULT NULL,
  `NgayTuyenDung` varchar(50) DEFAULT NULL,
  `ChucVuBenNgoaiHienTai` varchar(200) DEFAULT NULL,
  `CongViecChinhDuocGiao` varchar(500) DEFAULT NULL,
  `NgachCongChuc` varchar(500) DEFAULT NULL,
  `MaNgach` float DEFAULT NULL,
  `BacLuong` float DEFAULT NULL,
  `HeSo` float DEFAULT NULL,
  `NgayHuong` varchar(50) DEFAULT NULL,
  `PhuCapChucVu` double DEFAULT NULL,
  `PhuCapKhac` double DEFAULT NULL,
  `TrinhDoPhoThong` varchar(200) DEFAULT NULL,
  `QuanLyNhaNuoc` varchar(200) DEFAULT NULL,
  `TinHoc` varchar(200) DEFAULT NULL,
  `NgayVaoDang` varchar(50) DEFAULT NULL,
  `NgayChinhThuc` varchar(50) DEFAULT NULL,
  `NgayThamGiaToChucChinhTri` text,
  `NgayNhapNgu` varchar(50) DEFAULT NULL,
  `NgayXuatNgu` varchar(50) DEFAULT NULL,
  `QuanHamCaoNhat` varchar(200) DEFAULT NULL,
  `DanhHieuPhongTangCaoNhat` varchar(200) DEFAULT NULL,
  `SoTruongCongTac` varchar(200) DEFAULT NULL,
  `TinhTrangSucKhoe` varchar(200) DEFAULT NULL,
  `ChieuCao` float DEFAULT NULL,
  `CanNang` float DEFAULT NULL,
  `NhomMau` varchar(200) DEFAULT NULL,
  `LaThuongBinhHang` varchar(200) DEFAULT NULL,
  `LaConGiaDinhChinhSach` varchar(200) DEFAULT NULL,
  `SoCMND` varchar(20) DEFAULT NULL,
  `NgayCap` varchar(50) DEFAULT NULL,
  `SoBHXH` varchar(200) DEFAULT NULL,
  `NhanXetCapTren` text,
  `DaXacNhan` bit(1) DEFAULT NULL,
  `hinhanh` varchar(555) DEFAULT NULL,
  `Sohieucongchuc` varchar(405) DEFAULT NULL,
  `Macanbo` int(11) NOT NULL,
  `Nguoixacnhan` int(11) DEFAULT NULL,
  `NgoaiNgu` int(11) DEFAULT NULL,
  `SoTruong` varchar(555) DEFAULT NULL,
  `KhenThuongCaoNhat` varchar(555) DEFAULT NULL,
  `KyLuatCaoNhat` varchar(555) DEFAULT NULL,
  `CoQuanTuyenDung` varchar(45) DEFAULT NULL,
  `NoiSuDung` varchar(45) DEFAULT NULL,
  `NoiQuanLy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Macanbo`),
  KEY `fk_lylich_canbo2_idx` (`Nguoixacnhan`),
  KEY `fk_lylich_ngoaingu1_idx` (`NgoaiNgu`),
  KEY `FK7w4pngc6ji0ccj59wcpgmt7ef` (`MaDanToc`),
  KEY `FKknobor4k621f8jxdk28eco6va` (`MaTonGiao`),
  KEY `FKntt9nfvwe4dryeevxuw771k1g` (`MaTrinhDoChinhTri`),
  KEY `FKipa6ktj0g0njsttvl2ldjanx8` (`MaTrinhDoChuyenMon`),
  CONSTRAINT `FK7w4pngc6ji0ccj59wcpgmt7ef` FOREIGN KEY (`MaDanToc`) REFERENCES `dantoc` (`MaDanToc`),
  CONSTRAINT `FKi7ym20cu09t525vpq33k4mpb5` FOREIGN KEY (`Nguoixacnhan`) REFERENCES `canbo` (`MaCanBo`),
  CONSTRAINT `FKipa6ktj0g0njsttvl2ldjanx8` FOREIGN KEY (`MaTrinhDoChuyenMon`) REFERENCES `trinhdochuyenmon` (`MaTrinhDoChuyenMon`),
  CONSTRAINT `FKj692c6ba6mbsjhiw31vhdri6x` FOREIGN KEY (`NgoaiNgu`) REFERENCES `ngoaingu` (`MaNgoaiNgu`),
  CONSTRAINT `FKknobor4k621f8jxdk28eco6va` FOREIGN KEY (`MaTonGiao`) REFERENCES `tongiao` (`MaTonGiao`),
  CONSTRAINT `FKntt9nfvwe4dryeevxuw771k1g` FOREIGN KEY (`MaTrinhDoChinhTri`) REFERENCES `trinhdochinhtri` (`MaTrinhDoChinhTri`),
  CONSTRAINT `fk_LyLich_DanToc1` FOREIGN KEY (`MaDanToc`) REFERENCES `dantoc` (`MaDanToc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LyLich_TonGiao1` FOREIGN KEY (`MaTonGiao`) REFERENCES `tongiao` (`MaTonGiao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LyLich_TrinhDoChinhTri1` FOREIGN KEY (`MaTrinhDoChinhTri`) REFERENCES `trinhdochinhtri` (`MaTrinhDoChinhTri`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LyLich_TrinhDoChuyenMon1` FOREIGN KEY (`MaTrinhDoChuyenMon`) REFERENCES `trinhdochuyenmon` (`MaTrinhDoChuyenMon`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lylich_canbo1` FOREIGN KEY (`Macanbo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lylich_canbo2` FOREIGN KEY (`Nguoixacnhan`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lylich_ngoaingu1` FOREIGN KEY (`NgoaiNgu`) REFERENCES `ngoaingu` (`MaNgoaiNgu`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lylich`
--

LOCK TABLES `lylich` WRITE;
/*!40000 ALTER TABLE `lylich` DISABLE KEYS */;
INSERT INTO `lylich` VALUES (NULL,NULL,NULL,NULL,'Tên gọi khác',' và tên khai sinh',NULL,'\0',NULL,NULL,'ơi đăng ký hộ khẩu thường trú','Nơi ở hiện nay',') Nghề nghiệp khi được tuyển dụng','2016-05-01','Giám Đốc','ơ quan tuyển dụng','Lưu trữ viên',7,5,5,'2016-05-01',5,5,'ghiệp lớp mấy/thuộc thệ nào)','Chuyên viên cao cấp','C',NULL,NULL,'05/17/2016','2016-05-17','2016-05-16','Quân hàm cao nhất','Thầy thuốc','Sở trường công tác','rạng sức khỏe',1,1,'A','1','Con liệt sĩ','1111','2016-05-09','1','32) Nhận xét, đánh giá của cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức',NULL,NULL,' hiệu cán bộ',0,NULL,NULL,NULL,'21) Khen thưởng',') Kỷ luật',NULL,NULL,NULL),(NULL,NULL,NULL,NULL,'','',NULL,'',NULL,NULL,'','','',NULL,'Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,NULL,NULL,NULL,'','Chuyên viên cao cấp','A',NULL,NULL,'',NULL,NULL,'','Anh hùng lao động',NULL,'',NULL,NULL,'A','','Không','',NULL,'','',NULL,NULL,'',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(NULL,NULL,NULL,NULL,'','',NULL,'',NULL,NULL,'','','',NULL,'Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,NULL,NULL,NULL,'','Chuyên viên cao cấp','A',NULL,NULL,'',NULL,NULL,'','Anh hùng lao động',NULL,'',NULL,NULL,'A','','Không','',NULL,'','',NULL,NULL,'',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(NULL,NULL,NULL,NULL,'','',NULL,'',NULL,NULL,'','','',NULL,'Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,NULL,NULL,NULL,'','Chuyên viên cao cấp','A',NULL,NULL,'',NULL,NULL,'','Anh hùng lao động',NULL,'',NULL,NULL,'A','','Không','',NULL,'','',NULL,NULL,'',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,3,4,3,'dddddddwww','asddddddddddddđ','06/01/2016','\0','4) Nơi sinh:','5) Quê quán:','asd8','adadas8','hề nghiệp khi được tuyển dụng','06/01/2016','Giám Đốc','cv chinh','Chuyên viên',8,8,8,'',8,9,'9','Cán sự','C','06/01/2016','06/01/2016','06/02/2016','06/09/2016','06/14/2016','r','Anh hùng lao động','stct','sk',4,50,'O','tb','Người nhiễm chất độc màu da cam Dioxin','34534','06/06/2016','345345','32) Nhận xét, đánh giá casdasủa cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức\r\n32) Nhận xét, đánh giá casdasủa cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức\r\n32) Nhận xét, đánh giá casdasủa cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức\r\n32) Nhận xét, đánh giá casdasủa cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức\r\n',NULL,NULL,'ệu cán bộ, công chứ',4,NULL,3,NULL,'ktcn','kln','sad','n, đơn vị sử dụng cán bộ công ','Cơ quan, đơn vị có thẩm quyền quản l'),(1,1,1,1,'','','','\0',NULL,NULL,'','','','','Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,'',NULL,NULL,'','Chuyên viên cao cấp','A','','','','','','','Anh hùng lao động','','',NULL,NULL,'A','','Không','','','','',NULL,NULL,'',5,NULL,1,NULL,'','','',NULL,NULL),(NULL,NULL,NULL,NULL,'','',NULL,'',NULL,NULL,'','','',NULL,'Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,NULL,NULL,NULL,'','Chuyên viên cao cấp','A',NULL,NULL,'',NULL,NULL,'','Anh hùng lao động',NULL,'',NULL,NULL,'A','','Không','',NULL,'','',NULL,NULL,'',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(NULL,NULL,NULL,NULL,'123123','1123123',NULL,'',NULL,NULL,'','','',NULL,'Chức Vụ Khác','','Không hưởng lương',NULL,NULL,NULL,NULL,NULL,NULL,'','Chuyên viên cao cấp','A',NULL,NULL,'',NULL,NULL,'','Anh hùng lao động',NULL,'',NULL,NULL,'A','','Không','',NULL,'','',NULL,NULL,'',7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,2,2,'2) Tên gọi khác','1) Họ và tên khai sinh','3) Sinh ngày','',NULL,NULL,'8) Nơi đăng ký hộ khẩu thường trú','9) Nơi ở hiện nay','10) Nghề nghiệp khi được tuyển dụng','06/10/2016','Giám Đốc','3) Công việc chính được giao','Kỹ thuật viên đánh máy',6,6,5,'06/06/2016',4,4,'t nghiệp lớp mấy/thuộc thệ nào)','Chuyên viên cao cấp','C','06/15/2016','Ngày chính thứ','17) Ngày tham gia tô chức chính trị - xã hội','06/02/2016','06/07/2016',' cao nhất','Thầy thuốc','20) Sở trường công tác','23) Tình trạng sức khỏe',3,2,'AB','24) Là thương bình hạng','Con liệt sĩ','234234234','06/06/2016','23423423423423','32) Nhận xét, đánh giá của cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức',NULL,NULL,'',8,NULL,3,NULL,'21) Khen thưởng','22) Kỷ luật','asdasdasd',NULL,NULL),(1,3,4,3,'2) Tên gọi khác',') Họ và tên khai sinh','06/01/2016','\0','4) Nơi sinh: Tỉnh','4) Nơi sinh: Tỉnh','8) Nơi đăng ký hộ khẩu thường trú','9) Nơi ở hiện nay','Nghề nghiệp khi được tuyển d','Nghề nghiệp khi được tuyển d','Nhân Viên','13) Công việc chính được giao','Nhân viên thuế',9,9,9,'06/09/2016',9,9,'9','Chuyên viên cao cấp','C','06/03/2016','06/22/2016','06/13/2016','06/16/2016','06/21/2016','9','Nghệ sĩ nhân dân và ưu tú',') Sở trường công tác','23) Tình trạng sức khỏe',9,9,'Khác','9','Người nhiễm chất độc màu da cam Dioxin','999','06/15/2016','999','32) Nhận xét, đánh giá của cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức',NULL,NULL,'ệu cán bộ, công chức',9,NULL,3,NULL,'21) Khen thưởng','2) Kỷ luật','',' đơn vị sử dụng cán bộ công chứ',', đơn vị có thẩm quyền quản lý c');
/*!40000 ALTER TABLE `lylich` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mucdohoanthanh`
--

DROP TABLE IF EXISTS `mucdohoanthanh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mucdohoanthanh` (
  `MaMucDoHoanThanh` int(11) NOT NULL,
  `TenMucDoHoanThanh` varchar(200) NOT NULL,
  PRIMARY KEY (`MaMucDoHoanThanh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mucdohoanthanh`
--

LOCK TABLES `mucdohoanthanh` WRITE;
/*!40000 ALTER TABLE `mucdohoanthanh` DISABLE KEYS */;
/*!40000 ALTER TABLE `mucdohoanthanh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ngoaingu`
--

DROP TABLE IF EXISTS `ngoaingu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ngoaingu` (
  `MaNgoaiNgu` int(11) NOT NULL,
  `TenNgoaiNgu` varchar(200) NOT NULL,
  PRIMARY KEY (`MaNgoaiNgu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ngoaingu`
--

LOCK TABLES `ngoaingu` WRITE;
/*!40000 ALTER TABLE `ngoaingu` DISABLE KEYS */;
INSERT INTO `ngoaingu` VALUES (1,'A'),(2,'B'),(3,'C'),(4,'Khac');
/*!40000 ALTER TABLE `ngoaingu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quy`
--

DROP TABLE IF EXISTS `quy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quy` (
  `MaQuy` int(11) NOT NULL,
  `TenQuy` varchar(100) NOT NULL,
  PRIMARY KEY (`MaQuy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quy`
--

LOCK TABLES `quy` WRITE;
/*!40000 ALTER TABLE `quy` DISABLE KEYS */;
/*!40000 ALTER TABLE `quy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taikhoan` (
  `MaCanBo` int(11) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(50) NOT NULL,
  PRIMARY KEY (`MaCanBo`),
  UNIQUE KEY `TenDangNhap_UNIQUE` (`TenDangNhap`),
  UNIQUE KEY `UKcre3ltw1btsm2ai83kiboc1e6` (`TenDangNhap`),
  CONSTRAINT `fk_TaiKhoan_CanBo1` FOREIGN KEY (`MaCanBo`) REFERENCES `canbo` (`MaCanBo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
INSERT INTO `taikhoan` VALUES (0,'1','1'),(1,'678','88888888'),(2,'2','88888888'),(3,'3','88888888'),(4,'4','88888888'),(5,'5','88888888'),(6,'6','88888888'),(7,'7','88888888'),(8,'8','88888888'),(9,'9','88888888');
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tongiao`
--

DROP TABLE IF EXISTS `tongiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tongiao` (
  `MaTonGiao` int(11) NOT NULL,
  `TenTonGiao` varchar(200) NOT NULL,
  PRIMARY KEY (`MaTonGiao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tongiao`
--

LOCK TABLES `tongiao` WRITE;
/*!40000 ALTER TABLE `tongiao` DISABLE KEYS */;
INSERT INTO `tongiao` VALUES (1,'kinh'),(2,'khong'),(3,'thien chua');
/*!40000 ALTER TABLE `tongiao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trinhdochinhtri`
--

DROP TABLE IF EXISTS `trinhdochinhtri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trinhdochinhtri` (
  `MaTrinhDoChinhTri` int(11) NOT NULL,
  `TenTrinhDoChinhTri` varchar(200) NOT NULL,
  PRIMARY KEY (`MaTrinhDoChinhTri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trinhdochinhtri`
--

LOCK TABLES `trinhdochinhtri` WRITE;
/*!40000 ALTER TABLE `trinhdochinhtri` DISABLE KEYS */;
INSERT INTO `trinhdochinhtri` VALUES (1,'CT1'),(2,'CT2'),(3,'CT3');
/*!40000 ALTER TABLE `trinhdochinhtri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trinhdochuyenmon`
--

DROP TABLE IF EXISTS `trinhdochuyenmon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trinhdochuyenmon` (
  `MaTrinhDoChuyenMon` int(11) NOT NULL,
  `TenTrinhDoChuyenMon` varchar(200) NOT NULL,
  PRIMARY KEY (`MaTrinhDoChuyenMon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trinhdochuyenmon`
--

LOCK TABLES `trinhdochuyenmon` WRITE;
/*!40000 ALTER TABLE `trinhdochuyenmon` DISABLE KEYS */;
INSERT INTO `trinhdochuyenmon` VALUES (1,'TD1'),(2,'TD2'),(4,'TD4');
/*!40000 ALTER TABLE `trinhdochuyenmon` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-07 14:26:43
