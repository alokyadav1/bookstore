<%@ page import="models.User" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="models.CartDetails" %>
<%--<%--%>
<%--	if (session.getAttribute("email") == null){--%>
<%--		response.sendRedirect("login.jsp");--%>
<%--	}--%>
<%--%>--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
    request.setAttribute("user", user);
%>

<%
    RequestDispatcher rd = request.getRequestDispatcher("/book");
    rd.include(request, response);

    if(user != null){
        request.setAttribute("userID", user.getUserID());
        RequestDispatcher cartDispatcher = request.getRequestDispatcher("/cart");
        cartDispatcher.include(request,response);
    }
%>

<%
    List<Book> books = (List<Book>) session.getAttribute("books");
    request.setAttribute("books", books);

    List<CartDetails> carts = (List<CartDetails>) session.getAttribute("carts");
    request.setAttribute("carts", carts);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Bookstore</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/794b194f27.js" crossorigin="anonymous"></script>
    <link rel="stylesheet"
          href="https://r.mobirisesite.com/377048/assets/web/assets/mobirise-icons2/mobirise2.css?rnd=1712209858925">
    <link rel="stylesheet"
          href="https://r.mobirisesite.com/377048/assets/bootstrap/css/bootstrap.min.css?rnd=1712209858925">
    <link rel="stylesheet"
          href="https://r.mobirisesite.com/377048/assets/bootstrap/css/bootstrap-grid.min.css?rnd=1712209858925">
    <link rel="stylesheet"
          href="https://r.mobirisesite.com/377048/assets/bootstrap/css/bootstrap-reboot.min.css?rnd=1712209858925">
    <link rel="stylesheet" href="https://r.mobirisesite.com/377048/assets/dropdown/css/style.css?rnd=1712209858925">
    <link rel="stylesheet" href="https://r.mobirisesite.com/377048/assets/socicon/css/styles.css?rnd=1712209858925">
    <link rel="stylesheet" href="https://r.mobirisesite.com/377048/assets/theme/css/style.css?rnd=1712209858925">
    <link rel="preload"
          href="https://fonts.googleapis.com/css2?family=Inter+Tight:wght@400;700&display=swap&display=swap" as="style"
          onload="this.onload=null;this.rel='stylesheet'">
    <noscript>
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Inter+Tight:wght@400;700&display=swap&display=swap">
    </noscript>
    <link rel="stylesheet" href="https://r.mobirisesite.com/377048/assets/css/mbr-additional.css?rnd=1712209858925"
          type="text/css">
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
          rel="stylesheet" type="text/css"/>
    <link
            href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
            rel="stylesheet" type="text/css"/>
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/dashboard.css" rel="stylesheet"/>

</head>
<body>

<section data-bs-version="5.1" class="menu menu2 cid-u8X6PgEneK" once="menu" id="menu-5-u8X6PgEneK">


    <nav class="navbar navbar-dropdown navbar-fixed-top navbar-expand-lg">
        <div class="container">
            <div class="navbar-brand">
				<span class="navbar-logo">
					<a href="#">
						<img src="assets/images/photo-1591951425600-d09958978584.jpeg" alt="Mobirise Website Builder"
                             style="height: 4.3rem;">
					</a>
				</span>
                <span class="navbar-caption-wrap"><a class="navbar-caption text-black display-4"
                                                     href="">Bookify</a></span>
            </div>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-bs-toggle="collapse"
                    data-target="#navbarSupportedContent" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
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
                        <a class="nav-link link text-black display-4" href="#">Explore</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link text-black display-4" href="#" aria-expanded="false">Bestsellers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link text-black display-4" href="#">New Arrivals</a>
                    </li>
                </ul>

                <c:choose>
                    <c:when test="${user == null}">
                        <div class="navbar-buttons mbr-section-btn">
                            <a class="btn btn-primary display-4" href="registration.jsp">Join Now</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="cart.jsp" class="cart-container mr-10">
                            <i class="fa-solid fa-cart-shopping text-2xl "></i>
                            <% if(carts != null && !carts.isEmpty()){%>
                                <span><%= carts.size()%></span>
                            <%}%>
                        </a>
                        <form action="logout" method="post">
                            <div class="navbar-buttons mbr-section-btn mr-5">
                                <button type="submit" class="btn btn-primary display-6">Logout</button>
                            </div>
                        </form>

                        <div class="navbar-buttons mbr-section-btn">
                            <a class="btn btn-primary display-4" href="#">${user.username}</a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </nav>
</section>

