<%-- <%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp"); // Redirect if user is not logged in
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double totalPrice = 0.0;
    int orderID = -1;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // 🔹 Step 1: Insert into `orders` table
        String insertOrderQuery = "INSERT INTO orders (userID, totalAmount, paymentMethod, shippingAddress) VALUES (?, ?, ?, ?)";
        ps = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userID);
        ps.setDouble(2, totalPrice);  // Total will be calculated below
        ps.setString(3, "COD");       // Default Payment Method (Changeable in checkout)
        ps.setString(4, "User Address Here");  // Fetch from user details

        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                orderID = keys.getInt(1);
            }
            keys.close();
        }
        ps.close();

        // 🔹 Step 2: Fetch Cart Items & Insert into `order_items`
        String cartQuery = "SELECT c.cartID, p.productID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
        ps = conn.prepareStatement(cartQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        while (rs.next()) {
            int productID = rs.getInt("productID");
            String productName = rs.getString("name");
            String productImage = rs.getString("images");
            double productPrice = rs.getDouble("finalPrice");
            int quantity = rs.getInt("quantity");
            double itemTotal = productPrice * quantity;
            totalPrice += itemTotal;
            

            // Insert into `order_items`
            String insertOrderItemsQuery = "INSERT INTO order_items (orderID, productID, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement psItem = conn.prepareStatement(insertOrderItemsQuery);
            psItem.setInt(1, orderID);
            psItem.setInt(2, productID);
            psItem.setInt(3, quantity);
            psItem.setDouble(4, productPrice);
            psItem.executeUpdate();
            psItem.close();
        }
        rs.close();
        ps.close();

        // 🔹 Step 3: Fetch Lens & Prescription Details & Insert into `order_items`
        String lensQuery = "SELECT p.prescriptionID, p.lensID, l.name, l.price FROM prescriptions p JOIN lenses l ON p.lensID = l.lensID WHERE p.userID = ? ORDER BY p.prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(lensQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            int prescriptionID = rs.getInt("prescriptionID");
            int lensID = rs.getInt("lensID");
            String lensName = rs.getString("name");
            double lensPrice = rs.getDouble("price");
            totalPrice += lensPrice;

            // Insert into `order_items`
            String insertLensQuery = "INSERT INTO order_items (orderID, lensID, prescriptionID, quantity, price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psLens = conn.prepareStatement(insertLensQuery);
            psLens.setInt(1, orderID);
            psLens.setInt(2, lensID);
            psLens.setInt(3, prescriptionID);
            psLens.setInt(4, 1);
            psLens.setDouble(5, lensPrice);
            psLens.executeUpdate();
            psLens.close();
        }
        rs.close();
        ps.close();

        // 🔹 Step 4: Update the total price in `orders` table
        String updateOrderQuery = "UPDATE orders SET totalAmount = ? WHERE orderID = ?";
        ps = conn.prepareStatement(updateOrderQuery);
        ps.setDouble(1, totalPrice);
        ps.setInt(2, orderID);
        ps.executeUpdate();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary | Sanghavi Opticians</title>
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
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
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
        <h2 class="text-center mb-4">Order Summary</h2>
        <h4 class="mb-3">Total Price: ₹<%= totalPrice %></h4>
        
        <form action="checkout.jsp" method="post">
            <input type="hidden" name="orde rID" value="<%= orderID %>">
            <input type="hidden" name="totalAmount" value="<%= totalPrice %>">
            <button type="submit" class="btn btn-custom w-100">Proceed to Checkout</button>
        </form>
    </div>
