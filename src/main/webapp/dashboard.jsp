
<%--<%--%>
<%--	if (session.getAttribute("email") == null){--%>
<%--		response.sendRedirect("login.jsp");--%>
<%--	}--%>
<%--%>--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String email = (String)session.getAttribute("email");
	request.setAttribute("email", email);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Bookstore</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/web/assets/mobirise-icons2/mobirise2.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/bootstrap/css/bootstrap.min.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/bootstrap/css/bootstrap-grid.min.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/bootstrap/css/bootstrap-reboot.min.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/dropdown/css/style.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/socicon/css/styles.css?rnd=1712055538746">
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/theme/css/style.css?rnd=1712055538746">
	<link rel="preload" href="https://fonts.googleapis.com/css2?family=Inter+Tight:wght@400;700&display=swap&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
	<noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter+Tight:wght@400;700&display=swap&display=swap"></noscript>
	<link rel="stylesheet" href="https://r.mobirisesite.com/374544/assets/css/mbr-additional.css?rnd=1712055538746" type="text/css">
<script src="https://cdn.tailwindcss.com"></script>

	<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/dashboard.css" rel="stylesheet" />
</head>
<body>

<section data-bs-version="5.1" class="menu menu2 cid-u8MGae9RjC" once="menu" id="menu-5-u8MGae9RjC">


	<nav class="navbar navbar-dropdown navbar-fixed-top navbar-expand-lg">
		<div class="container">
			<div class="navbar-brand">
				<span class="navbar-logo">
					<a href="#">
						<img src="assets/images/photo-1526243741027-444d633d7365.jpeg" alt="Mobirise Website Builder" style="height: 4.3rem;">
					</a>
				</span>
				<span class="navbar-caption-wrap"><a class="navbar-caption text-black display-4" href="#">Booktopia</a></span>
			</div>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-bs-toggle="collapse" data-target="#navbarSupportedContent" data-bs-target="#navbarSupportedContent" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
				<div class="hamburger">
					<span></span>
					<span></span>
					<span></span>
					<span></span>
				</div>
			</button>
			<div class=" navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav nav-dropdown" data-app-modern-menu="true">
					<li class="nav-item">
						<a class="nav-link link text-black display-4" href="#">All</a>
					</li>
					<li class="nav-item">
						<a class="nav-link link text-black display-4" href="#" aria-expanded="false">Bestseller</a>
					</li>
					<li class="nav-item">
						<a class="nav-link link text-black display-4" href="#">New</a>
					</li>
				</ul>
				<div class="px-10">
					<a href="#">Cart</a>
				</div>
				<c:choose>
					<c:when test="${email != null}">
						<div class="navbar-buttons mbr-section-btn"><a class="btn btn-primary display-4" href="#">Profile</a></div>
					</c:when>
					<c:otherwise>
						<div class="navbar-buttons mbr-section-btn"><a class="btn btn-primary display-4" href="registration.jsp">Sign Up</a></div>
					</c:otherwise>
				</c:choose>


			</div>
		</div>
	</nav>
</section>

<section data-bs-version="5.1" class="header18 cid-u8MGaea8bk mbr-fullscreen" data-bg-video="https://www.youtube.com/embed/iNjxfGJxpns?autoplay=1&amp;loop=1&amp;playlist=iNjxfGJxpns&amp;t=20&amp;mute=1&amp;playsinline=1&amp;controls=0&amp;showinfo=0&amp;autohide=1&amp;allowfullscreen=true&amp;mode=transparent" id="hero-15-u8MGaea8bk">


	<div class="mbr-overlay" style="opacity: 0.5; background-color: rgb(0, 0, 0);"></div>
	<div class="container-fluid">
		<div class="row">
			<div class="content-wrap col-12 col-md-12">
				<h1 class="mbr-section-title mbr-fonts-style mbr-white mb-4 display-1">
					<strong>Dive In</strong>
				</h1>

				<p class="mbr-fonts-style mbr-text mbr-white mb-4 display-7">Embark on a Literary Adventure Like Never Before - Where Every Page Holds Magic and Mystery!</p>
				<div class="mbr-section-btn">
					<a class="btn btn-white-outline display-7" href="https://mobiri.se">Discover More</a>
				</div>
			</div>
		</div>
	</div>
</section>

