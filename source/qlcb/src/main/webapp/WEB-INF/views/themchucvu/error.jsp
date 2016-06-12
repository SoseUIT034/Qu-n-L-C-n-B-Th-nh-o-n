<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lỗi</title>
</head>
<body>

<!---header--->
	<%@include file ="../layout/header.jsp" %>
	<!---header--->
	
	<div class="content" style="padding-top: 30px; ">
	<div class="container">
	<div class="row">
	<h1>Lỗi</h1>
	<div class="row">
	<hr>
	</div>
	</div>
	<div class="row">
	<h3>${ error }</h3>
	</div>
	</div>
	</div>
	
		<!---footer--->
	<%@include file="../layout/footer.jsp" %>
	<!---footer--->
	
<script src="<c:url value="/resources/lylich_canbo/js/jquery-2.2.2.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/bootstrap.min.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/jquery-ui.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/myjs.js"/>"></script> 
</body>
</html>