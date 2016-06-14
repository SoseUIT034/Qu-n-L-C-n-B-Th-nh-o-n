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

<title>Thêm mới trình độ chuyên môn</title>


</head>
<body ">

	<!---header--->
	<%@include file ="../layout/header.jsp" %>
	<!---header--->
	
	<div class="content" style="padding-top: 30px; ">
 		<c:url var="actionUrl"  value="create" />
 		<sec:authorize access="hasAnyRole('Admin')">
		<form:form class="container" commandName="ngoaingu" action="createngoaingu" style="border: rebeccapurple; border-style: dotted;" method="POST" >
			   
			  <div class="row" disabled="true" style="display:none;">
			    <div class="col-xs-12 col-md-4">
			      <label>Mã ngoại ngữ</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input path="maNgoaiNgu"   class="form-control" type="text"/> 
			    </div> 
			  </div>
			 <div class="row">
			    <div class="col-xs-12 col-md-4">
			      <label>Tên ngoại ngữ</label>
			    </div>
			    <div class="col-xs-12 col-md-8">
			      <form:input path="tenNgoaiNgu"  class="form-control" type="text"/> 
			      <form:errors path="tenNgoaiNgu" class="btn btn-danger"></form:errors>
			    </div> 
			  </div>
			  
			  <div class="row">
			    <button type="submit" class="btn btn-default btn-primary btn-lg" value="luu" id="luuButton" name="luuButton" > <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"> Lưu</span> </button>
			    <button type="button" class="btn btn-default btn-warning btn-lg" id="huyButton" name="huy" data-toggle='modal' data-target='#myModal'> <span class="glyphicon glyphicon-remove" aria-hidden="true"> Hủy</span> </button>
			    <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
			      <div class="modal-dialog">
			        <div class="modal-content">
			          <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			            <h4 class="modal-title">Cảnh báo!</h4>
			          </div>
			          <div class="modal-body">
			            <p>Bạn có chắc chắn muốn hủy??? </p>
			          </div>
			          <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">Không</button>
			            <button type="submit" class="btn btn-primary" id="xacnhan" name="xacnhanhuy">Tôi chắc chắn!</button>
			          </div>
			        </div>
			        <!-- /.modal-content --> 
			      </div>
			      <!-- /.modal-dialog --> 
			    </div>
			    <!-- /.modal --> 
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
</body>
</html>