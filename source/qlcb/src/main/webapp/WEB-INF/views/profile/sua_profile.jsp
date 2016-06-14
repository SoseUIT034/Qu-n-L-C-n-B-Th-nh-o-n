<!DOCTYPE html>
 <%@page import="javax.jws.WebParam.Mode"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<html lang="en">
<head>
<!-- <c:url value="/resources/lylich_canbo/css/bootstrap.min.css"/> -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/bootstrap.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/bootstrap-theme.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/jquery-ui.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/MyStyle.css"/>">



<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" type="text/css" href="../../resources/lylich_canbo/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="../../resources/lylich_canbo/css/jquery-ui.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="../../resources/lylich_canbo/css/MyStyle.css"> -->

<!-- <script src="../../resources/lylich_canbo/js/jquery-1.12.2.js"></script> --> 
<!-- <script src="../../resources/lylich_canbo/js/bootstrap.min.js"></script> -->
<!-- <script src="../../resources/lylich_canbo/js/jquery-ui.js"></script> -->
<!-- <script src="../../resources/lylich_canbo/js/myjs.js"></script> -->

<title>Thông tin cán bộ</title>


</head>
<body >

	<!---header--->
	<%@include file ="../layout/header.jsp" %>
	<!---header--->
	
	<div class="content" style="padding-top: 30px; ">
 		<c:url var="actionUrl"  value="create" />
 		
 		<sec:authorize access="hasAnyRole('Admin','Employee')">
 		
		<form:form class="container" enctype="multipart/form-data" commandName="Lylich" action="" style="border: rebeccapurple; border-style: dotted; padding:50px" method="POST" >
			  <div class="col-xs-12" style="display: none">
			      <form:input  disabled="true" path="macanbo" id="maCanBo"  class="form-control" type="text"/>
			       <form:errors path="macanbo" cssclass="error"></form:errors>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>Cơ quan, đơn vị có thẩm quyền quản lý cán bộ công chức</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="noiQuanLy" id="cqdvtxt"    name="cqdbtxt" class="form-control" type="text"/>
			      <form:errors path="noiQuanLy" cssclass="error"></form:errors>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label> Số hiệu cán bộ, công chức </label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="sohieucongchuc" id="shcbtxt"   name="shcbtxt" class="form-control" type="text"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4" >
			      <label>Cơ quan, đơn vị sử dụng cán bộ công chức </label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="noiSuDung" id="cqdvsdtxt" name="cqdvsdtxt" type="text" class="form-control"/>
			    </div>
			  </div>
			  <div class="row">
			    <div style="text-align:center; font-size:48px;" class="uppercase col-xs-12 col-md-12"> <b>sơ yếu lý lịch cán bộ, công chức </b> </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <div class="form-group"> <img id="imgpreview"  style="max-width:60%; max-height::60%;" src="${Lylich.hinhanh}" alt="Ảnh đại diện"/> </div>
			      
			    </div>
			    <div class="col-xs-12 col-md-9">
			      <div class="container-fluid">
			      <div class="row">
					    <div class="col-xs-12 col-md-3">
				            <label> Loại cán bộ: </label>
				          </div>
				   		 <div class="col-xs-12 col-md-9"  > 
						      <form:select disabled="true" path="loaicanbo" class="form-control">
						      	<form:option value="4">Admin</form:option>
						      	<form:option value="5">Quản lý</form:option>
						      	<form:option value="6">Cán bộ</form:option>
						      </form:select>
					      </div>
				     </div> 
				     <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label> Mật khẩu tài khoản </label>
			          </div>
			          <div class="col-xs-12 col-md-9"   > 
			          	<form:input    path="matkhauLTN" class="form-control text-uppercase" type="text"/> 
			          </div>
			        </div>
			        <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label> 1) Họ và tên khai sinh </label>
			          </div>
			          <div class="col-xs-12 col-md-9" disabled  > 
			          	<form:input  disabled="true"  path="tenCanBo" class="form-control text-uppercase" type="text"  id="hotentxt" name="hotentxt"  /> 
			          </div>
			        </div>
			        <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label>2) Tên gọi khác</label>
			          </div>
			          <div class="col-xs-12 col-md-9">
			            <form:input  disabled="true" path="tenGoiKhac" type="text" class="form-control" id="tengoikhactxt" name="tengoikhactxt"/>
			          </div>
			        </div>
			        <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label>3) Sinh ngày </label>
			          </div>
			          <div class="col-xs-12 col-md-3">
			            <form:input  disabled="true" path="ngaySinh"  class="datepicker form-control" type="date-time" id="sinhngaytxt" name="sinhngaytxt"/>
			          </div>
			          <div class="col-xs-12 col-md-3" style="text-align:right">
			            <label>Giới tính: </label>
			          </div>
			          <div class="col-xs-12 col-md-3">
			            <form:select disabled="${'true'}" path="gioiTinh" class="form-control" id="gioitinhsel" name="gioitinhsel">
			              <form:option value="1">Nam</form:option>
			              <form:option value="0">Nữ</form:option>
			            </form:select>
			         </div>
			        </div>
			        <div class="row">
			          <p></p>
			          <div class="col-xs-12 col-md-3">
			            <label>4) Nơi sinh: </label>
			          </div>
			          <div class="col-xs-12 col-md-9">
			            <form:input  disabled="true" path="noiSinh"  class="datepicker form-control" type="date-time" id="sinhngaytxt" name="sinhngaytxt"/>
			          </div>
			            
			        </div>
			        <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label>5) Quê quán: </label>
			          </div>
			          <div class="col-xs-12 col-md-9">
			            <form:input  disabled="true" path="queQuan"  class="datepicker form-control" type="date-time" id="sinhngaytxt" name="sinhngaytxt"/>
			          </div>
			           
			        </div>
			        <div class="row">
			          <div class="col-xs-12 col-md-3">
			            <label>6, Dân tôc: </label>
			          </div>
			          <div class="col-xs-12 col-md-3">
			            <form:select disabled="${'true'}" path="dantoc.maDanToc" class="form-control" id="dantocsel">
				             
				           	  <c:forEach items="${listdantoc}" var="item">
				           	  	<option value="${item.maDanToc}">${item.tenDanToc}</option>
				           	  </c:forEach> 
				           	 
			            </form:select>
			          </div>
			          <div class="col-xs-12 col-md-3">
			            <label>7) Tôn giáo</label>
			          </div>
			          <div class="col-xs-12 col-md-3">
			            <form:select disabled="${'true'}" path="tongiao.maTonGiao" class="form-control" id="tongiaosel" >
				              
					              <c:forEach items="${listtocgiao}" var="item">
					           	  	<option value="${item.maTonGiao}">${item.tenTonGiao}</option>
					           	  </c:forEach>
				           	   
			            </form:select>
			          </div>
			        </div>
			      </div>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>8) Nơi đăng ký hộ khẩu thường trú </label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="hoKhauThuongTru" class="form-control" placeholder="Số nhà, đường phố, thành phố, xóm, thôn, xã, huyện, tỉnh" id="ndkhktttxt" name="ndkhktttxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>9) Nơi ở hiện nay </label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="noiOhienNay" class="form-control" placeholder="Số nhà, đường phố, thành phố, xóm, thôn, xã, huyện, tỉnh" id="nohntxt" name="nohntxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>10) Nghề nghiệp khi được tuyển dụng</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="ngheNgiepKhiDuocTuyenDung" type="text" class="form-control" id="nnkdtdtxt" name="nnkdtdtxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>11) Ngày tuyển dụng</label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="ngayTuyenDung" type="date-time" class="form-control datepicker" id="ntdtxt" name="ntdtxt"/>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <label>Cơ quan tuyển dụng</label>
			    </div>
			    <div class="col-xs-12 col-md-4">
			      <form:input disabled="true" path="coQuanTuyenDung" id="cqdvtxt"    name="cqdbtxt" class="form-control" type="text"/> 
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>12) Chức vụ (chức danh) hiện tại</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:select disabled="${'true'}" path="chucVuBenNgoaiHienTai" class="form-control" id="cvhtsel" name="cvhtsel">
			        <form:option value="Chức Vụ Khác">Chức Vụ Khác</form:option>
			        <form:option value="Bí Thư">Bí Thư</form:option>
			        <form:option value="Giám Đốc">Giám Đốc</form:option>
			        <form:option value="Phó Bí Thư">Phó Bí Thư</form:option>
			        <form:option value="Phó Giám Đốc">Phó Giám Đốc</form:option>
			        <form:option value="Thường Trực">Thường Trực</form:option>
			        <form:option value="Thường Vụ">Thường Vụ</form:option>
			        <form:option value="Thành Viên Hội Đồng">Thành Viên Hội Đồng</form:option>
			        <form:option value="Ủy Viên Ban Chấp Hành">Ủy Viên Ban Chấp Hành</form:option>
			        <form:option value="Trưởng Ban">Trưởng Ban</form:option>
			        <form:option value="Kế Toán Trưởng">Kế Toán Trưởng</form:option>
			        <form:option value="Trưởng Phòng">Trưởng Phòng</form:option>
			        <form:option value="Phó Ban">Phó Ban</form:option>
			        <form:option value="Kế Toán Phó">Kế Toán Phó</form:option>
			        <form:option value="Phó Phòng">Phó Phòng</form:option>
			        <form:option value="Cán Bộ">Cán Bộ</form:option>
			        <form:option value="Nhân Viên">Nhân Viên</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4" >
			      <label>13) Công việc chính được giao</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="congViecChinhDuocGiao" type="text" class="form-control" id="cvcdgtxt" name="cvcdgtxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4"  >
			      <label>14) Ngạch công chức (viên chức) </label>
			    </div>
			    <div class="col-xs-12 col-md-4">
			      <form:select disabled="${'true'}" path="ngachCongChuc" class="form-control" id="MaNgachList"  name="ncctxt" >
			        <form:option value="Không hưởng lương">Không hưởng lương</form:option>
			        <form:option value="Chuyên viên cao cấp">Chuyên viên cao cấp</form:option>
			        <form:option value="Chuyên viên chính">Chuyên viên chính</form:option>
			        <form:option value="Chuyên viên">Chuyên viên</form:option>
			        <form:option value="Cán sự">Cán sự </form:option>
			        <form:option value="Kỹ thuật viên đánh máy">Kỹ thuật viên đánh máy</form:option>
			        <form:option value="Nhân viên đánh máy">Nhân viên đánh máy</form:option>
			        <form:option value="Nhân viên kỹ thuật">Nhân viên kỹ thuật</form:option>
			        <form:option value="Nhân viên văn thư">Nhân viên văn thư</form:option>
			        <form:option value="Nhân vien phục vụ">Nhân vien phục vụ</form:option>
			        <form:option value="Lái xe cơ quan">Lái xe cơ quan</form:option>
			        <form:option value="Nhân viên bảo vệ">Nhân viên bảo vệ</form:option>
			        <form:option value="Kỹ thuật viên trung cấp">Kỹ thuật viên trung cấp</form:option>
			        <form:option value="Lưu trữ viên cao cấp">Lưu trữ viên cao cấp</form:option>
			        <form:option value="Lưu trữ viên chính">Lưu trữ viên chính</form:option>
			        <form:option value="Lưu trữ viên">Lưu trữ viên</form:option>
			        <form:option value="Kỹ thuật viên lưu trữ">Kỹ thuật viên lưu trữ</form:option>
			        <form:option value="Chấp hành viên tỉnh, thành pố trực thuộc Trung ương">Chấp hành viên tỉnh, thành pố trực thuộc Trung ương</form:option>
			        <form:option value="Chấp hành viên quận, huyện, thị xã, thành pố thuộc tỉnh">Chấp hành viên quận, huyện, thị xã, thành pố thuộc tỉnh</form:option>
			        <form:option value="Công chứng viên">Công chứng viên</form:option>
			        <form:option value="Thanh tra viên cao cấp">Thanh tra viên cao cấp</form:option>
			        <form:option value="Thanh tra viên chính">Thanh tra viên chính</form:option>
			        <form:option value="Thanh tra viên">Thanh tra viên</form:option>
			        <form:option value="Kế toàn viên cao cấp">Kế toàn viên cao cấp</form:option>
			        <form:option value="Kế toán viên chính">Kế toán viên chính</form:option>
			        <form:option value="Kế toán viên">Kế toán viên</form:option>
			        <form:option value="Kế toán viên trung cấp">Kế toán viên trung cấp</form:option>
			        <form:option value="Kế toán viên sơ cấp">Kế toán viên sơ cấp</form:option>
			        <form:option value="Thủ quỹ có bạc, ngân hàng">Thủ quỹ có bạc, ngân hàng</form:option>
			        <form:option value="Thủ quỹ cơ quan, đơn vị">Thủ quỹ cơ quan, đơn vị</form:option>
			        <form:option value="Kiểm soát viên cao cấp thuế">Kiểm soát viên cao cấp thuế</form:option>
			        <form:option value="Kiểm soát viên chính thuế">Kiểm soát viên chính thuế</form:option>
			        <form:option value="Kiếm soát viên thuế">Kiếm soát viên thuế</form:option>
			        <form:option value="Kiếm thu viên thuế">Kiếm thu viên thuế</form:option>
			        <form:option value="Nhân viên thuế">Nhân viên thuế </form:option>
			      </form:select>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <label>Mã ngạch</label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="maNgach" type="text"  class="form-control" id="mntxt" name="mntxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-6 col-md-2">
			      <label>Bậc lương</label>
			    </div>
			    <div class="col-xs-6 col-md-2">
			      <form:input  disabled="true" path="bacLuong" class="number form-control" id="bltxt" name="bltxt"/>
			    </div>
			    <div class="col-xs-6 col-md-2">
			      <label >Hệ số</label>
			    </div>
			    <div class="col-xs-6 col-md-2">
			      <form:input  disabled="true" path="heSo" class="number form-control" id="hstxt" name="hstxt"/>
			    </div>
			    <div class="col-xs-6 col-md-2">
			      <label>Ngày hưởng</label>
			    </div>
			    <div class="col-xs-6 col-md-2">
			      <form:input  disabled="true" path="ngayHuong"  class="datepicker form-control" type ="date-time" id="nhtxt" name="nhtxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-6 col-md-2">
			      <label>Phụ cấp chức vụ </label>
			    </div>
			    <div class="col-xs-6 col-md-4">
			      <form:input  disabled="true" path="phuCapChucVu" class="number form-control" id="pccvtxt" name="pccvtxt"/>
			    </div>
			    <div class="col-xs-6 col-md-3">
			      <label> Phụ cấp khác </label>
			    </div>
			    <div class="col-xs-6 col-md-3">
			      <form:input  disabled="true" path="phuCapKhac" class="number form-control" id="pcktxt" name="pcktxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-6"    >
			      <label>15.1) Trình độ giáo dục phổ thông(Đã tốt nghiệp lớp mấy/thuộc thệ nào) </label>
			    </div>
			    <div class="col-xs-12 col-md-6">
			      <form:input  disabled="true" path="trinhDoPhoThong" class="form-control" placeholder="Đã tốt nghiệp lớp mấy/thuộc hệ nào" id="tdgdpttxt" name="tdgdpttxt"/>
			    </div>
			  </div>
			  
			  
			  
			  <div class="row">
			    <div class="col-xs-12 col-md-6">
			      <label>15.2) Trình độ chuyên môn cao nhất</label>
			    </div>
			    <div class="col-xs-12 col-md-6">
			       <form:select disabled="${'true'}" path="trinhdochuyenmon.maTrinhDoChuyenMon" class="form-control" id="tongiaosel" >
				              
					              <c:forEach items="${listchuyenmon}" var="item">
					           	  	<option value=${item.maTrinhDoChuyenMon}>${item.tenTrinhDoChuyenMon}</option>
					           	  </c:forEach>
				           	   
		     	  </form:select>
