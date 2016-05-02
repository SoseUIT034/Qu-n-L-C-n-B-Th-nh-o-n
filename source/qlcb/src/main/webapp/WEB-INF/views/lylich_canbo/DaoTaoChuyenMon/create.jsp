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
  
<title> </title>


</head>
<body>
	<form:form  class="clearfix" commandName="Daotaochuyenmon" action="${pageContext.request.contextPath}/chuyenmon/create"  method="POST" >
		<div  class="col-md-12">
			

			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Tên trường </label>
				</div>
				<div class=" col-xs-12 col-md-8">
					<form:input path="truong"  class="form-control" type="text"/>
				</div>
			</div>
			<div class=" col-xs-12 col-md-12">
				<div class=" col-xs-12 col-md-4">
					 <label>Từ ngày </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="tuNgay"  class="form-control" type="date-time"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Tới ngày </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="toiNgay"  class="form-control" type="date-time"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-md-4">
					 <label>Chuyên ngành đào tạo </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="chuyenNganhDaoTao"  class="form-control" type="text"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Hình thức đào tạo </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:select class="form-control" path="hinhThucDaoTao">
				             			  <option value="Chính quy">Chính quy</option>
				             			  <option value="Tại chức">Tại chức</option>
				             			  <option value="Chuyên tu">Chuyên tu</option>
				             			  <option value="Bồi dưỡng">Bồi dưỡng</option>
			        </form:select>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>chứng chỉ đạt được </label> 
				</div>
				<div class="col-xs-12 col-md-8">
					<form:select class="form-control" path="chungChiDatDuoc">
					             			  <option value="Tiến sĩ khoa học">Tiến sĩ khoa học</option>
					             			  <option value="Tiến sĩ">Tiến sĩ</option>
					             			  <option value="Thạc sĩ">Thạc sĩ</option>
					             			  <option value="Cử nhân">Cử nhân</option>
					             			  <option value="Kỹ sư">Kỹ sư</option>
				     </form:select>
				</div>
			</div> 
			<input type="submit" value = "lưu"/>
			<input type="button" data-dismiss="modal" value = "đóng"/>
		</div>
		
	</form:form>
	


</body>
