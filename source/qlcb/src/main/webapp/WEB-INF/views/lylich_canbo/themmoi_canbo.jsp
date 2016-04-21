<!DOCTYPE html>
<%@page import="java.nio.charset.Charset"%>
<%@page import="javax.sound.sampled.AudioFormat.Encoding"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en">
<head>
<!-- <c:url value="/resources/lylich_canbo/css/bootstrap.min.css"/> -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/bootstrap.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/jquery-ui.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/MyStyle.css"/>">

<script src="<c:url value="/resources/lylich_canbo/js/jquery-1.12.2.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/jquery-ui.js"/>"></script>
<script src="<c:url value="/resources/lylich_canbo/js/myjs.js"/>"></script>

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
<script>
    
</script>

</head>
<body tyle="background-color: #fff;">

	<!---header--->
	 
	<%@include file="../layout/header.jsp" %>
	<!---header--->
	
	<div class="content" style="padding-top: 30px; ">
		<form class="container" style="border: rebeccapurple; border-style: dotted;">
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		      <label>Cơ quan, đơn vị có thẩm quyền quản lý cán bộ công chức</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		      <input class="form-control" type="text"/>
		    </div>
		    <div class="col-xs-12 col-md-3">
		      <label> Số hiệu cán bộ, công chức </label>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <input class="form-control" type="text"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4" >
		      <label>Cơ quan, đơn vị sử dụng cán bộ công chức </label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		      <input type="text" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div style="text-align:center; font-size:48px;" class="uppercase col-xs-12 col-md-12"> <b>sơ yếu lý lịch cán bộ, công chức </b> </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		            <div class="form-group">
		                 <img id="imgPreview" style="max-width:100%; max-height::100%;" src="../../resources/lylich_canbo/images/IMG_2892.jpg" alt="Ảnh đại diện"/> 
		            </div>
		            <div class="form-group" style="vertical-align:bottom">
		                <label>File upload</label>
		                <input type="file" id="fileUpload"/>
		            </div>
		    </div>
		    <div class="col-xs-12 col-md-9">
		      <div class="container-fluid">
		        <div class="row">
		          <div class="col-xs-12 col-md-3">
		            <label> 1) Họ và tên khai sinh </label>
		          </div>
		          <div class="col-xs-12 col-md-9">
		            <input class="form-control text-uppercase" type="text"/>
		          </div>
		        </div>
		        <div class="row">
		          <div class="col-xs-12 col-md-3">
		            <label>2) Tên gọi khác</label>
		          </div>
		          <div class="col-xs-12 col-md-9">
		            <input type="text" class="form-control"/>
		          </div>
		        </div>
		        <div class="row">
		          <div class="col-xs-12 col-md-3">
		            <label>3) Sinh ngày </label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <input class="datepicker form-control" type="date"/>
		          </div>
		          <div class="col-xs-12 col-md-3" style="text-align:right">
		            <label>Giới tính: </label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <select class="form-control">
		              <option value="Name">Nam</option>
		              <option value="Nữ">Nữ</option>
		            </select>
		          </div>
		        </div>
		        <div class="row">
		        <p></p>
		          <div class="col-xs-12 col-md-3">
		            <label>4) Nơi sinh: Tỉnh</label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <select class="form-control tinhDiaChi" id="noiSinhTinh">
		                <option value="">Chọn tỉnh</option>
		            </select>
		          </div>
		          <div class="col-xs-12 col-md-1">
		            <label>Huyện</label>
		          </div>
		          <div class="col-xs-12 col-md-2">
		            <select class="form-control" id="noiSinhHuyen">
		            </select>
		          </div>
		          <div class="col-xs-12 col-md-1">
		            <label>Xã</label>
		          </div>
		          <div class="col-xs-12 col-md-2">
		            <select class="form-control" id="noiSinhXa">
		            </select>
		          </div>
		        </div>
		        <div class="row">
		          <div class="col-xs-12 col-md-3">
		            <label>5) Quê quán: Tỉnh</label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <select class="form-control tinhDiaChi" id="queQuanTinh">
		                <option value="">Chọn tỉnh</option>            
		            </select>
		          </div>
		          <div class="col-xs-12 col-md-1">
		            <label>Huyện</label>
		          </div>
		          <div class="col-xs-12 col-md-2">
		            <select class="form-control" id="queQuanHuyen">
		            </select>
		          </div>
		          <div class="col-xs-12 col-md-1">
		            <label>Xã</label>
		          </div>
		          <div class="col-xs-12 col-md-2">
		            <select class="form-control" id="queQuanXa">
		            </select>
		          </div>
		        </div>
		        <div class="row">
		          <div class="col-xs-12 col-md-3">
		            <label>6, Dân tôc: </label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <select class="form-control">
		              <option value="0">Khác</option>
		              <option value="1">Kinh</option>
		              <option value="2">Chăm</option>
		              <option value="3">Hoa</option>
		              <option value="4">Thái</option>
		              <option value="5">Tày</option>
		              <option value="6">Nùng</option>
		            </select>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <label>7) Tôn giáo</label>
		          </div>
		          <div class="col-xs-12 col-md-3">
		            <select class="form-control">
		              <option value="0">Không</option>
		              <option value="1">Khác</option>
		              <option value="2">Phật Giáo</option>
		              <option value="3">Cao Đài</option>
		              <option value="4">Hòa Hảo</option>
		              <option value="5">Thiên Chúa</option>
		              <option value="6">Ấn Độ Giáo</option>
		              <option value="7">Hiếu Nghĩa</option>
		            </select>
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
		      <input class="form-control" placeholder="Số nhà, đường phố, thành phố, xóm, thôn, xã, huyện, tỉnh"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		      <label>9) Nơi ở hiện nay </label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		      <input class="form-control" placeholder="Số nhà, đường phố, thành phố, xóm, thôn, xã, huyện, tỉnh"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		      <label>10) Nghề nghiệp khi được tuyển dụng</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		      <input type="text" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		      <label>11) Ngày tuyển dụng</label>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <input type="date" class="form-control datepicker"/>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <label>Cơ quan tuyển dụng</label>
		    </div>
		    <div class="col-xs-12 col-md-4">
		      <input type="text" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		      <label>12) Chức vụ (chức danh) hiện tại</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		      <select class="form-control">
		        <option value="0">Chức Vụ Khác</option>
		        <option value="1">Bí Thư</option>
		        <option value="2">Giám Đốc</option>
		        <option value="3">Phó Bí Thư</option>
		        <option value="4">Phó Giám Đốc</option>
		        <option value="5">Thường Trực</option>
		        <option value="6">Thường Vụ</option>
		        <option value="7">Thành Viên Hội Đồng</option>
		        <option value="8">Ủy Viên Ban Chấp Hành</option>
		        <option value="9">Trưởng Ban</option>
		        <option value="10">Kế Toán Trưởng</option>
		        <option value="11">Trưởng Phòng</option>
		        <option value="12">Phó Ban</option>
		        <option value="13">Kế Toán Phó</option>
		        <option value="14">Phó Phòng</option>
		        <option value="15">Cán Bộ</option>
		        <option value="16">Nhân Viên</option>
		      </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4" >
		      <label>13) Công việc chính được giao</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		      <input type="text" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4"  >
		      <label>14) Ngạch công chức (viên chức) </label>
		    </div>
		    <div class="col-xs-12 col-md-4">
		      <select class="form-control" id="MaNgachList" >
		        <option value="00000">Không hưởng lương</option>
		        <option value="01.001">Chuyên viên cao cấp</option>
		        <option value="01.002">Chuyên viên chính</option>
		        <option value="01.003">Chuyên viên</option>
		        <option value="01.004">Cán sự </option>
		        <option value="01.005">Kỹ thuật viên đánh máy</option>
		        <option value="01.006">Nhân viên đánh máy</option>
		        <option value="01.007">Nhân viên kỹ thuật</option>
		        <option value="01.008">Nhân viên văn thư</option>
		        <option value="01.009">Nhân vien phục vụ</option>
		        <option value="01.010">Lái xe cơ quan</option>
		        <option value="01.011">Nhân viên bảo vệ</option>
		        <option value="01.015">Kỹ thuật viên trung cấp</option>
		        <option value="02.012">Lưu trữ viên cao cấp</option>
		        <option value="02.013">Lưu trữ viên chính</option>
		        <option value="02.014">Lưu trữ viên</option>
		        <option value="02.006">Kỹ thuật viên lưu trữ</option>
		        <option value="03.017">Chấp hành viên tỉnh, thành pố trực thuộc Trung ương</option>
		        <option value="03.018">Chấp hành viên quận, huyện, thị xã, thành pố thuộc tỉnh</option>
		        <option value="03.019">Công chứng viên</option>
		        <option value="04.023">Thanh tra viên cao cấp</option>
		        <option value="04.024">Thanh tra viên chính</option>
		        <option value="04.025">Thanh tra viên</option>
		        <option value="06.029">Kế toàn viên cao cấp</option>
		        <option value="06.030">Kế toán viên chính</option>
		        <option value="06.031">Kế toán viên</option>
		        <option value="06.032">Kế toán viên trung cấp</option>
		        <option value="06.033">Kế toán viên sơ cấp</option>
		        <option value="06.034">Thủ quỹ có bạc, ngân hàng</option>
		        <option value="06.035">Thủ quỹ cơ quan, đơn vị</option>
		        <option value="06.036">Kiểm soát viên cao cấp thuế</option>
		        <option value="06.037">Kiểm soát viên chính thuế</option>
		        <option value="06.038">Kiếm soát viên thuế</option>
		        <option value="06.039">Kiếm thu viên thuế</option>
		        <option value="06.040">Nhân viên thuế </option>
		      </select>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <label>Mã ngạch</label>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <input type="text" id="MaNgach" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-6 col-md-2">
		      <label>Bậc lương</label>
		    </div>
		    <div class="col-xs-6 col-md-2">
		      <input class="number form-control" />
		    </div>
		    <div class="col-xs-6 col-md-2">
		      <label >Hệ số</label>
		    </div>
		    <div class="col-xs-6 col-md-2">
		      <input class="number form-control"/>
		    </div>
		    <div class="col-xs-6 col-md-2">
		      <label>Ngày hưởng</label>
		    </div>
		    <div class="col-xs-6 col-md-2">
		      <input class="datepicker form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-6 col-md-2">
		      <label>Phụ cấp chức vụ </label>
		    </div>
		    <div class="col-xs-6 col-md-4">
		      <input class="number form-control"/>
		    </div>
		    <div class="col-xs-6 col-md-3">
		      <label> Phụ cấp khác </label>
		    </div>
		    <div class="col-xs-6 col-md-3">
		      <input class="number form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-6"    >
		      <label>15.1) Trình độ giáo dục phổ thông(Đã tốt nghiệp lớp mấy/thuộc thệ nào) </label>
		    </div>
		    <div class="col-xs-12 col-md-6">
		      <select class="form-control">
		        <option value="1">1/12</option>
		        <option value="2">2/12</option>
		        <option value="3">3/12</option>
		        <option value="4">4/12</option>
		        <option value="5">5/12</option>
		        <option value="6">6/12</option>
		        <option value="7">7/12</option>
		        <option value="8">8/12</option>
		        <option value="9">9/12</option>
		        <option value="10">10/12</option>
		        <option value="11">11/12</option>
		        <option value="12">12/12</option>
		      </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-6">
		      <label>15.2) Trình độ chuyên môn cao nhất</label>
		    </div>
		    <div class="col-xs-12 col-md-6">
		      <select class="form-control">
		        <option value="12.00">Chưa có bằng CM</option>
		        <option value="14.00">Trung cấp</option>
		        <option value="14.50">TC Chuyên Nghiệp</option>
		        <option value="15.00">Cao đẳng</option>
		        <option value="16.00">Cử nhân</option>
		        <option value="16.50">Kỹ sư</option>
		        <option value="18.00">Thạc Sỹ</option>
		        <option value="20.00">Tiến Sỹ</option>
		        <option value="22.00">Tiến Sỹ Khoa Học</option>
		      </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		      <label>15.3) Lý luận chính trị </label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		      <select class="form-control">
		        <option value="Cao cấp">Cao cấp</option>
		        <option value="Trung cấp">Trung cấp</option>
		        <option value="Sơ cấp">Sơ cấp</option>
		        <option value="Tương đương">Tương đương</option>
		      </select>
		    </div>
		    <div class="col-xs-12 col-md-3">
		      <label>15.4) Quản lý nhà nước </label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		      <select class="form-control">
		        <option value="Chuyên viên cao cấp">Chuyên viên cao cấp</option>
		        <option value="Chuyên viên chính">Chuyên viên chính</option>
		        <option value="Chuyên viên">Chuyên viên</option>
		        <option value="Cán sự">Cán sự</option>
		      </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		        <label>15.5) Ngoại ngữ</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <select class="form-control">
		            <option value="0">Không</option>
		            <option value="1">Anh</option>
		            <option value="2">Pháp</option>
		            <option value="3">Nhật</option>
		            <option value="4">Hàn Quốc</option>
		            <option value="5">Hoa</option>
		            <option value="6">Thái</option>
		        </select>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <label>15.6) Tin học</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <select class="form-control">
		            <option value="A">A</option>
		            <option value="B">B</option>
		            <option value="C">C</option>
		        </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		        <label>16) Ngày vào Đảng Cộng Sản Việt Nam</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control datepicker" type="date"/>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <label>Ngày chính thức</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control datepicker" type="date"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		        <label>17) Ngày tham gia tô chức chính trị - xã hội</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		        <input class="datepicker form-control" type="date"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-2">
		        <label>18) Ngày nhập ngũ </label>
		    </div>
		     <div class="col-xs-12 col-md-2">
		        <input class="form-control datepicker" type="date"/>
		    </div>
		    <div class="col-xs-12 col-md-2">
		      <label>Ngày xuất ngũ</label>
		    </div>
		    <div class="col-xs-12 col-md-2">
		        <input class="form-control datepicker" type="date"/>
		    </div>
		    <div class="col-xs-12 col-md-2">
		        <label>Quân hàm cao nhất</label>
		    </div>
		    <div class="col-xs-12 col-md-2">
		        <input class="form-control" type="text"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		        <label>19) Danh hiệu được phong tặng cao nhất</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		        <select class="form-control">
		            <option value="Anh hùng lao động">Anh hùng lao động</option>
		            <option value="Anh hùng lực lượng vũ trang">Anh hùng lực lượng vũ trang</option>
		            <option value="Nhà giáo">Nhà giáo</option>
		            <option value="Thầy thuốc">Thầy thuốc</option>
		            <option value="Nghệ sĩ nhân dân và ưu tú">Nghệ sĩ nhân dân và ưu tú</option>
		        </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-4">
		        <label>20) Sở trường công tác</label>
		    </div>
		    <div class="col-xs-12 col-md-8">
		        <input class="form-control" type="text"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-2">
		        <label>21) Khen thưởng</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control" type="text" placeholder="Hình thức cao nhất, năm nào"/>
		    </div>
		    <div class="col-xs-12 col-md-2">
		        <label>22) Kỷ luật</label>
		    </div>
		    <div class="col-xs-12 col-md-5">
		        <input class="form-control" type="text" placeholder="Về đảng, chính quyền, đoàn thể hình thức cao nhất, năm nào"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-6 col-md-3">
		        <label>23) Tình trạng sức khỏe</label>
		    </div>
		    <div class="col-xs-6 col-md-3">
		        <input type="text" class="form-control"/>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <label>Chiều cao</label>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <input class="number form-control" placeholder="cm"/>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <label>Cân nặng</label>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <input class="number form-control" placeholder="kg"/>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <label>Nhóm máu</label>
		    </div>
		    <div class="col-xs-6 col-md-1">
		        <select class="form-control">
		            <option value="A">A</option>
		            <option value="B">B</option>
		            <option value="AB">AB</option>
		            <option value="O">O</option>
		        </select>
		    </div>
		    
		  </div>  
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		        <label>24) Là thương bình hạng</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control" type="text"/>
		    </div>  
		    <div class="col-xs-12 col-md-3">
		        <label>Là con gia đình chính sách</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <select class="form-control">
		            <option value="Con thương bình">Con thương bình</option>
		            <option value="Con liệt sĩ">Con liệt sĩ</option>
		            <option value="Người nhiễm chất độc màu da cam Dioxin">Người nhiễm chất dộc màu da cam Dioxin</option>
		        </select>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		        <label>Số chứng minh nhân dân </label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control numberonly"/> 
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <label>Ngày cấp</label>
		    </div>
		    <div class="col-xs-12 col-md-3">
		        <input class="form-control datepicker" type="date"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="col-xs-12 col-md-3">
		        <label>Số sổ bảo hiểm xã hội</label>
		    </div>
		    <div class="col-xs-12 col-md-9">
		        <input type="text" class="form-control"/>
		    </div>
		  </div>
		  <div class="row">
		    <div class="panel panel-default">
		        <div class="panel-heading">
		            <label>27) Đào tạo, bồi dưỡng về chuyên môn, nghiệp vụ, lý luận chính trị, ngoại ngữ, tin học.
		        </div>
		        <div class="panel-body">
		            <div class="table-responsive">
		                <table class="table table-hover">
		                    <thead>
		                        <tr>
		                            <th><label>Tên trường</label></th>
		                            <th><label>Chuyên ngành đào tạo, bồi dưỡng</label></th>
		                            <th><label>Từ tháng, năm</label></th>
		                            <th><label>Đến tháng, năm</label></th>
		                            <th><label>Hình thức đào tạo</label></th>
		                            <th><label>Văn bằng, chứng chỉ, trình độ gì</label></th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td><input type="text" class="form-control"/></td>
		                            <td><input type="text" class="form-control"/></td>
		                            <td><input class="form-control datepicker" type="date"/></td>
		                            <td><input class="form-control datepicker" type="date"/></td>                            
		                            <td>
		                                <select class="form-control">
		                                    <option value="Chính quy">Chính quy</option>
		                                    <option value="Tại chức">Tại chức</option>
		                                    <option value="Chuyên tu">Chuyên tu</option>
		                                    <option value="Bồi dưỡng">Bồi dưỡng</option>
		                                </select>
		                            </td>
		                            <td>
		                                <select class="form-control">
		                                    <option value="Tiến sĩ khoa học">Tiến sĩ khoa học</option>
		                                    <option value="Tiến sĩ">Tiến sĩ</option>
		                                    <option value="Thạc sĩ">Thạc sĩ</option>
		                                    <option value="Cử nhân">Cử nhân</option>
		                                    <option value="Kỹ sư">Kỹ sư</option>
		                                </select>
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        <div class="panel-footer">
		        </div>
		    </div>
		  </div>
		  <div class="row">
		    <div class="panel panel-default">
		        <div class="panel-heading">
		            <label>28) Tóm tắt quá trình công tác
		        </div>
		        <div class="panel-body">
		            <div class="table-responsive">
		                <table class="table table-hover">
		                    <thead>
		                        <tr>
		                            <th><label>Từ tháng năm</label></th>
		                            <th><label>Đến tháng năm</label></th>
		                            <th><label>Chức danh, chức vụ, đơn vị công tác(Đảng, chính quyền, đoàn thể, tổ chức xã hội), kể cả thời gian được đào tạo, bồi dưỡng về chuyên môn, nghiệp vụ,...</label></th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td><input class="form-control datepicker" type="date"/></td>
		                            <td><input class="form-control datepicker" type="date"/></td>                            
		                            <td>    
		                                <input class="form-control" type="text"/>
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        <div class="panel-footer">
		        </div>
		    </div>
		  </div>
		  <div class="row">
		    <label>29) Đặc điểm lịch sử bản thân</label>
		  </div>
		  <div class="row">
		    <label>Khai rõ: Bị bắt, bị tù (từ ngày thángn ăm nào đến ngày tháng năm nào, ở đâu), đã khai báo cho ai, những vấn đề gì? Bản thân có làm việc tỏng chế độ cũ(cơ quan, đơn vị nào, địa điểm, chức danh, chức vụ, thời gian làm việc...)</label>
		  </div>
		  <div class="row">
		    <textarea class="form-control"></textarea>
		  </div>
		  <div class="row">
		    <label>Tham gia hoặc có quan hệ với các tổ chức chính trị, kinh tế, xã hội nào ở nước ngoài(làm gì, tổ chức nào, đặt trụ sở ở đâu....?)</label>
		  </div>
		  <div class="row">
		    <textarea class="form-control"></textarea>
		  </div>
		  <div class="row">
		    <label>Có thân nhân (Cha, Mẹ, Vợ, Chồng, con, anh chị em ruột) ở nước ngoài (làm gì, địa chỉ....)?
		  </div>
		  <div class="row">
		    <textarea class="form-control"></textarea>
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
		                        <table class="table table-hover">
		                            <thead>
		                                <tr>
		                                    <th><label>Mối quan hệ</label></th>
		                                    <th><label>Họ và tên</label></th>
		                                    <th><label>Năm sinh</label></th>
		                                    <th><label>Quê quán, nghề nghiệp, chức danh, chức vụ, đơn vị công tác, học tập, nơi ở(trong, ngoài nước); thành viên các tổ chức chính trị - xã hội...)</label></th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                                <tr>
		                                    <td><input type="text" class="form-control"/></td>
		                                    <td><input type="text" class="form-control"/></td>
		                                    <td><input class="form-control datepicker" type="date"/></td>
		                                    <td>
		                                        <input class="form-control" type="text"/>
		                                    </td>
		                                </tr>
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		            </div>
		            <div class="panel panel-default">
		                <div class="panel-heading">
		                    <label>a) Về bên vợ(hoặc chồng): Cha, Mẹ, anh chị em ruột</label>
		                </div>
		                <div class="panel-body">
		                    <div class="table-responsive">
		                        <table class="table table-hover">
		                            <thead>
		                                <tr>
		                                    <th><label>Mối quan hệ</label></th>
		                                    <th><label>Họ và tên</label></th>
		                                    <th><label>Năm sinh</label></th>
		                                    <th><label>Quê quán, nghề nghiệp, chức danh, chức vụ, đơn vị công tác, học tập, nơi ở(trong, ngoài nước); thành viên các tổ chức chính trị - xã hội...)</label></th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                                <tr>
		                                    <td><input type="text" class="form-control"/></td>
		                                    <td><input type="text" class="form-control"/></td>
		                                    <td><input class="form-control datepicker" type="date"/></td>
		                                    <td>
		                                        <input class="form-control" type="text"/>
		                                    </td>
		                                </tr>
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		            </div>
		        </div>
		        <div class="panel-footer">
		        </div>
		    </div>
		  </div>
		  <div class="row">
		    <div class="panel panel-default">
		        <div class="panel-heading">
		            <label>31) Diễn biến quá trình lương của cán bộ, công chức</label>
		        </div>
		        <div class="panel-body">
		            <div class="table-responsive">
		                <table class="table table-hover">
		                            <tbody>
		                                <tr>
		                                    <td><label>Tháng/Năm</label></td>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                </tr>
		                                <tr>
		                                    <td><label>Mã ngạch/bậc</label></td>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                </tr>
		                                <tr>
		                                    <td><label>Hệ số lương</label></td>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                    <td><input class="form-control number"/>
		                                </tr>
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
		    <textarea class="form-control"></textarea>
		  </div>
		</form>
	</div>				
	<!---footer--->
	<%@include file="../layout/footer.jsp" %>
	<!---footer--->

</body>
</html>