<!-- 		     	  	---- -->
<!-- 			      <select class="form-control" id="tdcmsel" name="tdcmsel"> -->
<!-- 			        <option value="12.00">Chưa có bằng CM</option> -->
<!-- 			        <option value="14.00">Trung cấp</option> -->
<!-- 			        <option value="14.50">TC Chuyên Nghiệp</option> -->
<!-- 			        <option value="15.00">Cao đẳng</option> -->
<!-- 			        <option value="16.00">Cử nhân</option> -->
<!-- 			        <option value="16.50">Kỹ sư</option> -->
<!-- 			        <option value="18.00">Thạc Sỹ</option> -->
<!-- 			        <option value="20.00">Tiến Sỹ</option> -->
<!-- 			        <option value="22.00">Tiến Sỹ Khoa Học</option> -->
<!-- 			      </select> -->
<!--				 ----- -->
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>15.3) Lý luận chính trị </label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			    	<form:select disabled="${'true'}" path="trinhdochinhtri.maTrinhDoChinhTri" class="form-control" id="tongiaosel" >
				              
					              <c:forEach items="${listchinhtri}" var="item">
					           	  	<option value="${item.maTrinhDoChinhTri}">${item.tenTrinhDoChinhTri}</option>
					           	  </c:forEach>
				           	   
		     	  </form:select>
