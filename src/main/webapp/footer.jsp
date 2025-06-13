<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>


footer {
	background: linear-gradient(to right, var(--primary-color),
		var(--accent-color));
	color: white;
	padding: 20px 0;
	bottom: auto;
	box-sizing: border-box;
	width: 100%;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	bottom: auto;
	margin-top: 20px;
	text-align: center;
}

.ptext {
	margin-top: 20px;
	text-align: center;
	color: white;
}

.hr {
	color: white;
	text-align: center;
}

.footer-section {
	color: white;
	margin-top: 20px;
	text-align: center;
	box-sizing: border-box;
}
.footer-section a {
    color: white;
    text-decoration: none; /* removes underline */
    font-weight: 400;
    transition: all 0.3s ease;
}

.footer-section a:hover {
    color: var(--secondary-color); /* or any color you prefer */
    text-decoration: underline; /* optional hover underline */
}



</style>
</head>
<body>
	<footer>
		<div class="footer-section">
			<h5>SANGHAVI OPTICIANS</h5>
			<p>Your trusted partner for premium eyewear since 1990</p>
		</div>
		<div class="footer-section">
			<h5>Quick Links</h5>
			<ul class="list-unstyled">
				<li><a href="aboutus.jsp" class="footer-section">About Us</a></li>
				<li><a href="contact.jsp" class="footer-section">Contact US</a></li>

			</ul>
		</div>
		<div class="footer-section">
			<h5>Connect With Us</h5>
			<div>
				<a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
				<a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
				<a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
			</div>
		</div>

		<hr width="300%" align="center" class="hr">

		<p align="center" class="ptext">&copy; 2024 SANGHAVI OPTICIANS.
			All Rights Reserved</p>
	</footer>
</body>
</html>