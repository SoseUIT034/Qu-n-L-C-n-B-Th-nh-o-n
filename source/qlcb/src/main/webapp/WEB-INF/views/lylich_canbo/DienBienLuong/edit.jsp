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
	<form:form  class="clearfix" commandName="Dienbienluong" action="${pageContext.request.contextPath}/Dienbienluong/edit"  method="POST" >
		<div  class="col-md-12">
			
			<div class=" col-xs-12 col-md-12">
				<div class=" col-xs-12 col-md-4">
					 <label>Ngày/ tháng </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="lngaythang"  class="form-control" type="date-time"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-4">
					 <label>Bậc ngạch </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="lmangach_bac"  class="form-control" type="text"/>
				</div>
			</div>
			<div class="col-xs-12 col-md-12">
				<div class="col-md-4">
					 <label>Hệ số lương </label>
				</div>
				<div class="col-xs-12 col-md-8">
					<form:input path="heSoLuong"  class="form-control" type="text"/>
				</div>
			</div>
			<input type="submit" value = "lưu"/>
			<input type="button" data-dismiss="modal" value = "đóng"/>
		</div>
		
	</form:form>
	


</body>
