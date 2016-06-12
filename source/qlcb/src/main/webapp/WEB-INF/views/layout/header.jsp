
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Real Space a Real Estates and Builders Category Flat
	Bootstrap Responsive Website Template | Home :: w3layouts</title>
<!---css--->
<link href="<c:url value="/resources/layout/css/bootstrap.css"/>"
	rel='stylesheet' type='text/css' />
<link href="<c:url value="/resources/layout/css/style.css"/>"
	rel='stylesheet' type='text/css' />
<!---css--->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Real Space Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 



</script>
<!---js--->
<script src="<c:url value="/resources/layout/js/jquery-1.11.1.min.js"/>"></script>
<script src="<c:url value="/resources/layout/js/bootstrap.js"/>"></script>
<!---js--->

<!---fonts-->
<script
	src="<c:url value="/resources/layout/js/responsiveslides.min.js"/>"></script>
<script>
	$(function() {
		$("#slider").responsiveSlides({
			auto : true,
			nav : false,
			speed : 500,
			namespace : "callbacks",
			pager : true,
		});
	});
</script>
<link href="<c:url value="/resources/layout/css/owl.carousel.css"/>"
	rel="stylesheet">
<script src="<c:url value="/resources/layout/js/owl.carousel.js"/>"></script>
<script>
	$(document).ready(function() {
		$("#owl-demo").owlCarousel({
			items : 1,
			lazyLoad : true,
			autoPlay : true,
			navigation : false,
			navigationText : false,
			pagination : true,
		});
	});
</script>

</head>
<body>
	<!---header--->
	<div class="header-section">
		<div class="container">
			<div class="head-top">
				<div class="social-icon">
					<a href="#"><i class="icon"></i></a> <a href="#"><i
						class="icon1"></i></a>

				</div>
				<div class="email">
					<ul>

						<li><spring:message code="user.logged" />: <sec:authentication
								property="name" /> <sec:authentication property="authorities" />
							<i class="glyphicon glyphicon-log-in" aria-hidden="true"></i><a
							href="logout"><spring:message code="user.logout" /></a></li>

					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
			<nav class="navbar navbar-default">
				<!---Brand and toggle get grouped for better mobile display--->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<!--<div class="navbar-brand">
								<h1><a href="index.html"><span>Real </span>Space</a></h1>
							</div>-->
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class=" " id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active"><a href="index.html">Home <span
								class="sr-only">(current)</span></a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Pages<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="about.html">About</a></li>
								<li><a href="services.html">Services</a></li>
								<li><a href="agents.html">Agents</a></li>
								<li><a href="forrent.html">For Rent</a></li>
								<li><a href="forsale.html">For Sale</a></li>
								<li><a href="pricing.html">Pricing</a></li>
								<li><a href="faqs.html">FAQs</a></li>
								<li><a href="idxpress.html">IDXpress</a></li>
								<li><a href="terms.html">Terms of Use</a></li>
								<li><a href="privacy.html">Privacy Policy</a></li>
							</ul></li>
						<li class="dropdown "><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Property<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="defaultvariation.html">Default â
										Variation</a></li>
								<li><a href="agentinsidebarvariation.html">Agent in
										Sidebar - Variation</a></li>
								<li><a href="galleryvariation.html">Gallery - Variation</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">Gallery <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="2columnsgallery.html">2 Columns Gallery</a></li>
								<li><a href="3columnsgallery.html">3 Columns Gallery</a></li>
								<li><a href="4columnsgallery.html">4 Columns Gallery</a></li>
							</ul></li>
						<li><a href="blog.html">Blog</a></li>
						<li><a href="codes.html">Codes</a></li>
						<li><a href="contact.html">Contact</a></li>
					</ul>
					<!--<div class="phone">
							<span><i class="glyphicon glyphicon-phone" aria-hidden="true"></i>1-999-4563-555</span>
							</div>-->
					<div class="clearfix"></div>
				</div>
			</nav>
		</div>
	</div>
	<!---header--->
	<!---banner--->
	<!--<div class="slider">
			<div class="callbacks_container">
				<ul class="rslides" id="slider">
					<div class="slid banner1">
						  <div class="caption">
								<h3>1400 Anastasia Avenue</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec pellentesque ex. Morbi iaculis mi in varius auctor. Nullam feugiat erat .</p>
								<a href="#" class="button">know more</a>
						  </div>
					</div>
					<div class="slid banner2">	
						  <div class="caption">
								<h3>Oakland, NJ94605</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec pellentesque ex. Morbi iaculis mi in varius auctor. Nullam feugiat erat .</p>
								<a href="#" class="button">know more</a>
						  </div>
					</div>
					<div class="slid banner3">	
						<div class="caption">
							<h3>Florida 5, Pinecrest, FL</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec pellentesque ex. Morbi iaculis mi in varius auctor. Nullam feugiat erat .</p>
							<a href="#" class="button">know more</a>
						</div>
					</div>
				</ul>
			</div>
		</div>-->
	<!---banner--->

	<!-- login -->



</body>
</html>