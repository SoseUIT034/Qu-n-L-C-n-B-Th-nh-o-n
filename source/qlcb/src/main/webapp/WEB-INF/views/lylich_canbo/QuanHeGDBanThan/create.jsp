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
	<form:form  class="clearfix" commandName="CanboGiadinhBanthan" action="${pageContext.request.contextPath}/QuanheGiaDinhBanThan/create"  method="POST" >
		<div  class="col-md-12">
			

			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Quan hệ </label>
				</div>
				<div class=" col-xs-12 col-md-8">
					<form:input path="quanHe"  class="form-control" type="text"/>
				</div>
			</div>
			<div class=" col-xs-12 col-md-12">
				<div class=" col-xs-12 col-md-4">
					 <label>Họ tên </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="hoTen"  class="form-control" type="text"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Ngày sinh </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="ngaySinh"  class="form-control" type="date-time"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-md-4">
					 <label>Nội dung:</label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="ghiChu"  class="form-control" type="text"/>
				</div>
			</div>
			 
			<input type="submit" value = "lưu"/>
			<input type="button" data-dismiss="modal" value = "đóng"/>
		</div>
		
	</form:form>
	


</body>