</body>
</html>
 --%>
 
 <%-- <%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double totalPrice = 0.0;
    int orderID = -1;
    List<Map<String, String>> cartItems = new ArrayList<>();
    Map<String, String> lensDetails = new HashMap<>();
    Map<String, String> prescriptionDetails = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // 🔹 Step 1: Fetch Cart Items
        String cartQuery = "SELECT c.cartID, p.productID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
        ps = conn.prepareStatement(cartQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("productID", String.valueOf(rs.getInt("productID")));
            item.put("name", rs.getString("name"));
            item.put("images", rs.getString("images").split(",")[0]); // Taking the first image
            item.put("price", String.valueOf(rs.getDouble("finalPrice")));
            item.put("quantity", String.valueOf(rs.getInt("quantity")));
            cartItems.add(item);
            totalPrice += rs.getDouble("finalPrice") * rs.getInt("quantity");
        }
        rs.close();
        ps.close();

        // 🔹 Step 2: Fetch Lens & Prescription Details
        String lensQuery = "SELECT p.prescriptionID, p.lensID, l.name, l.type, l.price FROM prescriptions p JOIN lenses l ON p.lensID = l.lensID WHERE p.userID = ? ORDER BY p.prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(lensQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            lensDetails.put("lensID", String.valueOf(rs.getInt("lensID")));
            lensDetails.put("name", rs.getString("name"));
            lensDetails.put("type", rs.getString("type"));
            lensDetails.put("price", String.valueOf(rs.getDouble("price")));
            totalPrice += rs.getDouble("price");
        }
        rs.close();
        ps.close();

        // 🔹 Step 3: Fetch Complete Prescription Details
        String prescriptionQuery = "SELECT prescriptionID, right_sph, right_cyl, right_axis, right_add, left_sph, left_cyl, left_axis, left_add FROM prescriptions WHERE userID = ? ORDER BY prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(prescriptionQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            prescriptionDetails.put("prescriptionID", String.valueOf(rs.getInt("prescriptionID")));
            prescriptionDetails.put("right_sph", rs.getString("right_sph"));
            prescriptionDetails.put("right_cyl", rs.getString("right_cyl"));
            prescriptionDetails.put("right_axis", rs.getString("right_axis"));
            prescriptionDetails.put("right_add", rs.getString("right_add"));
            prescriptionDetails.put("left_sph", rs.getString("left_sph"));
            prescriptionDetails.put("left_cyl", rs.getString("left_cyl"));
            prescriptionDetails.put("left_axis", rs.getString("left_axis"));
            prescriptionDetails.put("left_add", rs.getString("left_add"));
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    
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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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

        .cart-container {
            background: white;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 3rem auto;
        }

        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            padding: 0.8rem 1rem;
            border: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-custom:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            color: white;
        }

        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
        
         table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        table th,
        table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            font-weight: 500;
        }
        
        </style>
</head>

<body class="d-flex flex-column min-vh-100">


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
        <h2 class="text-center mb-4">Order Summary</h2>

        <!-- Product Details -->
        <h4>Selected Products</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Price (₹)</th>
                    <th>Quantity</th>
                    <th>Subtotal (₹)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> item : cartItems) { %>
                    <tr>
                        <td><img src="<%= item.get("images") %>" alt="Product Image" width="50"></td>
                        <td><%= item.get("name") %></td>
                        <td>₹<%= item.get("price") %></td>
                        <td><%= item.get("quantity") %></td>
                        <td>₹<%= Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity")) %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Lens Details -->
        <h4>Selected Lens</h4>
        <p><strong>Lens Name:</strong> <%= lensDetails.getOrDefault("name", "No Lens Selected") %></p>
        <p><strong>Type:</strong> <%= lensDetails.getOrDefault("type", "N/A") %></p>
        <p><strong>Price:</strong> ₹<%= lensDetails.getOrDefault("price", "0.0") %></p>

        <!-- Prescription Details -->
        <h4>Prescription Details</h4>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th></th>
                    <th>SPH</th>
                    <th>CYL</th>
                    <th>AXIS</th>
                    <th>ADD</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Right Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("right_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_add", "N/A") %></td>
                </tr>
                <tr>
                    <td><strong>Left Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("left_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_add", "N/A") %></td>
                </tr>
            </tbody>
        </table>

        <h3>Total Price: ₹<%= totalPrice %></h3>
 		<a href="checkout.jsp" class="btn btn-custom mb-2">Check Out</a>
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
</html>
 
 
  --%>
<%--   <%@page import="javax.swing.text.TabableView"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double totalPrice = 0.0;
    int orderID = -1;
    List<Map<String, String>> cartItems = new ArrayList<>();
    Map<String, String> lensDetails = new HashMap<>();
    Map<String, String> prescriptionDetails = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
		
        // 🔹 Step 1: Fetch Cart Items
        String cartQuery = "SELECT c.cartID, p.productID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
        ps = conn.prepareStatement(cartQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("productID", String.valueOf(rs.getInt("productID")));
            item.put("name", rs.getString("name"));
            item.put("images", rs.getString("images").split(",")[0]); // Taking the first image
            item.put("price", String.valueOf(rs.getDouble("finalPrice")));
            item.put("quantity", String.valueOf(rs.getInt("quantity")));
            cartItems.add(item);
            totalPrice += rs.getDouble("finalPrice") * rs.getInt("quantity");
        }
        rs.close();
        ps.close();

        // 🔹 Step 2: Fetch Lens & Prescription Details
        String lensQuery = "SELECT p.prescriptionID, p.lensID, l.name, l.type, l.price FROM prescriptions p JOIN lenses l ON p.lensID = l.lensID WHERE p.userID = ? ORDER BY p.prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(lensQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
        	
            lensDetails.put("lensID", String.valueOf(rs.getInt("lensID")));
            lensDetails.put("name", rs.getString("name"));
            lensDetails.put("type", rs.getString("type"));
            lensDetails.put("price", String.valueOf(rs.getDouble("price")));
            totalPrice += rs.getDouble("price");
        }
        rs.close();
        ps.close();

        // 🔹 Step 3: Fetch Complete Prescription Details
        String prescriptionQuery = "SELECT prescriptionID, right_sph, right_cyl, right_axis, right_add, left_sph, left_cyl, left_axis, left_add FROM prescriptions WHERE userID = ? ORDER BY prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(prescriptionQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            prescriptionDetails.put("prescriptionID", String.valueOf(rs.getInt("prescriptionID")));
            prescriptionDetails.put("right_sph", rs.getString("right_sph"));
            prescriptionDetails.put("right_cyl", rs.getString("right_cyl"));
            prescriptionDetails.put("right_axis", rs.getString("right_axis"));
            prescriptionDetails.put("right_add", rs.getString("right_add"));
            prescriptionDetails.put("left_sph", rs.getString("left_sph"));
            prescriptionDetails.put("left_cyl", rs.getString("left_cyl"));
            prescriptionDetails.put("left_axis", rs.getString("left_axis"));
            prescriptionDetails.put("left_add", rs.getString("left_add"));
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    
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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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

        .cart-container {
            background: white;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 3rem auto;
        }

        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            padding: 0.8rem 1rem;
            border: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-custom:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            color: white;
        }

        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
        
         table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        table th,
        table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
            color: white;
        }

        table th {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            font-weight: 500;
        }
        
        </style>