<section data-bs-version="5.1" class="article4 cid-u8MGaecYcH" id="about-me-4-u8MGaecYcH">





	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-md-12 col-lg-6 image-wrapper">
				<img class="w-100" src="assets/images/photo-1517770413964-df8ca61194a6.jpeg" alt="Mobirise Website Builder">
			</div>
			<div class="col-12 col-md-12 col-lg">
				<div class="text-wrapper align-left">
					<h1 class="mbr-section-title mbr-fonts-style mb-4 display-2">
						<strong>Welcome to Booktopia</strong>
					</h1>
					<p class="mbr-text mbr-fonts-style mb-3 display-7">At Booktopia, we believe in the power of words to transport you to new worlds, ignite your imagination, and stir your soul.</p>

					<p class="mbr-text mbr-fonts-style mb-3 display-7">With a vast collection of books spanning genres and ages, we're here to fuel your passion for reading and storytelling.</p>
					<p class="mbr-text mbr-fonts-style mb-3 display-7">Join us on this journey through the realms of fiction, nonfiction, and children's literature, where every book is a gateway to endless possibilities.</p>

				</div>
			</div>
		</div>
	</div>
</section>

<section data-bs-version="5.1" class="pricing02 cid-u8MGaeeUf9" id="product-list-9-u8MGaeeUf9">


	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-12 content-head">
				<div class="mbr-section-head mb-5">
					<h4 class="mbr-section-title mbr-fonts-style align-center mb-0 display-2">
						<strong>Must-Have Reads</strong>
					</h4>


				</div>
			</div>
		</div>
		<div class="row">
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1476275466078-4007374efbbe.jpeg" alt="Mobirise Website Builder">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Mystical Adventures</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$19.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Embark on a journey through enchanted realms with this gripping fantasy novel. Magic, mystery, and mayhem await!</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>

				</div>
			</div>
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1596123068611-c89d922a0f0a.jpeg" alt="Mobirise Website Builder">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Thriller Masterpiece</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$24.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Heart-pounding suspense and unexpected twists make this thriller a page-turner you won't be able to put down!</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1514894780887-121968d00567.jpeg" alt="Mobirise Website Builder">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Romantic Escapade</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$17.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Fall in love with this charming romance novel that will sweep you off your feet and warm your heart.</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1550399105-c4db5fb85c18.jpeg">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Sci-Fi Odyssey</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$21.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Explore the cosmos and beyond with this mind-bending science fiction adventure that will leave you questioning reality!</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1485322551133-3a4c27a9d925.jpeg">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Historical Saga</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$22.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Travel back in time and experience the drama, intrigue, and passion of a bygone era in this captivating historical novel.</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="item features-image col-12 col-md-6 col-lg-4">
				<div class="item-wrapper">
					<div class="item-img">
						<img src="assets/images/photo-1526285759904-71d1170ed2ac.jpeg">
					</div>
					<div class="item-content">
						<h5 class="item-title mbr-fonts-style display-5">
							<strong>Mystery Thriller</strong>
						</h5>
						<h6 class="item-subtitle mbr-fonts-style display-7">$18.99</h6>
						<p class="mbr-text mbr-fonts-style display-7">Unravel the secrets and solve the puzzles in this gripping mystery thriller that will keep you guessing until the very end!</p>
						<div class="mbr-section-btn item-footer">
							<a href="" class="btn item-btn btn-primary display-7">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section data-bs-version="5.1" class="footer2 cid-u8MGaeiNQv" once="footers" id="footer-5-u8MGaeiNQv">





	<div class="container">
		<div class="row">
			<div class="col-12 col-lg-6 center mt-2 mb-3">
				<p class="mbr-fonts-style copyright mb-0 display-7">© 2024 Booktopia. All Rights Reserved</p>
			</div>
			<div class="col-12 col-lg-6 center">
				<div class="row-links mt-2 mb-3">
					<ul class="row-links-soc">




						<li class="row-links-soc-item mbr-fonts-style display-7">
							<a href="#" class="text-white">About</a>
						</li><li class="row-links-soc-item mbr-fonts-style display-7">
						<a href="#" class="text-white">FAQ</a>
					</li><li class="row-links-soc-item mbr-fonts-style display-7">
						<a href="#" class="text-white">Terms</a>
					</li><li class="row-links-soc-item mbr-fonts-style display-7">
						<a href="#" class="text-white">Privacy</a>
					</li></ul>
				</div>
			</div>
		</div>
	</div>
</section>


<script src="assets/web/assets/jquery/jquery.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/smoothscroll/smooth-scroll.js"></script>
<script src="assets/ytplayer/index.js"></script>
<script src="assets/dropdown/js/navbar-dropdown.js"></script>
<script src="assets/vimeoplayer/player.js"></script>
<script src="assets/theme/js/script.js"></script>
<script src="assets/formoid/formoid.min.js"></script>



</body>
</html>
