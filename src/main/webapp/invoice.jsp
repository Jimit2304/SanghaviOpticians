
<%-- <%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String orderID = request.getParameter("orderID");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<html>
<head>
    <title>Invoice - Order Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
        }

        .navbar-brand {
            color: white !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }
        .invoice {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        .invoice h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
         .invoice-header {
            border-bottom: 2px solid #007bff;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        .invoice-details, .product-details {
            margin-bottom: 30px;
        }
        .total-amount {
            font-weight: bold;
            font-size: 1.5em;
            color: #dc3545;
            margin-top: 20px;
        }
         .btn-print {
            background: linear-gradient(to right, var(--accent-color), var(--primary-color));
            color: white;
            padding: 0.8rem 2.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 1rem 0.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .invoice-header {
            border-bottom: 2px solid #007bff;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        .product-item {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f8f9fa;
        }
        .product-item p {
            margin: 5px 0;
        }
	         footer {
	            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
	            color: white;
	            padding: 2rem 0;
	            margin-top: auto;
	        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">Sanghavi Opticians</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="product.jsp">Shop</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
<div class="container mt-5">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Fetch Order Details
        ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
        ps.setString(1, orderID);
        rs = ps.executeQuery();

        if(rs.next()) {
%>
<div class="invoice">
    <div class="invoice-header">
        <h2>Invoice</h2>
        <p><strong>Order ID:</strong> <%=rs.getInt("orderID")%></p>
        <p><strong>Date:</strong> <%=rs.getDate("createdAt")%></p>
    </div>
    <div class="invoice-details">
        <p><strong>Customer:</strong> <%=rs.getString("fullName")%></p>
        <p><strong>Email:</strong> <%=rs.getString("email")%></p>
        <p><strong>Phone:</strong> <%=rs.getString("phone")%></p>
        <p><strong>Address:</strong> <%=rs.getString("address")%>, <%=rs.getString("city")%>, <%=rs.getString("pincode")%></p>
        <p><strong>Payment Method:</strong> <%=rs.getString("paymentMethod")%></p>
        <p><strong>Status:</strong> <%=rs.getString("orderStatus")%></p>
    </div>

    <h3>Products</h3>
    <div class="product-details">
<%
        // Fetch Order Items
        ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
        ps.setString(1, orderID);
        ResultSet items = ps.executeQuery();

        while(items.next()) {
            int productID = items.getInt("productID");
            int lensID = items.getInt("lensID");
            int presID = items.getInt("prescriptionID");

            // Get Product
            PreparedStatement ps2 = con.prepareStatement("SELECT * FROM products WHERE productID=?");
            ps2.setInt(1, productID);
            ResultSet prod = ps2.executeQuery();
            prod.next();
%>
        <div class="product-item">
            <p><strong>Product:</strong> <%=prod.getString("name")%></p>
            <p><strong>Quantity:</strong> <%=items.getInt("quantity")%></p>
            <p><strong>Price:</strong> ₹<%=items.getDouble("Oprice")%></p>
            
            
<%
    if(lensID > 0) {
        PreparedStatement ps3 = con.prepareStatement("SELECT * FROM lenses WHERE lensID=?");
        ps3.setInt(1, lensID);
        ResultSet lens = ps3.executeQuery();
        if(lens.next()) {
%>
                <p><%=lens.getString("name")%></p><br>
				<p><strong>Quantity:</strong> <%=items.getInt("quantity")%></p>
                Price: ₹<%=lens.getDouble("price")%>
<%
        }
    } else {
        out.print("No Lens");
    }
%>
            </p>
            <p><strong>Prescription:</strong>
<%
    if(presID > 0) {
        PreparedStatement ps4 = con.prepareStatement("SELECT * FROM prescriptions WHERE prescriptionID=?");
        ps4.setInt(1, presID);
        ResultSet pres = ps4.executeQuery();
        if(pres.next()) {
%>
               <h3>Prescription Details</h3>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Eye</th>
            <th>Sph</th>
            <th>Cyl</th>
            <th>Axis</th>
            <th>Add</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Right Eye</td>
            <td><%=pres.getString("right_sph") != null ? pres.getString("right_sph") : "N/A"%></td>
            <td><%=pres.getString("right_cyl") != null ? pres.getString("right_cyl") : "N/A"%></td>
            <td><%=pres.getString("right_axis") != null ? pres.getString("right_axis") : "N/A"%></td>
            <td><%=pres.getString("right_add") != null ? pres.getString("right_add") : "N/A"%></td>
        </tr>

        <tr>
            <td>Left Eye</td>
            <td><%=pres.getString("left_sph") != null ? pres.getString("left_sph") : "N/A"%></td>
            <td><%=pres.getString("left_cyl") != null ? pres.getString("left_cyl") : "N/A"%></td>
            <td><%=pres.getString("left_axis") != null ? pres.getString("left_axis") : "N/A"%></td>
            <td><%=pres.getString("left_add") != null ? pres.getString("left_add") : "N/A"%></td>
        </tr>
    </tbody>
</table>
<%
        }
    } else {
        out.print("No Prescription");
    }
%>
            </p>
        </div>
<%
        }
%>
    </div>

<div class="total-amount">
<%
    // Calculate Total Amount
    PreparedStatement ps5 = con.prepareStatement(
        "SELECT SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
        "FROM order_items oi " +
        "JOIN products p ON oi.productID = p.productID " +
        "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
        "WHERE oi.orderID = ?"
    );
    ps5.setString(1, orderID);
    ResultSet totalRS = ps5.executeQuery();

    double totalAmount = 0;
    if(totalRS.next()) {
        totalAmount = totalRS.getDouble("totalAmount");
    }
%>
    <h3>Total Payable Amount: ₹<%=totalAmount %></h3>
     <div class="text text-center mt-3">
            <button class="btn-print me-3" onclick="window.print()">Print Bill</button>
<button class="btn-print" onclick="window.location.href='orderHistory.jsp'">Back to Your Orders</button>
			
        </div>
</div>
<%
        } else {
            out.print("<h4>Invalid Order ID</h4>");
        }
    } catch(Exception e) {
        out.print("Error: "+e);
    } finally {
        if(con != null) con.close();
    }
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
                    <div class="social-icons">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4 bg-white">
            <div class="text-center">
                <p class="mb-0 text-white-50">&copy; 2024 Sanghavi Opticians. All Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>    --%>
<%--  <%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String orderID = request.getParameter("orderID");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<html>
<head>
    <title>Invoice - Order Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
        }

        .navbar-brand {
            color: white !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }
        .invoice {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        .invoice h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .invoice-details, .product-details {
            margin-bottom: 30px;
        }
        .total-amount {
            font-weight: bold;
            font-size: 1.5em;
            color: #dc3545;
            margin-top: 20px;
        }
        .btn-print {
            background: linear-gradient(to right, var(--accent-color), var(--primary-color));
            color: white;
            padding: 0.8rem 2.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 1rem 0.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
         .invoice-header {
            border-bottom: 2px solid #007bff;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">Sanghavi Opticians</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="product.jsp">Shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
<div class="container mt-5">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Fetch Order Details
        ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
        ps.setString(1, orderID);
        rs = ps.executeQuery();

        if(rs.next()) {
%>
<div class="invoice">
    <div class="invoice-header">
        <h2>Invoice</h2>
        <p><strong>Order ID:</strong> <%=rs.getInt("orderID")%></p>
        <p><strong>Date:</strong> <%=rs.getDate("createdAt")%></p>
    </div>
    <div class="invoice-details">
        <p><strong>Customer:</strong> <%=rs.getString("fullName")%></p>
        <p><strong>Email:</strong> <%=rs.getString("email")%></p>
        <p><strong>Phone:</strong> <%=rs.getString("phone")%></p>
        <p><strong>Address:</strong> <%=rs.getString("address")%>, <%=rs.getString("city")%>, <%=rs.getString("pincode")%></p>
        <p><strong>Payment Method:</strong> <%=rs.getString("paymentMethod")%></p>
        <p><strong>Status:</strong> <%=rs.getString("orderStatus")%></p>
    </div>

    <h3>Products</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
<%
        // Fetch Order Items
        ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
        ps.setString(1, orderID);
        ResultSet items = ps.executeQuery();

        while(items.next()) {
            int productID = items.getInt("productID");
            int lensID = items.getInt("lensID");
            int presID = items.getInt("prescriptionID");

            // Get Product
            PreparedStatement ps2 = con.prepareStatement("SELECT * FROM products WHERE productID=?");
            ps2.setInt(1, productID);
            ResultSet prod = ps2.executeQuery();
            prod.next();
%>
            <tr>
                <td><%=prod.getString("name")%></td>
                <td><%=items.getInt("quantity")%></td>
                <td>₹<%=items.getDouble("Oprice")%></td>
            </tr>
<%
            if(lensID > 0) {
                PreparedStatement ps3 = con.prepareStatement("SELECT * FROM lenses WHERE lensID=?");
                ps3.setInt(1, lensID);
                ResultSet lens = ps3.executeQuery();
                if(lens.next()) {
%>
                <tr>
                    <td><%=lens.getString("name")%></b></td>
                    <td><%=items.getInt("quantity")%></td>
                    <td>₹<%=lens.getDouble("price")%></td>
                </tr>
<%
                }
            }
        }
%>
        </tbody>
    </table>

    <!-- <h3>Prescription</h3> -->
  <!--   <table class="table table-bordered">
        <thead>
            <tr>
                <th>Eye</th>
                <th>Sph</th>
                <th>Cyl</th>
                <th>Axis</th>
                <th>Add</th>
            </tr>
        </thead>
        <tbody> -->
<%
        // Check if prescriptionID is valid
        if(presID > 0) {
            PreparedStatement ps4 = con.prepareStatement("SELECT * FROM prescriptions WHERE prescriptionID=?");
            ps4.setInt(1, presID);
            ResultSet pres = ps4.executeQuery();
            if(pres.next()) {
%>
            <tr>
                <td>Right</td>
                <td><%=pres.getString("right_sph") != null ? pres.getString("right_sph") : "N/A" %></td>
                <td><%=pres.getString("right_cyl") != null ? pres.getString("right_cyl") : "N/A" %></td>
                <td><%=pres.getString("right_axis") != null ? pres.getString("right_axis") : "N/A" %></td>
                <td><%=pres.getString("right_add") != null ? pres.getString("right_add") : "N/A" %></td>
            </tr>
            <tr>
                <td>Left</td>
                <td><%=pres.getString("left_sph") != null ? pres.getString("left_sph") : "N/A" %></td>
                <td><%=pres.getString("left_cyl") != null ? pres.getString("left_cyl") : "N/A" %></td>
                <td><%=pres.getString("left_axis") != null ? pres.getString("left_axis") : "N/A" %></td>
                <td><%=pres.getString("left_add") != null ? pres.getString("left_add") : "N/A" %></td>
            </tr>
<%
            } else {
%>
            <tr>
                <td colspan="5">Prescription not found</td>
            </tr>
<%
            }
        } else {
%>
            <tr>
                <td colspan="5">No Prescription</td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
    

<div class="total-amount">
<%
    // Calculate Total Amount
    PreparedStatement ps5 = con.prepareStatement(
        "SELECT SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
        "FROM order_items oi " +
        "JOIN products p ON oi.productID = p.productID " +
        "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
        "WHERE oi.orderID = ?"
    );
    ps5.setString(1, orderID);
    ResultSet totalRS = ps5.executeQuery();

    double totalAmount = 0;
    if(totalRS.next()) {
        totalAmount = totalRS.getDouble("totalAmount");
    }
%>
    <h3>Total Payable Amount: ₹<%=totalAmount %></h3>
     <div class="text text-center mt-3">
            <button class="btn-print me-3" onclick="window.print()">Print Bill</button>
            <button class="btn-print" onclick="window.location.href='orderHistory.jsp'">Back to Your Orders</button>
        </div>
</div>
<%
        } else {
            out.print("<h4>Invalid Order ID</h4>");
        }
    } catch(Exception e) {
        out.print("Error: "+e);
    } finally {
        if(con != null) con.close();
    }
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
                    <div class="social-icons">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4 bg-white">
            <div class="text-center">
                <p class="mb-0 text-white-50">&copy; 2024 Sanghavi Opticians. All Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html> --%>
<%-- <%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String orderID = request.getParameter("orderID");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<html>
<head>
    <title>Invoice - Order Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
        }

        .navbar-brand {
            color: white !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }

        .invoice {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }

        .invoice h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }

        .invoice-details, .product-details {
            margin-bottom: 30px;
        }

        .total-amount {
            font-weight: bold;
            font-size: 1.5em;
            color: #dc3545;
            margin-top: 20px;
        }

        .btn-print {
            background: linear-gradient(to right, var(--accent-color), var(--primary-color));
            color: white;
            padding: 0.8rem 2.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 1rem 0.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
 .invoice-header {
            border-bottom: 2px solid #007bff;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">Sanghavi Opticians</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="product.jsp">Shop</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp">Cart</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-5">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
        ps.setString(1, orderID);
        rs = ps.executeQuery();

        if(rs.next()) {
%>
<div class="invoice">
    <div class="invoice-header">
        <h2>Invoice</h2>
        <p><strong>Order ID:</strong> <%=rs.getInt("orderID")%></p>
        <p><strong>Date:</strong> <%=rs.getDate("createdAt")%></p>
    </div>
    <div class="invoice-details">
        <p><strong>Customer:</strong> <%=rs.getString("fullName")%></p>
        <p><strong>Email:</strong> <%=rs.getString("email")%></p>
        <p><strong>Phone:</strong> <%=rs.getString("phone")%></p>
        <p><strong>Address:</strong> <%=rs.getString("address")%>, <%=rs.getString("city")%>, <%=rs.getString("pincode")%></p>
        <p><strong>Payment Method:</strong> <%=rs.getString("paymentMethod")%></p>
        <p><strong>Status:</strong> <%=rs.getString("orderStatus")%></p>
    </div>

    <h3>Products</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
<%
        ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
        ps.setString(1, orderID);
        ResultSet items = ps.executeQuery();

        while(items.next()) {
            int productID = items.getInt("productID");
            int lensID = items.getInt("lensID");
            int presID = items.getInt("prescriptionID");

            PreparedStatement ps2 = con.prepareStatement("SELECT * FROM products WHERE productID=?");
            ps2.setInt(1, productID);
            ResultSet prod = ps2.executeQuery();
            prod.next();
%>
            <tr>
                <td><%=prod.getString("name")%></td>
                <td><%=items.getInt("quantity")%></td>
                <td>₹<%=items.getDouble("Oprice")%></td>
            </tr>
<%
            if(lensID > 0) {
                PreparedStatement ps3 = con.prepareStatement("SELECT * FROM lenses WHERE lensID=?");
                ps3.setInt(1, lensID);
                ResultSet lens = ps3.executeQuery();
                if(lens.next()) {
%>
                <tr>
                    <td><%=lens.getString("name")%></td>
                    <td><%=items.getInt("quantity")%></td>
                    <td>₹<%=lens.getDouble("price")%></td>
                </tr>
<%
                }
            }
        }
%>
        </tbody>
    </table>

<%-- <%
int presID = items.getInt("prescriptionID");
        if(presID > 0) {
            PreparedStatement ps4 = con.prepareStatement("SELECT * FROM prescriptions WHERE prescriptionID=?");
            ps4.setInt(1, presID);
            ResultSet pres = ps4.executeQuery();
            if(pres.next()) {
%>
            <h3>Prescription Details</h3>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Eye</th>
                        <th>Sph</th>
                        <th>Cyl</th>
                        <th>Axis</th>
                        <th>Add</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Right</td>
                        <td><%=pres.getString("right_sph") != null ? pres.getString("right_sph") : "N/A" %></td>
                        <td><%=pres.getString("right_cyl") != null ? pres.getString("right_cyl") : "N/A" %></td>
                        <td><%=pres.getString("right_axis") != null ? pres.getString("right_axis") : "N/A" %></td>
                        <td><%=pres.getString("right_add") != null ? pres.getString("right_add") : "N/A" %></td>
                    </tr>
                    <tr>
                        <td>Left</td>
                        <td><%=pres.getString("left_sph") != null ? pres.getString("left_sph") : "N/A" %></td>
                        <td><%=pres.getString("left_cyl") != null ? pres.getString("left_cyl") : "N/A" %></td>
                        <td><%=pres.getString("left_axis") != null ? pres.getString("left_axis") : "N/A" %></td>
                        <td><%=pres.getString("left_add") != null ? pres.getString("left_add") : "N/A" %></td>
                    </tr>
                </tbody>
            </table>
<%
            } else {
%>
            <p>Prescription not found</p>
<%
            }
        } else {
%>
            <p>No Prescription</p>
<%
        }
%>
   

    <div class="total-amount">
<%
    PreparedStatement ps5 = con.prepareStatement(
        "SELECT SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
        "FROM order_items oi " +
        "JOIN products p ON oi.productID = p.productID " +
        "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
        "WHERE oi.orderID = ?"
    );
    ps5.setString(1, orderID);
    ResultSet totalRS = ps5.executeQuery();

    double totalAmount = 0;
    if(totalRS.next()) {
        totalAmount = totalRS.getDouble("totalAmount");
    }
%>
        <h3>Total Payable Amount: ₹<%=totalAmount %></h3>
        <div class="text text-center mt-3">
            <button class="btn-print me-3" onclick="window.print()">Print Bill</button>
            <button class="btn-print" onclick="window.location.href='orderHistory.jsp'">Back to Your Orders</button>
        </div>
    </div>
</div>
<%
        } else {
            out.print("<h4>Invalid Order ID</h4>");
        }
    } catch(Exception e) {
        out.print("Error: "+e);
    } finally {
        if(con != null) con.close();
    }
%>
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
                <div class="social-icons">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
        </div>
        <hr class="my-4 bg-white">
        <div class="text-center">
            <p class="mb-0 text-white-50">&copy; 2024 Sanghavi Opticians. All Rights Reserved.</p>
        </div>
    </div>
</footer>
</body>
</html>--%>
<%-- <%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String orderID = request.getParameter("orderID");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice - Sanghavi Opticians</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .invoice {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin: 30px auto;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 900px;
        }
        .invoice h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .total {
            font-size: 1.3em;
            font-weight: bold;
            color: #dc3545;
        }
    </style>
</head>
<body>

<div class="invoice">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
        ps.setString(1, orderID);
        rs = ps.executeQuery();

        if(rs.next()) {
%>
    <h2>Invoice</h2>
    <p><strong>Order ID:</strong> <%= rs.getInt("orderID") %></p>
    <p><strong>Date:</strong> <%= rs.getTimestamp("createdAt") %></p>
    <p><strong>Customer:</strong> <%= rs.getString("fullName") %></p>
    <p><strong>Email:</strong> <%= rs.getString("email") %></p>
    <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
    <p><strong>Address:</strong> <%= rs.getString("address") %>, <%= rs.getString("city") %>, <%= rs.getString("pincode") %></p>
    <p><strong>Payment Method:</strong> <%= rs.getString("paymentMethod") %></p>
    <p><strong>Status:</strong> <%= rs.getString("orderStatus") %></p>

    <hr>
    <h4>Order Items</h4>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
<%
    double grandTotal = 0;
    ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
    ps.setString(1, orderID);
    ResultSet items = ps.executeQuery();

    while(items.next()) {
        int productID = items.getInt("productID");
        int lensID = items.getInt("lensID");
        int qty = items.getInt("quantity");
        double productPrice = 0;
        double lensPrice = 0;

        // Fetch product info
        PreparedStatement ps2 = con.prepareStatement("SELECT name, finalPrice FROM products WHERE productID=?");
        ps2.setInt(1, productID);
        ResultSet prod = ps2.executeQuery();
        if(prod.next()) {
            String name = prod.getString("name");
            productPrice = prod.getDouble("finalPrice");
%>
            <tr>
                <td>Specs</td>
                <td><%= name %></td>
                <td><%= qty %></td>
                <td>₹<%= productPrice %></td>
            </tr>
<%
            grandTotal += (productPrice * qty);
        }
        prod.close(); ps2.close();

        // Fetch lens info
        if(lensID > 0) {
            PreparedStatement ps3 = con.prepareStatement("SELECT name, price FROM lenses WHERE lensID=?");
            ps3.setInt(1, lensID);
            ResultSet lens = ps3.executeQuery();
            if(lens.next()) {
                String lensName = lens.getString("name");
                lensPrice = lens.getDouble("price");
%>
            <tr>
                <td>Lens</td>
                <td><%= lensName %></td>
                <td><%= qty %></td>
                <td>₹<%= lensPrice %></td>
            </tr>
<%
                grandTotal += (lensPrice * qty);
            }
            lens.close(); ps3.close();
        }
    }
    items.close();
%>
        </tbody>
    </table>

    <p class="total text-end">Total Amount: ₹<%= grandTotal %></p>
    <div class="text-center">
        <button class="btn btn-primary" onclick="window.print()">Print Invoice</button>
        <a href="orderHistory.jsp" class="btn btn-secondary">Back to Orders</a>
    </div>
<%
    } else {
        out.print("<div class='alert alert-danger'>Invalid Order ID</div>");
    }
} catch(Exception e) {
    out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
} finally {
    if(con != null) con.close();
}
%>
</div>

</body>
</html>
 --%>
<%--  <%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String orderID = request.getParameter("orderID");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice - Sanghavi Opticians</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .invoice {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin: 30px auto;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 900px;
        }
        .invoice h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .total {
            font-size: 1.3em;
            font-weight: bold;
            color: #dc3545;
        }
    </style>
</head>
<body>

<div class="invoice">
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
        ps.setString(1, orderID);
        rs = ps.executeQuery();

        if(rs.next()) {
%>
    <h2>Invoice</h2>
    <p><strong>Order ID:</strong> <%= rs.getInt("orderID") %></p>
    <p><strong>Date:</strong> <%= rs.getTimestamp("createdAt") %></p>
    <p><strong>Customer:</strong> <%= rs.getString("fullName") %></p>
    <p><strong>Email:</strong> <%= rs.getString("email") %></p>
    <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
    <p><strong>Address:</strong> <%= rs.getString("address") %>, <%= rs.getString("city") %>, <%= rs.getString("pincode") %></p>
    <p><strong>Payment Method:</strong> <%= rs.getString("paymentMethod") %></p>
    <p><strong>Status:</strong> <%= rs.getString("orderStatus") %></p>

    <hr>
    <h4>Order Items</h4>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Type</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Prescription</th>
            </tr>
        </thead>
        <tbody>
<%
    double grandTotal = 0;
    ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
    ps.setString(1, orderID);
    ResultSet items = ps.executeQuery();

    while(items.next()) {
        int productID = items.getInt("productID");
        int lensID = items.getInt("lensID");
        int qty = items.getInt("quantity");
        double productPrice = 0;
        double lensPrice = 0;
        String prescriptionDetails = "";

        // Fetch product info
        PreparedStatement ps2 = con.prepareStatement("SELECT name, finalPrice FROM products WHERE productID=?");
        ps2.setInt(1, productID);
        ResultSet prod = ps2.executeQuery();
        if(prod.next()) {
            String name = prod.getString("name");
            productPrice = prod.getDouble("finalPrice");
%>
            <tr>
                <td>Specs</td>
                <td><%= name %></td>
                <td><%= qty %></td>
                <td>₹<%= productPrice %></td>
<%
            grandTotal += (productPrice * qty);
        }
        prod.close(); ps2.close();

        // Fetch lens info
        if(lensID > 0) {
            PreparedStatement ps3 = con.prepareStatement("SELECT name, price FROM lenses WHERE lensID=?");
            ps3.setInt(1, lensID);
            ResultSet lens = ps3.executeQuery();
            if(lens.next()) {
                String lensName = lens.getString("name");
                lensPrice = lens.getDouble("price");
%>
            <tr>
                <td>Lens</td>
                <td><%= lensName %></td>
                <td><%= qty %></td>
                <td>₹<%= lensPrice %></td>
<%
                grandTotal += (lensPrice * qty);

                // Fetch prescription details if available
                int prescriptionID = items.getInt("prescriptionID");
                if(prescriptionID > 0) {
                    PreparedStatement ps4 = con.prepareStatement("SELECT * FROM prescriptions WHERE prescriptionID=?");
                    ps4.setInt(1, prescriptionID);
                    ResultSet prescription = ps4.executeQuery();
                    if(prescription.next()) {
                        String rightSph = prescription.getString("right_sph");
                        String rightCyl = prescription.getString("right_cyl");
                        String rightAxis = prescription.getString("right_axis");
                        String rightAdd = prescription.getString("right_add");
                        String leftSph = prescription.getString("left_sph");
                        String leftCyl = prescription.getString("left_cyl");
                        String leftAxis = prescription.getString("left_axis");
                        String leftAdd = prescription.getString("left_add");

                        prescriptionDetails = "R(SPH: " + rightSph + ", CYL: " + rightCyl + ", AXIS: " + rightAxis + ", ADD: " + rightAdd + ")<br>" +
                                              "L(SPH: " + leftSph + ", CYL: " + leftCyl + ", AXIS: " + leftAxis + ", ADD: " + leftAdd + ")";
                    }
                    prescription.close(); ps4.close();
                }
            }
            lens.close(); ps3.close();
        }
%>
                <td><%= prescriptionDetails %></td>
            </tr>
<%
    }
    items.close();
%>
        </tbody>
    </table>

    <p class="total text-end">Total Amount: ₹<%= grandTotal %></p>
    <div class="text-center">
        <button class="btn btn-primary" onclick="window.print()">Print Invoice</button>
        <a href="orderHistory.jsp" class="btn btn-secondary">Back to Orders</a>
    </div>
<%
    } else {
        out.print("<div class='alert alert-danger'>Invalid Order ID</div>");
    }
} catch(Exception e) {
    out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
} finally {
    if(con != null) con.close();
}
%>
</div>

</body>
</html> --%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
String orderID = request.getParameter("orderID");
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<title>Invoice - Sanghavi Opticians</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	font-family: 'Poppins', sans-serif;
}