<!-- 		     	  --- -->
<!-- 			      <select class="form-control" id="llctsel" name="llctsel"> -->
<!-- 			        <option value="Cao cấp">Cao cấp</option> -->
<!-- 			        <option value="Trung cấp">Trung cấp</option> -->
<!-- 			        <option value="Sơ cấp">Sơ cấp</option> -->
<!-- 			        <option value="Tương đương">Tương đương</option> -->
<!-- 			      </select> -->
<!-- 				---- -->
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label>15.4) Quản lý nhà nước </label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:select disabled="${'true'}" path="quanLyNhaNuoc" class="form-control" id="qlnnsel" name="qlnnsel">
			        <form:option value="Chuyên viên cao cấp">Chuyên viên cao cấp</form:option>
			        <form:option value="Chuyên viên chính">Chuyên viên chính</form:option>
			        <form:option value="Chuyên viên">Chuyên viên</form:option>
			        <form:option value="Cán sự">Cán sự</form:option>
			        <form:option value="Khác">Khác</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>15.5) Ngoại ngữ</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			    	<form:select disabled="${'true'}" path="ngoaingu.maNgoaiNgu" class="form-control" id="tongiaosel" >
				              
					              <c:forEach items="${listngoaingu}" var="item">
					           	  	<option value=${item.maNgoaiNgu}>${item.tenNgoaiNgu}</option>
					           	  </c:forEach>
				           	   
			       </form:select>
			      
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label>15.6) Tin học</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:select disabled="${'true'}" path="tinHoc" class="form-control" id="thsel" name="thsel">
			        <form:option value="A">A</form:option>
			        <form:option value="B">B</form:option>
			        <form:option value="C">C</form:option>
			        <form:option value="C">Khac</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>16) Ngày vào Đảng Cộng Sản Việt Nam</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="ngayVaoDang" class="form-control datepicker" type="date-time" id="nvdcstxt" name="nvdcstxt"/>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label>Ngày chính thức</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="ngayChinhThuc" class="form-control datepicker" type="date-time" id="ncttxt" name="ncttxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>17) Ngày tham gia tô chức chính trị - xã hội</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="ngayThamGiaToChucChinhTri"  class="datepicker form-control" type="date-time" id="ntgtcctxhtxt" name="ntgtcctxhtxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-2">
			      <label>18) Ngày nhập ngũ </label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="ngayNhapNgu"  class="form-control datepicker" type="date-time" id="nnntxt" name="nnntxt"/>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <label>Ngày xuất ngũ</label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="ngayXuatNgu" class="form-control datepicker" type="date-time" id="nxntxt" name="nxntxt"/>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <label>Quân hàm cao nhất</label>
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <form:input  disabled="true" path="quanHamCaoNhat"  class="form-control" type="text" id="qhcntxt" name="qhcntxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>19) Danh hiệu được phong tặng cao nhất</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:select disabled="${'true'}" path="danhHieuPhongTangCaoNhat" class="form-control" id="dhdptcnsel" name="dhdptcnsel">
			        <form:option value="Anh hùng lao động">Anh hùng lao động</form:option>
			        <form:option value="Anh hùng lực lượng vũ trang">Anh hùng lực lượng vũ trang</form:option>
			        <form:option value="Nhà giáo">Nhà giáo</form:option>
			        <form:option value="Thầy thuốc">Thầy thuốc</form:option>
			        <form:option value="Nghệ sĩ nhân dân và ưu tú">Nghệ sĩ nhân dân và ưu tú</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>20) Sở trường công tác</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input  disabled="true" path="soTruongCongTac" class="form-control" type="text" id="stcttxt" name="stcttxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-2">
			      <label>21) Khen thưởng</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="khenThuongCaoNhat" class="form-control" type="text" placeholder="Hình thức cao nhất, năm nào" id="kttxt" />
			    </div>
			    <div class="col-xs-12 col-md-2">
			      <label>22) Kỷ luật</label>
			    </div>
			    <div class="col-xs-12 col-md-5">
			      <form:input  disabled="true" path="kyLuatCaoNhat" class="form-control" type="text" placeholder="Về đảng, chính quyền, đoàn thể hình thức cao nhất, năm nào" id="kltxt" name="kltxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-6 col-md-3">
			      <label>23) Tình trạng sức khỏe</label>
			    </div>
			    <div class="col-xs-6 col-md-3">
			      <form:input  disabled="true" path="tinhTrangSucKhoe" type="text" class="form-control" id="ttsktxt" name="ttsktxt"/>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <label>Chiều cao</label>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <form:input  disabled="true" path="chieuCao" class="number form-control" placeholder="cm" id="cctxt" name="cctxt"/>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <label>Cân nặng</label>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <form:input  disabled="true" path="canNang" class="number form-control" placeholder="kg" id="cntxt" name="cntxt"/>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <label>Nhóm máu</label>
			    </div>
			    <div class="col-xs-6 col-md-1">
			      <form:select disabled="${'true'}" path="nhomMau" class="form-control" id="nmsel" name="nmsel">
			        <form:option value="A">A</form:option>
			        <form:option value="B">B</form:option>
			        <form:option value="AB">AB</form:option>
			        <form:option value="O">O</form:option>
			        <form:option value="Khác">Khác</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>24) Là thương bình hạng</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="laThuongBinhHang" class="form-control" type="text" id="ltbhtxt" name="ltbhtxt"/>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label>Là con gia đình chính sách</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:select disabled="${'true'}" path="laConGiaDinhChinhSach" class="form-control" id="lcgdcssel" name="lcgdcssel">
			        <form:option value="Không">Không</form:option>
			        <form:option value="Con thương bình">Con thương bình</form:option>
			        <form:option value="Con liệt sĩ">Con liệt sĩ</form:option>
			        <form:option value="Người nhiễm chất độc màu da cam Dioxin">Người nhiễm chất dộc màu da cam Dioxin</form:option>
			      </form:select>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>Số chứng minh nhân dân </label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="soCmnd" class="form-control numberonly" id="scmndtxt" name="scmndtxt"/>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <label>Ngày cấp</label>
			    </div>
			    <div class="col-xs-12 col-md-3">
			      <form:input  disabled="true" path="ngayCap" class="form-control datepicker" type="date-time" id="nctxt" name="nctxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="col-xs-12 col-md-3">
			      <label>Số sổ bảo hiểm xã hội</label>
			    </div>
			    <div class="col-xs-12 col-md-9">
			      <form:input  disabled="true" path="soBhxh" type="text" class="form-control" id="ssbhxhtxt" name="ssbhxhtxt"/>
			    </div>
			  </div>
			  <div class="row">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <label>27) Đào tạo, bồi dưỡng về chuyên môn, nghiệp vụ, lý luận chính trị, ngoại ngữ, tin học.</label>
			      </div>
			      <div class="panel-body">
			        <div class="table-responsive">
			        	 
			          <table class="table table-hover" id="tableDTBD">
			            <thead>
			              <tr>
			                <th><label>Tên trường</label></th>
			                <th><label>Chuyên ngành đào tạo, bồi dưỡng</label></th>
			                <th><label>Từ tháng, năm</label></th>
			                <th><label>Đến tháng, năm</label></th>
			                <th><label>Hình thức đào tạo</label></th>
			                <th><label>Văn bằng, chứng chỉ, trình độ gì</label></th>
			                <th></th>
			              </tr>
			            </thead>
			            <tbody id="tbodyDTBD">
			            
			            	<c:forEach items="${Lylich.ldtcm}" var="item" varStatus="loop"> 
 
			             			  <tr>
				             			  <td>
				             			  	<input disabled="true" type="text" class="form-control" id="ldtcm[${loop.index}].truong" name="ldtcm[${loop.index}].truong" value = "${item.truong}">
				             			  </td>
			             			  <td>
			             			 	 <input disabled="true" type="text" class="form-control" id="ldtcm[${loop.index}].chuyenNganhDaoTao" name="ldtcm[${loop.index}].chuyenNganhDaoTao" value = " ${item.chuyenNganhDaoTao}">
			             			  </td>
			             			  <td>
			             			  	<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="ldtcm[${loop.index}].tuNgay" name="ldtcm[${loop.index}].tuNgay" value = "${item.tuNgay}">
			             			  </td>
			             			  <td>
			             			  	<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="ldtcm[${loop.index}].toiNgay" name="ldtcm[${loop.index}].toiNgay" value = "${item.toiNgay}">
			             			  </td>
			             			  <td>
			             			  	<form:select disabled="${'true'}" class="form-control" id="ldtcm[${loop.index}].hinhThucDaoTao" path="ldtcm[${loop.index}].hinhThucDaoTao">
				             			  <form:option value="Chính quy">Chính quy</form:option>
				             			  <form:option value="Tại chức">Tại chức</form:option>
				             			  <form:option value="Chuyên tu">Chuyên tu</form:option>
				             			  <form:option value="Bồi dưỡng">Bồi dưỡng</form:option>
			             			  	</form:select>
			             			  </td>
			             			  <td>
				             			  <form:select disabled="${'true'}" class="form-control" id="ldtcm[${loop.index}].chungChiDatDuoc" path="ldtcm[${loop.index}].chungChiDatDuoc">
					             			  <form:option value="Tiến sĩ khoa học">Tiến sĩ khoa học</form:option>
					             			  <form:option value="Tiến sĩ">Tiến sĩ</form:option>
					             			  <form:option value="Thạc sĩ">Thạc sĩ</form:option>
					             			  <form:option value="Cử nhân">Cử nhân</form:option>
					             			  <form:option value="Kỹ sư">Kỹ sư</form:option>
				             			  </form:select>
			             			  </td>
			             			  <td>
			             			   
			             			  </td>
			             			  </tr>
			               

			              	</c:forEach>
			            </tbody>
			          </table>
			           </div>
			      </div>
			    </div>
			  </div>
			  <div class="row">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <label>28) Tóm tắt quá trình công tác</label>
			      </div>
			      <div class="panel-body">
			        <div class="table-responsive">
			          <table class="table table-hover" id="tableQTCT">
			            <thead>
			              <tr>
			                <th><label>Từ tháng năm</label></th>
			                <th><label>Đến tháng năm</label></th>
			                <th><label>Chức danh, chức vụ, đơn vị công tác(Đảng, chính quyền, đoàn thể, tổ chức xã hội), kể cả thời gian được đào tạo, bồi dưỡng về chuyên môn, nghiệp vụ,...</label></th>
			                <th></th>
			              </tr>
			            </thead>
			            <tbody id="tbodyQTCT" >
			              	<c:forEach items="${Lylich.lsct}" var="item" varStatus="loop"> 
			              			 <tr>
				              			 <td>
				              			 	<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="lsct[${loop.index}].tuNgay" name="lsct[${loop.index}].tuNgay" value ="${item.tuNgay}">
				              			 </td>
				              			 <td>
				              			 	<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="lsct[${loop.index}].toiNgay" name="lsct[${loop.index}].toiNgay" value ="${item.toiNgay}">
				              			 </td>
				              			 <td>
				              			 	<input disabled="true" class="form-control " type="text" id="lsct[${loop.index}].chucVu" name="lsct[${loop.index}].chucVu"  value ="${item.chucVu}">
				              			 </td>
				              			 <td>
				              			 	 
				              			 </td>
			              			 </tr>

			              
			             	 </c:forEach>
			              
			            </tbody>
			          </table>
			          </div>
			      </div>
			      <div class="panel-footer"> </div>
			    </div>
			  </div>
			  <div class="row">
			    <label>29) Đặc điểm lịch sử bản thân</label>
			  </div>
			  <div class="row">
			    <label>Khai rõ: Bị bắt, bị tù (từ ngày thángn ăm nào đến ngày tháng năm nào, ở đâu), đã khai báo cho ai, những vấn đề gì? Bản thân có làm việc tỏng chế độ cũ(cơ quan, đơn vị nào, địa điểm, chức danh, chức vụ, thời gian làm việc...)</label>
			  </div>
			  <div class="row">
			    <form:textarea disabled="true" path="dacdienlichsubanthan.noidung1"  class="form-control" id="bbbttxt" name="bbbttxt" value ="${dacdienlichsubanthan.noidung1}"></form:textarea>
			  </div>
			  <div class="row">
			    <label>Tham gia hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)</label>
			  </div>
			  <div class="row">
			    <form:textarea disabled="true" path="dacdienlichsubanthan.noidung2" class="form-control" id="tghqhtxt" name="tghqhtxt" value ="${dacdienlichsubanthan.noidung1}"></form:textarea>
			  </div>
			  <div class="row">
			  <label>
			  Có thân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (làm gì, địa chỉ....)?
			  </label>
			  </div>
			  <div class="row">
			    <form:textarea disabled="true" path="dacdienlichsubanthan.noiDung3" class="form-control" id="ctntxt" name="ctntxt" value ="${dacdienlichsubanthan.noiDung3}"></form:textarea>
			  </div>
			  <div class="row">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <label>30) Quan hệ gia đình</label>
			      </div>
			      <div class="panel-body">
			        <div class="panel panel-default">
			          <div class="panel-heading">
			            <label>a) Về bản thân: Cha, Mẹ, Vợ(hoặc chồng), các con, anh chị em ruột</label>
			          </div>
			          <div class="panel-body">
			            <div class="table-responsive">
			              <table class="table table-hover" id="tableVBT">
			                <thead>
			                  <tr>
			                    <th><label>Mối quan hệ</label></th>
			                    <th><label>Họ và tên</label></th>
			                    <th><label>Năm sinh</label></th>
			                    <th><label>Quê quán, nghề nghiệp, chức danh, chức vụ, đơn vị công tác, học tập, nơi ở(trong, ngoài nước); thành viên các tổ chức chính trị - xã hội...)</label></th>
			                    <th></th>
			                  </tr>
			                </thead>
			                <tbody id="tbodyVBT">
			                	<c:forEach items="${Lylich.lqhbt}" var="item" varStatus="loop"> 
 										<tr>
	 										<td>
	 											<input disabled="true" type="text" class="form-control" id="lqhbt[${loop.index}].quanHe" name="lqhbt[${loop.index}].quanHe" value ="${item.quanHe}">
	 										</td>
	 										<td>
	 											<input disabled="true" type="text" class="form-control" id="lqhbt[${loop.index}].hoTen" name="lqhbt[${loop.index}].hoTen" value ="${item.hoTen}">
	 										</td>
	 										<td>
	 											<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="lqhbt[${loop.index}].ngaySinh" name="lqhbt[${loop.index}].ngaySinh" value ="${item.ngaySinh}">
	 										</td>
	 										<td>
	 											<input disabled="true" class="form-control" type="text" id="lqhbt[${loop.index}].ghiChu" name="lqhbt[${loop.index}].ghiChu" value ="${item.ghiChu}">
	 										</td>
	 										<td>
	 											 
	 										</td>
 										</tr>
								</c:forEach>
			                </tbody>
			              </table>
			                </div>
			          </div>
			        </div>
			        <div class="panel panel-default">
			          <div class="panel-heading">
			            <label>b) Về bên vợ(hoặc chồng): Cha, Mẹ, anh chị em ruột</label>
			          </div>
			          <div class="panel-body">
			            <div class="table-responsive">
			              <table class="table table-hover" id="tableVBV">
			                <thead>
			                  <tr>
			                    <th><label>Mối quan hệ</label></th>
			                    <th><label>Họ và tên</label></th>
			                    <th><label>Năm sinh</label></th>
			                    <th><label>Quê quán, nghề nghiệp, chức danh, chức vụ, đơn vị công tác, học tập, nơi ở(trong, ngoài nước); thành viên các tổ chức chính trị - xã hội...)</label></th>
			                    <th></th>
			                  </tr>
			                </thead>
			                <tbody id="tbodyVBV">
 								 <c:forEach items="${Lylich.lqhdt}" var="item" varStatus="loop"> 
 										<tr>
	 										<td>
	 											<input disabled="true" type="text" class="form-control" id="lqhdt[${loop.index}].quanHe" name="lqhdt[${loop.index}].quanHe" value ="${item.quanHe}">
	 										</td>
	 										<td>
	 											<input disabled="true" type="text" class="form-control" id="lqhđt[${loop.index}].hoTen" name="lqhđt[${loop.index}].hoTen" value ="${item.hoTen}">
	 										</td>
	 										<td>
	 											<input disabled="true" class="form-control datepicker hasDatepicker" type="date-time" id="lqhdt[${loop.index}].ngaySinh" name="lqhdt[${loop.index}].ngaySinh" value ="${item.ngaySinh}">
	 										</td>
	 										<td>
	 											<input disabled="true" class="form-control" type="text" id="lqhdt[${loop.index}].ghiChu" name="lqhdt[${loop.index}].ghiChu" value ="${item.ghiChu}">
	 										</td>
	 										<td>
	 											 
	 										</td>
 										</tr>
								</c:forEach>
			                </tbody>
			              </table>
			                </div>
			          </div>
			        </div>
			      </div>
			      <div class="panel-footer"> </div>
			    </div>
			  </div>
			  <div class="row">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <label>31) Diễn biến quá trình lương của cán bộ, công chức</label>
			      </div>
			      <div class="panel-body">
			        <div class="table-responsive">
			          <table class="table table-hover" id="tableDBL">
			            <thead>
			              <tr>
			                <th><label>Tháng/Năm</label></th>
			                <th><labeL>Mã ngạch/bậc</labeL></th>
			                <th><label>Hệ số lương</label></th>
			                <th></th>
			              </tr>
			            </thead>
			            <tbody id="tbodyDBL">
			           		 <c:forEach items="${Lylich.ldbl}" var="item" varStatus="loop"> 
 								<tr>
	 								<td>
	 									<input disabled="true" class="form-control datepicker-month hasDatepicker" id="ldbl[${loop.index}].ngaythang" name="ldbl[${loop.index}].lngaythang" value ="${item.lngaythang}">
	 								</td>
	 								<td>
	 									<input disabled="true" class="form-control number" id="ldbl[${loop.index}].lmangach_bac" name="ldbl[${loop.index}].lmangach_bac" value ="${item.lmangach_bac}">
	 								</td>
	 								<td>
	 									<input disabled="true" class="form-control number" id="ldbl[${loop.index}].heSoLuong" name="ldbl[${loop.index}].heSoLuong" value ="${item.heSoLuong}">
	 								</td>
	 								<td>
	 									 
	 								</td>
 								</tr>
							</c:forEach>
			            </tbody>
			          </table>
			             </div>
			      </div>
			    </div>
			  </div>
			  <div class="row">
			    <label>32) Nhận xét, đánh giá của cơ quan, đơn vị quản lý và sử dụng cán bộ, công chức</label>
			  </div>
			  <div class="row">
			    <form:textarea disabled="true" path="nhanXetCapTren" class="form-control" id="nxdgtxt1" name="nxdgtxt1"></form:textarea>
			  </div>
			   <div class="row">
			     <input type="submit" value ="Lưu"/>
			  </div>
			  </div>
			</form:form>
	
		</sec:authorize>
	
	</div>				
	<!---footer--->
	<%@include file="../layout/footer.jsp" %>
	<!---footer--->