</head>

<body class="d-flex flex-column min-vh-100">


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
        <h2 class="text-center mb-4">Order Summary</h2>

        <!-- Product Details -->
        <h4>Selected Products</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Price (₹)</th>
                    <th>Quantity</th>
                    <th>Subtotal (₹)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> item : cartItems) { %>
                    <tr>
                        <td><img src="<%= item.get("images") %>" alt="Product Image" width="50"></td>
                        <td><%= item.get("name") %></td>
                        <td>₹<%= item.get("price") %></td>
                        <td><%= item.get("quantity") %></td>
                        <td>₹<%= Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity")) %></td>
                    </tr>
             
        <!-- Lens Details -->
       <tr>
       <td></td>
       <td> <%= lensDetails.getOrDefault("name", "No Lens Selected") %></td>
        <td><%= lensDetails.getOrDefault("type", "N/A") %></td>
         <td><%= item.get("quantity") %></td>
         <td>₹<%= lensDetails.getOrDefault("price", "0.0") %></td>
         <td>₹<%= Double.parseDouble(lensDetails.get("price")) * Integer.parseInt(item.get("quantity")) %></td>
        </tr>
   <% } %>
            </tbody>
        </table>

        <!-- Prescription Details -->
        <h4>Prescription Details</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Eyes</th>
                    <th>SPH</th>
                    <th>CYL</th>
                    <th>AXIS</th>
                    <th>ADD</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Right Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("right_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_add", "N/A") %></td>
                </tr>
                <tr>
                    <td><strong>Left Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("left_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_add", "N/A") %></td>
                </tr>
            </tbody>
        </table>

        <h3>Total Price: ₹<%= totalPrice %></h3>
 		<a href="checkout.jsp" class="btn btn-custom mb-2">Check Out</a>
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
</html>
 
 
  --%>
  <%@page import="javax.swing.text.TabableView"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double totalPrice = 0.0;
    int orderID = -1;
    List<Map<String, String>> cartItems = new ArrayList<>();
    Map<String, String> lensDetails = new HashMap<>();
    Map<String, String> prescriptionDetails = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
        
        // 🔹 Step 1: Fetch Cart Items
        String cartQuery = "SELECT c.cartID, p.productID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
        ps = conn.prepareStatement(cartQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("productID", String.valueOf(rs.getInt("productID")));
            item.put("name", rs.getString("name"));
            item.put("images", rs.getString("images").split(",")[0]); // Taking the first image
            item.put("price", String.valueOf(rs.getDouble("finalPrice")));
            item.put("quantity", String.valueOf(rs.getInt("quantity")));
            cartItems.add(item);
            totalPrice += rs.getDouble("finalPrice") * rs.getInt("quantity");
        }
        rs.close();
        ps.close();

        // 🔹 Step 2: Fetch Lens & Prescription Details
        String lensQuery = "SELECT p.prescriptionID, p.lensID, l.name, l.type, l.price FROM prescriptions p JOIN lenses l ON p.lensID = l.lensID WHERE p.userID = ? ORDER BY p.prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(lensQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            lensDetails.put("lensID", String.valueOf(rs.getInt("lensID")));
            lensDetails.put("name", rs.getString("name"));
            lensDetails.put("type", rs.getString("type"));
            lensDetails.put("price", String.valueOf(rs.getDouble("price")));
            totalPrice += rs.getDouble("price");
        }
        rs.close();
        ps.close();

        // 🔹 Step 3: Fetch Complete Prescription Details
        String prescriptionQuery = "SELECT prescriptionID, right_sph, right_cyl, right_axis, right_add, left_sph, left_cyl, left_axis, left_add FROM prescriptions WHERE userID = ? ORDER BY prescriptionID DESC LIMIT 1";
        ps = conn.prepareStatement(prescriptionQuery);
        ps.setInt(1, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            prescriptionDetails.put("prescriptionID", String.valueOf(rs.getInt("prescriptionID")));
            prescriptionDetails.put("right_sph", rs.getString("right_sph"));
            prescriptionDetails.put("right_cyl", rs.getString("right_cyl"));
            prescriptionDetails.put("right_axis", rs.getString("right_axis"));
            prescriptionDetails.put("right_add", rs.getString("right_add"));
            prescriptionDetails.put("left_sph", rs.getString("left_sph"));
            prescriptionDetails.put("left_cyl", rs.getString("left_cyl"));
            prescriptionDetails.put("left_axis", rs.getString("left_axis"));
            prescriptionDetails.put("left_add", rs.getString("left_add"));
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
        display: flex;
        flex-direction: column;
        min-height: 100vh;
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

    .cart-container {
        background: white;
        padding: 1rem;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        margin: 3rem auto;
    }

    .btn-custom {
        background-color: var(--primary-color);
        color: white;
        padding: 0.8rem 1rem;
        border: none;
        border-radius: 5px;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .btn-custom:hover {
        background-color: var(--secondary-color);
        transform: translateY(-2px);
        color: white;
    }

    footer {
        background: linear-gradient(to right, var(--primary-color), var(--accent-color));
        color: white;
        padding: 2rem 0;
        margin-top: auto;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }

    table th,
    table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: left;
        color: white;
    }

    table th {
        background: linear-gradient(to right, var(--primary-color), var(--accent-color));
        color: white;
        font-weight: 500;
    }
    
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <!-- Navigation -->
      <jsp:include page="w.jsp" />
    
<div class="container mt-5">
    <h2 class="text-center mb-4">Order Summary</h2>

    <!-- Product Details -->
    <h4>Selected Products</h4>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Price (₹)</th>
                <th>Quantity</th>
                <th>Subtotal (₹)</th>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, String> item : cartItems) { %>
                <tr>
                    <td><img src="<%= item.get("images") %>" alt="Product Image" width="50"></td>
                    <td><%= item.get("name") %></td>
                    <td>₹<%= item.get("price") %></td>
                    <td><%= item.get("quantity") %></td>
                    <td>₹<%= Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity")) %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <%-- Check if lens type is Single Vision --%>
    <%
        String lensType = lensDetails.getOrDefault("type", "");
    %>

    <%-- Display Prescription Details only if lens type is not Single Vision --%>

    <h4>Lens Details</h4>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Lenses</th>
                <th>Type</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= lensDetails.getOrDefault("name", "No Lens Selected") %></td>
                <td><%= lensDetails.getOrDefault("type", "N/A") %></td>
                <td>₹<%= Double.parseDouble(lensDetails.getOrDefault("price", "0.0")) %></td>
            </tr>
        </tbody>
    </table>
    <% if (!lensType.equalsIgnoreCase("Single Vision")) { %>
        <h4>Prescription Details</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Eyes</th>
                    <th>SPH</th>
                    <th>CYL</th>
                    <th>AXIS</th>
                    <th>ADD</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Right Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("right_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("right_add", "N/A") %></td>
                </tr>
                <tr>
                    <td><strong>Left Eye</strong></td>
                    <td><%= prescriptionDetails.getOrDefault("left_sph", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_cyl", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_axis", "N/A") %></td>
                    <td><%= prescriptionDetails.getOrDefault("left_add", "N/A") %></td>
                </tr>
            </tbody>
        </table>
    <% } %>

    <h3>Total Price: ₹<%= totalPrice %></h3>
    <a href="checkout.jsp" class="btn btn-custom mb-2">Check Out</a>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
  