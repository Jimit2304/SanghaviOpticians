<%-- <%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Orders - Admin Panel</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="style.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
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

        .sidebar {
            width: 350px;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px;
            min-height: 100vh;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 5px;
            margin-bottom: 5px;
        }

        .sidebar ul li:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }

        .content {
            flex: 1;
            padding: 20px;
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

        .btn-custom {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-delete {
            background: linear-gradient(to right, #f44336, #d32f2f);
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
                    <li class="nav-item"><a class="nav-link" href="admin.html">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
        <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar">
           <ul>
<li onclick="window.location.href='admin.html'"><i class="fas fa-chart-line me-2"></i>Dashboard
                        </li>
                        <li onclick="window.location.href='manage.jsp'"><i class="fas fa-glasses me-2"></i>Manage
                            Products</li>
                        <li onclick="window.location.href='addProduct.html'"><i class="fas fa-plus-circle me-2"></i>Add
                            Products</li>
                        <li onclick="window.location.href='manageuser.jsp'"><i class="fas fa-users me-2"></i>Manage
                            Users</li>

                        <li onclick="window.location.href='coupons.html'"><i class="fas fa-ticket-alt me-2"></i> Apply
                            Coupons</li>
                        <li onclick="window.location.href='view_coupons.jsp'"><i
                                class="fas fa-ticket-alt me-2"></i>Manage Coupons</li>
                        <li onclick="window.location.href='addLens.jsp'"><i class="fas fa-plus-circle me-2"></i>Add Lens
                        </li>
                        <li onclick="window.location.href='manageLens.jsp'"><i class="fas fa-tag me-2"></i>Manage Lens
                        </li>
                        <li onclick="window.location.href='book.jsp'"><i class="fas fa-calendar-check me-2"></i>Book
                        </li>
                        <li onclick="window.location.href='cartAdmin.jsp'"><i class="fas fa-shopping-cart me-2"></i>Cart
                            Management</li>
                            <li onclick="window.location.href='adminWishlist.jsp'"><i class="fas fa-heart me-2"></i>Wishlist
                     </li>
                     <li onclick="window.location.href='order.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order</li>
                          
            </ul>
                        </div>

<div class="container mt-4">
    <h2>All Orders</h2>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Payment</th>
                <th>Total Amount</th>
                <th>Items</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        String sql ="SELECT " +
                "o.orderID, o.fullName, o.email, o.phone, o.address, " +
                "o.paymentMethod, o.orderStatus, o.createdAt, " +
                "COUNT(oi.orderItemID) AS totalItems, " +
                "SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
                "FROM orders o " +
                "JOIN order_items oi ON o.orderID = oi.orderID " +
                "JOIN products p ON oi.productID = p.productID " +
                "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
                "GROUP BY o.orderID " +
                "ORDER BY o.orderID DESC";

        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while(rs.next()){
%>
            <tr>
                <td><%= rs.getInt("orderID") %></td>
                <td><%= rs.getString("fullName") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("paymentMethod") %></td>
                <td>₹<%= rs.getDouble("totalAmount") %></td>
                <td><%= rs.getInt("totalItems") %></td>
                <td>
                    <form method="post" action="updateStatus.jsp" style="display:flex; flex-direction:column;">
                        <input type="hidden" name="orderID" value="<%= rs.getInt("orderID") %>">
                        <select name="orderStatus" class="form-select mb-1" style="width: 150px;">
                            <option value="Pending" <%= rs.getString("orderStatus").equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Processing" <%= rs.getString("orderStatus").equals("Processing") ? "selected" : "" %>>Processing</option>
                            <option value="Shipped" <%= rs.getString("orderStatus").equals("Shipped") ? "selected" : "" %>>Shipped</option>
                            <option value="Delivered" <%= rs.getString("orderStatus").equals("Delivered") ? "selected" : "" %>>Delivered</option>
                            <option value="Cancelled" <%= rs.getString("orderStatus").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                        </select>
                        <button type="submit" class="btn btn-sm btn-custom">Update</button>
                    </form>
                </td>
                <td><%= rs.getTimestamp("createdAt") %></td>
                <td><a href="order_items.jsp?orderID=<%= rs.getInt("orderID") %>">View Items</a></td>
            </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='12'>Error: "+ e.getMessage() +"</td></tr>");
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
%>
        </tbody>
    </table>
</div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%>
 
 
 <%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Orders - Admin Panel</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="style.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
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

        .sidebar {
            width: 350px;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px;
            min-height: 100vh;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 5px;
            margin-bottom: 5px;
        }

        .sidebar ul li:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }

        .content {
            flex: 1;
            padding: 20px;
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

        .btn-custom {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-delete {
            background: linear-gradient(to right, #f44336, #d32f2f);
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
                    <li class="nav-item"><a class="nav-link" href="ad.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
        <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar">
           <ul>
<li onclick="window.location.href='ad.jsp'"><i class="fas fa-chart-line me-2"></i>Dashboard
                        </li>
                        <li onclick="window.location.href='manage.jsp'"><i class="fas fa-glasses me-2"></i>Manage
                            Products</li>
                        <li onclick="window.location.href='addProduct.html'"><i class="fas fa-plus-circle me-2"></i>Add
                            Products</li>
                        <li onclick="window.location.href='manageuser.jsp'"><i class="fas fa-users me-2"></i>Manage
                            Users</li>

                        <li onclick="window.location.href='coupons.html'"><i class="fas fa-ticket-alt me-2"></i> Apply
                            Coupons</li>
                        <li onclick="window.location.href='view_coupons.jsp'"><i
                                class="fas fa-ticket-alt me-2"></i>Manage Coupons</li>
                        <li onclick="window.location.href='addLens.jsp'"><i class="fas fa-plus-circle me-2"></i>Add Lens
                        </li>
                        <li onclick="window.location.href='manageLens.jsp'"><i class="fas fa-tag me-2"></i>Manage Lens
                        </li>
                        <li onclick="window.location.href='book.jsp'"><i class="fas fa-calendar-check me-2"></i>Book
                        </li>
                        <li onclick="window.location.href='cartAdmin.jsp'"><i class="fas fa-shopping-cart me-2"></i>Cart
                            Management</li>
                            <li onclick="window.location.href='adminWishlist.jsp'"><i class="fas fa-heart me-2"></i>Wishlist
                     </li>
                     <li onclick="window.location.href='order.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order</li>
                          
            </ul>
                        </div>

<div class="container mt-4">
    <h2>All Orders</h2>

    <table class="table table-striped">
        <thead class="table-dark">
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Payment</th>
                <th>Total Amount</th>
                <th>Items</th>
                <th>Status</th>
                <th>Order Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        String sql ="SELECT " +
                "o.orderID, o.fullName, o.email, o.phone, o.address, " +
                "o.paymentMethod, o.orderStatus, o.createdAt, " +
                "COUNT(oi.orderItemID) AS totalItems, " +
                "SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
                "FROM orders o " +
                "JOIN order_items oi ON o.orderID = oi.orderID " +
                "JOIN products p ON oi.productID = p.productID " +
                "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
                "GROUP BY o.orderID " +
                "ORDER BY o.orderID DESC";

        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while(rs.next()){
%>
            <tr>
                <td><%= rs.getInt("orderID") %></td>
                <td><%= rs.getString("fullName") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("paymentMethod") %></td>
                <td>₹<%= rs.getDouble("totalAmount") %></td>
                <td><%= rs.getInt("totalItems") %></td>
                <td>
                    <form method="post" action="updateStatusadmin.jsp" style="display:flex; flex-direction:column;">
                        <input type="hidden" name="orderID" value="<%= rs.getInt("orderID") %>">
                        <select name="orderStatus" class="form-select mb-1" style="width: 150px;">
                            <option value="Pending" <%= rs.getString("orderStatus").equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Processing" <%= rs.getString("orderStatus").equals("Processing") ? "selected" : "" %>>Processing</option>
                            <option value="Shipped" <%= rs.getString("orderStatus").equals("Shipped") ? "selected" : "" %>>Shipped</option>
                            <option value="Delivered" <%= rs.getString("orderStatus").equals("Delivered") ? "selected" : "" %>>Delivered</option>
                            <option value="Cancelled" <%= rs.getString("orderStatus").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                        </select>
                        <button type="submit" class="btn btn-sm btn-custom">Update</button>
                    </form>
                </td>
                <td><%= rs.getTimestamp("createdAt") %></td>
                <td>
   <a href="order_items.jsp?orderID=<%= rs.getInt("orderID") %>" class="btn btn-sm btn-custom">
      View Items
   </a>
</td>
                
            </tr>
<%
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='12'>Error: "+ e.getMessage() +"</td></tr>");
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
%>
        </tbody>
    </table>
    
</div>

</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>