<%-- <script src="<c:url value="/resources/lylich_canbo/js/jquery-2.2.2.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/bootstrap.min.js"/>"></script> --%>
<script src="<c:url value="/resources/lylich_canbo/js/jquery-ui.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/myjs.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/create.js"/>"></script>




<div id='myModal' class='modal fade in'>
    <div class="modal-dialog">
	        <div class="modal-content">
	            <div id='myModalContent'></div>
	        </div>
	    </div>
	</div>
	<script>
	$('document').ready(function(){
		
	
		$(function () {
	
	    $.ajaxSetup({ cache: false });
	
	    $("a[data-modal]").on("click", function (e) {
	
	        // hide dropdown if any
	        $(e.target).closest('.btn-group').children('.dropdown-toggle').dropdown('toggle');
	
	        
	        $('#myModalContent').load(this.href, function () {
	            
	
	            $('#myModal').modal({
	                /*backdrop: 'static',*/
	                keyboard: true
	            }, 'show');
	
	            bindForm(this);
	        });
	
	        return false;
	    });
	
	
	});
	
	function bindForm(dialog) {
	    
	    $('form', dialog).submit(function () {
	        $.ajax({
	            url: this.action,
	            type: this.method,
	            data: $(this).serialize(),
	            success: function (result) {
	                if (result=="1") {
	                    $('#myModal').modal('hide');
	                    //Refresh
	                    location.reload();
	                } else {
	                    $('#myModalContent').html(result);
	                    bindForm();
	                }
	            }
	        });
	        return false;
	    });
	}
	})
	
	</script>
</body>
</html>