.invoice {
	background: white;
	border-radius: 10px;
	padding: 30px;
	margin: 30px auto;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	max-width: 900px;
}

.invoice h2 {
	color: #007bff;
	border-bottom: 2px solid #007bff;
	padding-bottom: 10px;
}

.table th, .table td {
	vertical-align: middle;
}

.total {
	font-size: 1.3em;
	font-weight: bold;
	color: #dc3545;
}

.prescription-box {
	background-color: #f1f1f1;
	padding: 15px;
	margin-top: 10px;
	margin-bottom: 10px;
	border-left: 4px solid #007bff;
}

</style>

</head>
<body>

	<div class="invoice">
		<%
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

			ps = con.prepareStatement("SELECT * FROM orders WHERE orderID=?");
			ps.setString(1, orderID);
			rs = ps.executeQuery();

			if (rs.next()) {
		%>
		<h2>Invoice</h2>
		<p>
			<strong>Order ID:</strong>
			<%=rs.getInt("orderID")%></p>
		<p>
			<strong>Date:</strong>
			<%=rs.getTimestamp("createdAt")%></p>
		<p>
			<strong>Customer:</strong>
			<%=rs.getString("fullName")%></p>
		<p>
			<strong>Email:</strong>
			<%=rs.getString("email")%></p>
		<p>
			<strong>Phone:</strong>
			<%=rs.getString("phone")%></p>
		<p>
			<strong>Address:</strong>
			<%=rs.getString("address")%>,
			<%=rs.getString("city")%>,
			<%=rs.getString("pincode")%></p>
		<p>
			<strong>Payment Method:</strong>
			<%=rs.getString("paymentMethod")%></p>
		<p>
			<strong>Status:</strong>
			<%=rs.getString("orderStatus")%></p>

		<hr>
		<h4>Order Items</h4>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Type</th>
					<th>Name</th>
					<th>Quantity</th>
					<th>Price</th>

				</tr>
			</thead>
			<tbody>
				<%
				double grandTotal = 0;
				ps = con.prepareStatement("SELECT * FROM order_items WHERE orderID=?");
				ps.setString(1, orderID);
				ResultSet items = ps.executeQuery();

				while (items.next()) {
					int productID = items.getInt("productID");
					int lensID = items.getInt("lensID");
					int qty = items.getInt("quantity");
					double productPrice = 0;
					double lensPrice = 0;

					// Fetch product info
					PreparedStatement ps2 = con.prepareStatement("SELECT name,images, finalPrice FROM products WHERE productID=?");
					ps2.setInt(1, productID);
					ResultSet prod = ps2.executeQuery();
					if (prod.next()) {
						String name = prod.getString("name");
						productPrice = prod.getDouble("finalPrice");
				%>
				<tr>
					<td>Specs</td>
					<td><%=name%></td>
					<td><%=qty%></td>
					<td>₹<%=productPrice%></td>

				</tr>
				<%
				grandTotal += (productPrice * qty);
				}
				prod.close();
				ps2.close();

				// Fetch lens info
				if (lensID > 0) {
				PreparedStatement ps3 = con.prepareStatement("SELECT name, price, type FROM lenses WHERE lensID=?");
				ps3.setInt(1, lensID);
				ResultSet lens = ps3.executeQuery();
				if (lens.next()) {
					String lensName = lens.getString("name");
					lensPrice = lens.getDouble("price");
					String lensType = lens.getString("type");
				%>
				<tr>
					<td>Lens</td>
					<td><%=lensName%></td>
					<td><%=qty%></td>
					<td>₹<%=lensPrice%></td>

				</tr>
				<%
				grandTotal += (lensPrice * qty);

				if (!lensType.equalsIgnoreCase("Single Vision")) {
					int prescriptionID = items.getInt("prescriptionID");
					if (prescriptionID > 0) {
						PreparedStatement ps4 = con.prepareStatement("SELECT * FROM prescriptions WHERE prescriptionID=?");
						ps4.setInt(1, prescriptionID);
						ResultSet prescription = ps4.executeQuery();
						if (prescription.next()) {
					String rightSph = prescription.getString("right_sph");
					String rightCyl = prescription.getString("right_cyl");
					String rightAxis = prescription.getString("right_axis");
					String rightAdd = prescription.getString("right_add");
					String leftSph = prescription.getString("left_sph");
					String leftCyl = prescription.getString("left_cyl");
					String leftAxis = prescription.getString("left_axis");
					String leftAdd = prescription.getString("left_add");
				%>
				<tr>
					<td colspan="5">
						<div class="prescription-box">
							<strong>Prescription:</strong><br> R:  SPH-: 
							<%=rightSph%>,  CYL-: 
							<%=rightCyl%>,  AXIS-: 
							<%=rightAxis%>,  ADD-: 
							<%=rightAdd%><br>  L: SPH-: 
							<%=leftSph%>,  CYL-: 
							<%=leftCyl%>,  AXIS-: 
							<%=leftAxis%>,  ADD-: 
							<%=leftAdd%>
						</div>
					</td>
				</tr>
				<%
				}
				prescription.close();
				ps4.close();
				}
				}
				}
				lens.close();
				ps3.close();
				}
				}
				items.close();
				%>
			</tbody>
		</table>

		<p class="total text-end">
			Total Amount: ₹<%=grandTotal%></p>

		<div class="text-center">
			<button class="btn btn-primary" onclick="window.print()">Print
				Invoice</button>
			<a href="orderHistory.jsp" class="btn btn-secondary">Back to
				Orders</a>
		</div>
		<%
		} else {
		out.print("<div class='alert alert-danger'>Invalid Order ID</div>");
		}
		} catch (Exception e) {
		out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
		} finally {
		if (con != null)
		con.close();
		}
		%>
	</div>

</body>
		<jsp:include page="footer.jsp" />

</html>

