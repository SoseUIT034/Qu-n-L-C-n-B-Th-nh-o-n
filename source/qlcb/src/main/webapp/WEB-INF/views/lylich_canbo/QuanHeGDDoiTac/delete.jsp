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
	<form:form  class="clearfix"  action="${pageContext.request.contextPath}/QuanheGiaDinhDoiTac/delete/${CanboGiadinhDoitac.id}"  method="POST" >
		<div  class="col-md-12">
			
			<input type="submit" value = "xóa"/>
			<input type="button" data-dismiss="modal" value = "đóng"/>
		</div>
		
	</form:form> 
</body>
