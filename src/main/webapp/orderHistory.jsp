
<%-- <%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure the user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp"); // Redirect if user is not logged in
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #1a237e;
            --secondary-color: #ff5722;
            --accent-color: #2196f3;
            --background-color: #f5f5f5;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
        }
        .container-box {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin: 20px auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        .orderStatus {
            font-weight: bold;
            text-transform: uppercase;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Sanghavi Opticians</a>
        </div>
    </nav>

    <div class="container container-box">
        <h2 class="text-center mb-4">Order History</h2>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                String orderQuery = "SELECT * FROM orders WHERE userID = ? ORDER BY orderDate DESC";
                ps = conn.prepareStatement(orderQuery);
                ps.setInt(1, userID);
                rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                <p class="text-center">You have no past orders.</p>
        <%
                } else {
                    while (rs.next()) {
                        int orderID = rs.getInt("orderID");
                        String orderDate = rs.getString("orderDate");
                        double totalAmount = rs.getDouble("totalAmount");
                        String paymentMethod = rs.getString("paymentMethod");
                        String orderStatus = rs.getString("orderStatus");
        %>
        <div class="border p-3 mb-3">
            <h5>Order ID: <%= orderID %></h5>
            <p><b>Date:</b> <%= orderDate %></p>
            <p><b>Total:</b> ₹<%= totalAmount %></p>
            <p><b>Payment:</b> <%= paymentMethod %></p>
            <p class="orderStatus"><b>orderStatus:</b> <%= orderStatus %></p>

            <!-- Fetch Ordered Items -->
            <h6 class="mt-3">Items:</h6>
            <ul>
                <%
                    String itemsQuery = "SELECT p.name, oi.quantity, oi.price FROM order_items oi JOIN products p ON oi.productID = p.productID WHERE oi.orderID = ?";
                    PreparedStatement psItems = conn.prepareStatement(itemsQuery);
                    psItems.setInt(1, orderID);
                    ResultSet rsItems = psItems.executeQuery();

                    while (rsItems.next()) {
                %>
                <li><%= rsItems.getString("name") %> (x<%= rsItems.getInt("quantity") %>) - ₹<%= rsItems.getDouble("price") %></li>
                <%
                    }
                    rsItems.close();
                    psItems.close();
                %>
            </ul>

            <!-- Fetch Ordered Lens (if any) -->
            <%
                String lensQuery = "SELECT l.name, oi.price FROM order_items oi JOIN lenses l ON oi.lensID = l.lensID WHERE oi.orderID = ?";
                PreparedStatement psLens = conn.prepareStatement(lensQuery);
                psLens.setInt(1, orderID);
                ResultSet rsLens = psLens.executeQuery();

                if (rsLens.next()) {
            %>
            <h6>Lens:</h6>
            <p><%= rsLens.getString("name") %> - ₹<%= rsLens.getDouble("price") %></p>
            <%
                }
                rsLens.close();
                psLens.close();
            %>

            <!-- Buttons -->
            <a href="invoice.jsp?orderID=<%= orderID %>" class="btn btn-custom">View Invoice</a>
            <a href="reorder.jsp?orderID=<%= orderID %>" class="btn btn-outline-primary">Reorder</a>
        </div>
        <% } } %>
    </div>
</body>
</html>

<%
    // Close connections
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
 --%>
<%--  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/ma";
    String dbUser = "root";
    String dbPassword = "Jimit@123";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Get logged-in user ID (Assuming session stores user ID)
    Integer userId = (Integer) session.getAttribute("userID");

    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Fetch orders for the user
    String query = "SELECT * FROM orders WHERE userID = ? ORDER BY createdAt DESC";
    PreparedStatement stmt = conn.prepareStatement(query);
    stmt.setInt(1, userId);
    ResultSet rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #e67e22;
            --accent-color: #3498db;
            --background-color: #ecf0f1;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
        }
        .navbar-brand, .nav-link { color: white !important; }
        .nav-link:hover { color: var(--secondary-color) !important; }
        .orders-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 2rem;
            margin: 2rem auto;
        }
        .order-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            padding: 1.5rem;
            transition: transform 0.3s ease;
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .order-orderStatus {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .orderStatus-delivered { background-color: #d4edda; color: #155724; }
        .orderStatus-processing { background-color: #fff3cd; color: #856404; }
        .orderStatus-shipped { background-color: #cce5ff; color: #004085; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Sanghavi Opticians</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="products.jsp">Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="wishlist.jsp">Wishlist</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="orders-container">
            <h2 class="mb-4">My Orders</h2>

            <% while (rs.next()) { %>
            <div class="order-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Order #<%= rs.getInt("orderID") %></h5>
                    <span class="order-orderStatus 
                        <%= rs.getString("orderStatus").equals("Delivered") ? "orderStatus-delivered" : 
                             rs.getString("orderStatus").equals("Processing") ? "orderStatus-processing" : 
                             "orderStatus-shipped" %>">
                        <%= rs.getString("orderStatus") %>
                    </span>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <img src="<%= rs.getString("images") %>" alt="<%= rs.getString("name") %>" class="img-fluid rounded">
                    </div>
                    <div class="col-md-9">
                        <h6><%= rs.getString("productName") %></h6>
                        <p class="text-muted mb-2">Quantity: <%= rs.getInt("quantity") %></p>
                        <p class="text-muted mb-2">Order Date: <%= rs.getDate("orderDate") %></p>
                        <p class="mb-0"><strong>Total: ₹<%= rs.getDouble("totalPrice") %></strong></p>
                    </div>
                </div>
            </div> 
            <% } 
                rs.close();
                stmt.close();
                conn.close();
            %>

        </div>
    </div>

    <footer class="mt-auto">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5 class="text-white">Sanghavi Opticians</h5>
                    <p class="text-white-50">Your trusted partner for premium eyewear since 1990</p>
                </div>
                <div class="col-md-4">
                    <h5 class="text-white">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white-50 text-decoration-none">About Us</a></li>
                        <li><a href="#" class="text-white-50 text-decoration-none">Contact</a></li>
                        <li><a href="#" class="text-white-50 text-decoration-none">Store Locator</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5 class="text-white">Connect With Us</h5>
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            <hr class="my-4 bg-white">
            <p class="text-center text-white-50">&copy; 2024 Sanghavi Opticians. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> --%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
// Ensure the user is logged in
Integer userID = (Integer) session.getAttribute("userID");
if (userID == null) {
	response.sendRedirect("login.jsp"); // Redirect if user is not logged in
	return;
}

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order History | Sanghavi Opticians</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
:root {
	--primary-color: #1a237e;
	--secondary-color: #ff5722;
	--accent-color: #2196f3;
	--background-color: #f5f5f5;
}

body {
	font-family: 'Poppins', sans-serif;
	background-color: var(--background-color);
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

   .navbar {
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color)) !important;
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
        background-color: white;
        color: var(--primary-color) !important;
        transform: translateY(-2px);
    }
.container-box {
	background: white;
	padding: 25px;
	border-radius: 10px;
	margin: 20px auto;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.btn-custom {
	background-color: var(--accent-color);
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 5px;
	transition: all 0.3s ease;
}

.btn-custom:hover {
	background-color: #059862 /* var(--primary-color) */;
	color: white;
	transform: translateY(-2px);
}

.status {
	font-weight: bold;
	text-transform: uppercase;
}
</style>
</head>

<body class="d-flex flex-column min-vh-100">
	<!-- Navigation -->
	 <jsp:include page="w.jsp" /> 


	<div class="container container-box">
		<h2 class="text-center mb-4">Order History</h2>

		<%
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

			// Fetch orders for the logged-in user
			String orderQuery = "SELECT * FROM orders WHERE userID = ? ORDER BY createdAt DESC";
			ps = conn.prepareStatement(orderQuery);
			ps.setInt(1, userID);
			rs = ps.executeQuery();

			if (!rs.isBeforeFirst()) {
		%>
		<p class="text-center">You have no past orders.</p>
		<%
		} else {
		while (rs.next()) {
			int orderID = rs.getInt("orderID");
			String fullName = rs.getString("fullName");
			/*   String email = rs.getString("email");
			String phone = rs.getString("phone"); */
			String address = rs.getString("address");
			String city = rs.getString("city");
			String pincode = rs.getString("pincode");
			String paymentMethod = rs.getString("paymentMethod");
			//double totalAmount = rs.getDouble("totalAmount");
			String orderStatus = rs.getString("orderStatus");
			String createdAt = rs.getString("createdAt");
		%>
		<div class="border p-3 mb-3">
			<h5>
				Order ID:
				<%=orderID%></h5>
			<p>
				<b>Date:</b>
				<%=createdAt%></p>
			<p>
				<b>Name:</b>
				<%=fullName%></p>
			<%--  <p><b>Email:</b> <%= email %></p>
            <p><b>Phone:</b> <%= phone %></p> --%>
			<p>
				<b>Address:</b>
				<%=address%>,
				<%=city%>
				-
				<%=pincode%></p>
			<%--  <p><b>Total:</b> ₹<%= totalAmount %></p> --%>
			<p>
				<b>Payment:</b>
				<%=paymentMethod%></p>
			<p class="status">
				<b>Status:</b>
				<%=orderStatus%></p>

			<!-- Fetch Ordered Items -->
			<%-- <h6 class="mt-3">Items:</h6>
            <ul>
                <%
                    String itemsQuery = "SELECT p.name, oi.quantity, oi.Oprice FROM order_items oi JOIN products p ON oi.productID = p.productID WHERE oi.orderID = ?";
                    PreparedStatement psItems = conn.prepareStatement(itemsQuery);
                    psItems.setInt(1, orderID);
                    ResultSet rsItems = psItems.executeQuery();

                    while (rsItems.next()) {
                %>
                <li><%= rsItems.getString("name") %> (x<%= rsItems.getInt("quantity") %>) - ₹<%= rsItems.getDouble("Oprice") %></li>
                <%
                    }
                    rsItems.close();
                    psItems.close();
                %>
            </ul>

            <!-- Fetch Ordered Lens (if any) -->
            <%
                String lensQuery = "SELECT l.name,l.price ,oi.Oprice,oi.quantity FROM order_items oi JOIN lenses l ON oi.lensID = l.lensID WHERE oi.orderID = ?";
                PreparedStatement psLens = conn.prepareStatement(lensQuery);
                psLens.setInt(1, orderID);
                ResultSet rsLens = psLens.executeQuery();

                if (rsLens.next()) {
            %>
            <h6>Lens:</h6>
            <p><%= rsLens.getString("name") %> - ₹<%= rsLens.getDouble("price") %></p>
            <%
                }
                rsLens.close();
                psLens.close();
            %>
             --%>

			<!-- Buttons -->
			<a href="invoice.jsp?orderID=<%=orderID%>" class="btn btn-custom">View
				Invoice</a>
			<%
			if ("Pending".equalsIgnoreCase(orderStatus)) {
			%>
			<form method="post" action="cancelOrder.jsp" class="d-inline">
				<input type="hidden" name="orderID" value="<%=orderID%>">
				<button type="submit" class="btn btn-danger ms-2"
					onclick="return confirm('Are you sure you want to cancel this order?');">
					Cancel Order</button>
			</form>
			<%
			}
			%>

		</div>
		<%
		}
		}
		%>
	</div>


	<!-- Footer -->
	<jsp:include page="footer.jsp" />
</body>
</html>

<%
// Close connections
if (rs != null)
	rs.close();
if (ps != null)
	ps.close();
if (conn != null)
	conn.close();
} catch (Exception e) {
e.printStackTrace();
}
%>