<section data-bs-version="5.1" class="header18 cid-u8X6PgHKmk mbr-fullscreen"
         data-bg-video="https://www.youtube.com/embed/vhG5usAFL_g?autoplay=1&amp;loop=1&amp;playlist=vhG5usAFL_g&amp;t=20&amp;mute=1&amp;playsinline=1&amp;controls=0&amp;showinfo=0&amp;autohide=1&amp;allowfullscreen=true&amp;mode=transparent"
         id="hero-16-u8X6PgHKmk">


    <div class="mbr-overlay" style="opacity: 0.5; background-color: rgb(0, 0, 0);"></div>
    <div class="container-fluid">
        <div class="row">
            <div class="content-wrap col-12 col-md-12">
                <h1 class="mbr-section-title mbr-fonts-style mbr-white mb-4 display-1">
                    <strong>Discover Books</strong>
                </h1>

                <p class="mbr-fonts-style mbr-text mbr-white mb-4 display-7">Embark on a Literary Adventure with Our
                    Diverse Collection of Books!</p>
                <div class="mbr-section-btn">
                    <a class="btn btn-white-outline display-7" href="#">Start Reading</a>
                </div>
            </div>
        </div>
    </div>
</section>

<section data-bs-version="5.1" class="pricing02 cid-u8X6PgKGEO" id="product-list-8-u8X6PgKGEO">


    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-12 content-head">
                <div class="mbr-section-head mb-5">
                    <h4 class="mbr-section-title mbr-fonts-style align-center mb-0 display-2">
                        <strong>Featured Books</strong>
                    </h4>


                </div>
            </div>
        </div>
        <div class="row">
            <% if (books != null) {%>
            <% for (Book book : books) { %>
            <div class="item features-image col-12 col-md-6 col-lg-3">
                <div class="item-wrapper">
                    <div class="item-img">
                        <img src="assets/images/photo-1531988042231-d39a9cc12a9a.jpeg" alt="Mobirise Website Builder">
                    </div>
                    <div class="p-3 item-content">
                        <h5 class="item-title mbr-fonts-style display-5">
                            <strong><%= book.getTitle()%>
                            </strong>
                        </h5>
                        <h6 class="item-subtitle mbr-fonts-style display-7">Rs.<%= book.getPrice()%>
                        </h6>
                        <div class="flex flex-wrap justify-between items-center item-footer">
                            <button class="bg-blue-700 p-3 rounded-full text-lg text-white">Add to cart</button>
                            <button class="bg-blue-700 p-3 rounded-full text-lg text-white">Buy Now</button>
                        </div>
                    </div>

                </div>
            </div>
            <%}%>
            <%} else {%>
            <div>
                <p>Login to see available books.</p>
            </div>
            <%}%>
        </div>
    </div>
</section>

<section data-bs-version="5.1" class="social05 cid-u8X6PgVYrZ" id="follow-us-2-u8X6PgVYrZ">


    <div class="container">
        <div class="row">
            <h3 class="mbr-section-title align-center mb-5 mbr-fonts-style display-2">
                <strong>Stay Connected</strong>
            </h3>
            <div class="col-12">
                <div class="social-row">
                    <div class="soc-item">
                        <a href="https://mobiri.se/" target="_blank">
                            <span class="mbr-iconfont socicon socicon-facebook"></span>
                        </a>
                    </div>
                    <div class="soc-item">
                        <a href="https://mobiri.se/" target="_blank">
                            <span class="mbr-iconfont socicon-twitter socicon"></span>
                        </a>
                    </div>
                    <div class="soc-item">
                        <a href="https://mobiri.se/" target="_blank">
                            <span class="mbr-iconfont socicon-instagram socicon"></span>
                        </a>
                    </div>
                    <div class="soc-item">
                        <a href="https://mobiri.se/" target="_blank">
                            <span class="mbr-iconfont socicon socicon-linkedin"></span>
                        </a>
                    </div>
                    <div class="soc-item">
                        <a href="https://mobiri.se/" target="_blank">
                            <span class="mbr-iconfont socicon socicon-twitch"></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section data-bs-version="5.1" class="footer2 cid-u8X6PgW0o3" once="footers" id="footer-5-u8X6PgW0o3">


    <div class="container">
        <div class="row">
            <div class="col-12 col-lg-6 center mt-2 mb-3">
                <p class="mbr-fonts-style copyright mb-0 display-7">© 2024 Bookstore Inc.</p>
            </div>
            <div class="col-12 col-lg-6 center">
                <div class="row-links mt-2 mb-3">
                    <ul class="row-links-soc">


                        <li class="row-links-soc-item mbr-fonts-style display-7">
                            <a href="#" class="text-white">About</a>
                        </li>
                        <li class="row-links-soc-item mbr-fonts-style display-7">
                            <a href="#" class="text-white">Shop</a>
                        </li>
                        <li class="row-links-soc-item mbr-fonts-style display-7">
                            <a href="#" class="text-white">Blog</a>
                        </li>
                        <li class="row-links-soc-item mbr-fonts-style display-7">
                            <a href="#" class="text-white">Contact</a>
                        </li>
                    </ul>
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
<script src="assets/embla/embla.min.js"></script>
<script src="assets/embla/script.js"></script>
<script src="assets/theme/js/script.js"></script>


</body>
</html>
