
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập</title>
<!--Custom Theme files-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Flat Account Login Form widget template Responsive, Login form web template,Flat Pricing tables,Flat Drop downs  Sign up Web Templates, Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!--//Custom Theme files -->
<%-- <link href="<c:url value="/resources/login/css/style.css"/>"
	rel="stylesheet" type="text/css" media="all" /> --%>

<link href="resources/login/css/style.css" rel="stylesheet"
	type="text/css" media="all" />
</head>
<body>
	<h1>Đăng nhập</h1>
	<div class="signin-form">

		<form id="loginForm" action="j_spring_security_check" method="post">
			<ul>
				<li><input type="text" name="j_username"
					placeholder="User Name" required="" /> <span class="user">
				</span></li>
				<li><input type="password" name="j_password"
					placeholder="Password" required="" /> <span class="key"> </span></li>
				<li><input type="submit" value="Login"></li>
			</ul>
		</form>
		<font color="red"> <span>${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</span>
		</font> </font> <a href="/fogotpassword" class="text">Quên password !</a>
	</div>
	</div>
	<!--//main -->
	<div class="copyright">
		<p>
			&copy; 2015 Flat Account Login Form . All rights reserved | Design by
			<a href=" " target="_blank">LTN</a>
		</p>
	</div>
</body>
</html>