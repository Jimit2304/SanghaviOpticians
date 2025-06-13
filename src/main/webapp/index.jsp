<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sanghavi Opticians | Premium Eyewear</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" href="style.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
:root {
	--primary-color: #1a237e;
	--secondary-color: #ff5722;
	--accent-color: #2196f3;
	--background-color: #f5f5f5;
}

.navbar {
	background: linear-gradient(135deg, var(--primary-color),
		var(--accent-color)) !important;
	padding: 1rem 0;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand {
	color: white !important;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 1.5px;
	font-size: 1.4rem;
}

.nav-link {
	color: white !important;
	font-weight: 500;
	margin: 0 1.2rem;
	padding: 0.5rem 1rem;
	border-radius: 25px;
	transition: all 0.3s ease;
}

.nav-link:hover {
	background-color: white; /*rgba(255, 255, 255, 0.1);*/
	color: var(--primary-color) !important;
	/*var(--secondary-color) !important;*/
	transform: translateY(-2px);
}

.btn-custom {
	background-color: var(--primary-color);
	color: white;
	border: none;
	padding: 0.8rem 2rem;
	border-radius: 25px;
	font-weight: 500;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
}

.btn-custom:hover {	background-color: var(--secondary-color);
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(244, 81, 30, 0.3);
}

.product-card {
	border: none;
	border-radius: 15px;
	overflow: hidden;
	transition: all 0.3s ease;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.product-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.card-img-top {
	height: 220px;
    width: 100%;
    object-fit: contain; /* or use 'cover' for filling the area */
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 10px;
}

.card-body {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 1.5rem;
	flex-grow: 1;
}

.card-title {
	font-size: 1.25rem;
	font-weight: 600;
	margin-bottom: 0.5rem;
	text-align: center;
}

.text-muted {
	font-size: 0.9rem;
	margin-bottom: 1rem;
}



.price {
	color: var(--price-color);
	font-size: 1.2rem;
	margin-bottom: 1.5rem;
	text-decoration: line-through;
}

.discountprice {
	color: var(--discount-color);
	font-size: 1.3rem;
	font-weight: bold;
	margin-bottom: 1.5rem;
}

.featured-section {
	background-color: white;
	padding: 5rem 0;
}

.featured-section h2 {
	color: var(--primary-color);
	font-weight: 700;
	margin-bottom: 3rem;
	position: relative;
}

.featured-section h2:after {
	content: '';
	position: absolute;
	bottom: -10px;
	left: 50%;
	transform: translateX(-50%);
	width: 50px;
	height: 3px;
	background-color: var(--secondary-color);
}

/* New Banner Styles */
.banner-section {
	padding: 3rem 0;
	background: linear-gradient(45deg, #f3f4f6, #e5e7eb);
}

.banner-card {
	background: white;
	border-radius: 20px;
	padding: 2rem;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	margin-bottom: 2rem;
}

.banner-image {
	width: 100%;
	height: 300px;
	object-fit: cover;
	border-radius: 15px;
	margin-bottom: 1.5rem;
}

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
</style>
</head>

<body>
	<!-- Navigation -->
	      <jsp:include page="w.jsp" />

	<!-- Hero Section -->
	<!-- <section class="hero-section" style="background-color: var(--background-color);">
            <div class="container">
                <div class="row align-items-center min-vh-100">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold mb-4" style="color: var(--primary-color);">Find Your Perfect Style
                        </h1>
                        <p class="lead mb-4">Discover our premium collection of eyewear. From classic to contemporary,
                            find frames that define your unique style.</p>
                        <a href="sunfglass.jsp" class="btn btn-custom btn-lg">Sun Glass</a>
                        <a href="eyeframes.jsp" class="btn btn-custom btn-lg">Eye Frames</a>
                    </div>
                    <div class="col-lg-6">
                        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel"
                            data-bs-interval="3000">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                                    class="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            </div>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="https://images.unsplash.com/photo-1577803645773-f96470509666?q=80&w=1000&auto=format&fit=crop"
                                        class="d-block w-100 rounded-3 shadow" alt="Eyewear Collection 1">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://images.unsplash.com/photo-1509695507497-903c140c43b0"
                                        class="d-block w-100 rounded-3 shadow" alt="Eyewear Collection 2">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button"
                                data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button"
                                data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

 -->
	<section class="hero-section"
		style="background-color: var(--background-color);">
		<div class="container">
			<div class="row align-items-center min-vh-100">
				<div class="col-lg-6">
					<h1 class="display-4 fw-bold mb-4"
						style="color: var(--primary-color);">Find Your Perfect Style</h1>
					<p class="lead mb-4">Discover our premium collection of
						eyewear. From classic to contemporary, find frames that define
						your unique style.</p>
					<a href="sunfglass.jsp" class="btn btn-custom btn-lg">Sun Glasses</a>
					<a href="eyeframes.jsp" class="btn btn-custom btn-lg">Eye
						Frames</a>
				</div>
				<div class="col-lg-6">
					<div>
						<!--  <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                            class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3"
                            aria-label="Slide 4"></button>
                    </div> -->
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img
									src="https://images.unsplash.com/photo-1577803645773-f96470509666?q=80&w=1000&auto=format&fit=crop"
									class="d-block w-100 rounded-3 shadow"
									alt="Eyewear Collection 1">
							</div>
							<!--  <div class="carousel-item">
            <img src="sunglass-png-aviator-sunglass-png-clipart-3381.png" class="d-block w-100 rounded-3 shadow" alt="Eyewear Collection 2">
        </div>
        <div class="carousel-item">
            <img src="5.png" class="d-block w-100 rounded-3 shadow" alt="Eyeglasses on Display">
        </div>
        <div class="carousel-item">
            <img src="4.jpg" class="d-block w-100 rounded-3 shadow" alt="Modern Optical Store Interior">
        </div> -->
						</div>
						<!-- <button class="carousel-control-prev" type="button"
                        data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button"
                        data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button> -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Featured Products -->
	<section class="featured-section">
		<div class="container">
			<h2 class="text-center">Trending Eyewears</h2>
			<div class="row g-4">
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root",
					"Jimit@123");
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY productID DESC LIMIT 4 ");

					while (rs.next()) {
				%>
				<div class="col-lg-3 col-md-6">
					<div class="product-card shadow">
						<img src="<%=rs.getString("images")%>" class="card-img-top"
							alt="<%=rs.getString("name")%>">
						<div class="card-body">
						
							<h5 class="card-title"><%=rs.getString("name")%></h5>
							<p class="text-muted"><%=rs.getString("style")%></p>
							<p class="discountprice ">
								Special Price:₹<%=rs.getDouble("finalPrice")%></p>
							<p class="price">
								Price:₹<%=rs.getDouble("price")%></p>

							<a
								href="product-detail.jsp?productID=<%=rs.getInt("productID")%>"
								class="btn btn-custom w-100">View Detail</a>
						</div>
					</div>
				</div>
				<%
				}
				conn.close();
				} catch (Exception e) {
				out.println("<p>Error fetching products.</p>");
				e.printStackTrace();
				}
				%>
			</div>
		</div>
	</section>
	<!-- Footer -->
		      <jsp:include page="footer.jsp" />

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Custom JS -->
	<script src="script.js"></script>
</body>
</html>