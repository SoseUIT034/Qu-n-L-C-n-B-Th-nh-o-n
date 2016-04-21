 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Real Space a Real Estates and Builders Category Flat Bootstrap Responsive Website Template | Home :: w3layouts </title>
<!---css--->
<link href="<c:url value="/resources/layout/css/bootstrap.css"/>" rel='stylesheet' type='text/css' />
<link href="<c:url value="/resources/layout/css/style.css"/>" rel='stylesheet' type='text/css' />
<!---css--->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Real Space Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!---js--->
<script src="<c:url value="/resources/layout/js/jquery-1.11.1.min.js"/>"></script>
<script src="<c:url value="/resources/layout/js/bootstrap.js"/>"></script>
<!---js--->
 
<!---fonts-->
<script src="<c:url value="/resources/layout/js/responsiveslides.min.js"/>"></script>
	 <script>
		$(function () {
		  $("#slider").responsiveSlides({
			auto:true,
			nav: false,
			speed: 500,
			namespace: "callbacks",
			pager:true,
		  });
		});
	</script>
<link href="<c:url value="/resources/layout/css/owl.carousel.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/layout/js/owl.carousel.js"/>"></script>
	<script>
		$(document).ready(function() {
		$("#owl-demo").owlCarousel({
			items : 1,
			lazyLoad : true,
			autoPlay : true,
			navigation : false,
			navigationText :  false,
			pagination : true,
		});
		});
	</script>

</head>

<body>
		<!---header--->
		 
		<%@include file="header.jsp" %>
		<!---header--->
		
		<div class="content">
			
		</div>				
		<!---footer--->
		<%@include file="footer.jsp" %>
		<!---footer--->
					

</body>
</html>