<%-- <%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int orderID = 0;
    if (request.getParameter("orderID") != null) {
        orderID = Integer.parseInt(request.getParameter("orderID"));
    }

    String orderStatus = "";
    double totalAmount = 0.0;
    String paymentMethod = "";
    String address = "";
    Timestamp  createdAt   = null;
    List<Map<String, Object>> orderItems = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Fetch order details
        String orderQuery = "SELECT orderID, totalAmount,  createdAt  , orderStatus, paymentMethod, address " +
                            "FROM orders WHERE orderID = ? AND userID = ?";
        ps = conn.prepareStatement(orderQuery);
        ps.setInt(1, orderID);
        ps.setInt(2, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalAmount = rs.getDouble("totalAmount");
            createdAt   = rs.getTimestamp("createdAt");
            orderStatus = rs.getString("orderStatus");
            paymentMethod = rs.getString("paymentMethod");
            address = rs.getString("address");
        }
        rs.close();
        ps.close();

        // Fetch ordered items
        String itemsQuery = "SELECT p.name, oi.quantity, oi.price FROM order_items oi " +
                            "JOIN products p ON oi.productID = p.productID WHERE oi.orderID = ?";
        ps = conn.prepareStatement(itemsQuery);
        ps.setInt(1, orderID);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", rs.getString("name"));
            item.put("quantity", rs.getInt("quantity"));
            item.put("price", rs.getDouble("price"));
            orderItems.add(item);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a237e;
            --secondary-color: #ff5722;
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
        <h2 class="text-center mb-4">Order Confirmation</h2>

        <p class="text-center text-success fw-bold">Thank you for your order! Your order has been placed successfully.</p>

        <h4>Order Details</h4>
        <p><strong>Order ID:</strong> <%= orderID %></p>
        <p><strong>Order Date:</strong> <%=createdAt%></p>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Shipping Address:</strong> <%= address %></p>
        <p><strong>orderStatus:</strong> <%= orderStatus %></p>

        <h4>Ordered Items</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price (₹)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> item : orderItems) { %>
                <tr>
                    <td><%= item.get("name") %></td>
                    <td><%= item.get("quantity") %></td>
                    <td>₹<%= item.get("price") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h3 class="text-end">Total Amount: ₹<%= totalAmount %></h3>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-custom">Continue Shopping</a>
        </div>
    </div>

</body>
</html>
 --%>
<%--  <%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int orderID = 0;
    if (request.getParameter("orderID") != null) {
        orderID = Integer.parseInt(request.getParameter("orderID"));
    }

    String orderStatus = "";
    double totalAmount = 0.0;
    String paymentMethod = "";
    String address = "";
    Timestamp createdAt = null;
    List<Map<String, Object>> orderItems = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Fetch order details
        String orderQuery = "SELECT orderID, totalAmount, createdAt, orderStatus, paymentMethod, address " +
                            "FROM orders WHERE orderID = ? AND userID = ?";
        ps = conn.prepareStatement(orderQuery);
        ps.setInt(1, orderID);
        ps.setInt(2, userID);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalAmount = rs.getDouble("totalAmount");
            createdAt = rs.getTimestamp("createdAt");
            orderStatus = rs.getString("orderStatus");
            paymentMethod = rs.getString("paymentMethod");
            address = rs.getString("address");
        }
        rs.close();
        ps.close();

        // Fetch ordered items including lens details
        String itemsQuery = "SELECT p.name AS productName, oi.quantity, oi.Oprice, " +
                            "l.name AS lensName, l.type AS lensType, l.material AS lensMaterial, " +
                            "l.coating AS lensCoating, l.coatingColor AS lensCoatingColor, l.price AS lensPrice " +
                            "FROM order_items oi " +
                            "JOIN products p ON oi.productID = p.productID " +
                            "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
                            "WHERE oi.orderID = ?";
        ps = conn.prepareStatement(itemsQuery);
        ps.setInt(1, orderID);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", rs.getString("productName"));
            item.put("quantity", rs.getInt("quantity"));
            item.put("Oprice", rs.getDouble("Oprice"));
            item.put("lensName", rs.getString("lensName"));
            item.put("lensType", rs.getString("lensType"));
            item.put("lensMaterial", rs.getString("lensMaterial"));
            item.put("lensCoating", rs.getString("lensCoating"));
            item.put("lensCoatingColor", rs.getString("lensCoatingColor"));
            item.put("lensPrice", rs.getDouble("lensPrice"));
            orderItems.add(item);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a237e;
            --secondary-color: #ff5722;
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
        <h2 class="text-center mb-4">Order Confirmation</h2>

        <p class="text-center text-success fw-bold">Thank you for your order! Your order has been placed successfully.</p>

        <h4>Order Details</h4>
        <p><strong>Order ID:</strong> <%= orderID %></p>
        <p><strong>Order Date:</strong> <%= createdAt %></p>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Shipping Address:</strong> <%= address %></p>
        <p><strong>Order Status:</strong> <%= orderStatus %></p>

        <h4>Ordered Items</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Product Price (₹)</th>
                    <th>Lens Name</th>
                    <th>Lens Price (₹)</th>
                    <th>Total Item Price (₹)</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> item : orderItems) { %>
                <tr>
                    <td><%= item.get("name") %></td>
                    <td><%= item.get("quantity") %></td>
                    <td>₹<%= item.get("Oprice") %></td>
                    <td><%= (item.get("lensName") != null) ? item.get("lensName") : "No Lens" %></td>
                    <td>₹<%= item.get("lensPrice") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-custom">Continue Shopping</a>
        </div>
    </div>
</body>
</html> --%>
<%--  
 <%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; padding: 20px; }
        .container { max-width: 800px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        h2 { text-align: center; }
        .order-details, .product-details { margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        table, th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        .btn { display: block; width: 200px; margin: 20px auto; padding: 10px; text-align: center; background: green; color: white; text-decoration: none; border-radius: 5px; }
        .btn:hover { background: darkgreen; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Order Confirmation</h2>

        <%
            Integer userID = (Integer) session.getAttribute("userID");
            if (userID == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String orderID = request.getParameter("orderID");

            if (orderID == null) {
                out.println("<p>Invalid order ID.</p>");
                return;
            }

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                // Fetch order details
                String orderQuery = "SELECT fullName, email, phone, address, city, pincode, paymentMethod, totalAmount, orderStatus, createdAt FROM orders WHERE orderID = ? AND userID = ?";
                ps = conn.prepareStatement(orderQuery);
                ps.setInt(1, Integer.parseInt(orderID));
                ps.setInt(2, userID);
                rs = ps.executeQuery();

                if (rs.next()) {
        %>
                <div class="order-details">
                    <p><strong>Order ID:</strong> <%= orderID %></p>
                    <p><strong>Name:</strong> <%= rs.getString("fullName") %></p>
                    <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                    <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
                    <p><strong>Address:</strong> <%= rs.getString("address") %>, <%= rs.getString("city") %> - <%= rs.getString("pincode") %></p>
                    <p><strong>Payment Method:</strong> <%= rs.getString("paymentMethod") %></p>
                    <p><strong>Total Amount:</strong> ₹<%= rs.getDouble("totalAmount") %></p>
                    <p><strong>Order Status:</strong> <%= rs.getString("orderStatus") %></p>
                    <p><strong>Placed On:</strong> <%= rs.getTimestamp("createdAt") %></p>
                </div>

                <h3>Ordered Products</h3>
                <table>
                    <tr>
                        <th>Product</th>
                        <th>Lens</th>
                        <th>Prescription</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
        <%
                }

                // Fetch order items with product and lens details
                String itemsQuery = "SELECT p.name AS productName, l.name AS lensName, l.price AS lensPrice, " +
                                    "oi.quantity, oi.Oprice, pres.right_sph, pres.right_cyl, pres.right_axis, pres.right_add, " +
                                    "pres.left_sph, pres.left_cyl, pres.left_axis, pres.left_add " +
                                    "FROM order_items oi " +
                                    "JOIN products p ON oi.productID = p.productID " +
                                    "LEFT JOIN prescriptions pres ON oi.lensID = pres.lensID AND pres.userID = ? " +
                                    "LEFT JOIN lenses l ON pres.lensID = l.lensID " +
                                    "WHERE oi.orderID = ?";
                ps = conn.prepareStatement(itemsQuery);
                ps.setInt(1, userID);
                ps.setInt(2, Integer.parseInt(orderID));
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString("productName") %></td>
                        <td><%= rs.getString("lensName") %> (₹<%= rs.getDouble("lensPrice") %>)</td>
                        <td>
                            <strong>Right Eye:</strong> SPH: <%= rs.getString("right_sph") %>, CYL: <%= rs.getString("right_cyl") %>, AXIS: <%= rs.getString("right_axis") %>, ADD: <%= rs.getString("right_add") %><br>
                            <strong>Left Eye:</strong> SPH: <%= rs.getString("left_sph") %>, CYL: <%= rs.getString("left_cyl") %>, AXIS: <%= rs.getString("left_axis") %>, ADD: <%= rs.getString("left_add") %>
                        </td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td>₹<%= rs.getDouble("Oprice") %></td>
                    </tr>
        <%
                }
        %>
                </table>
                <a href="index.jsp" class="btn">Continue Shopping</a>
        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error fetching order details. Please try again later.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html> --%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
     <style>:root {
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

        .confirmation-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 3rem;
            margin: 3rem auto;
            text-align: center;
        }

        .success-icon {
            color: #2ecc71;
            font-size: 5rem;
            margin-bottom: 2rem;
        }

        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px 0;
            margin-top: auto;
        }

        .order-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border: none;
            padding: 0.8rem 2rem;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .social-icons a:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }
     </style>
</head>
<body>
         <jsp:include page="w.jsp" />   


    <div class="container">
        <div class="confirmation-container">
            <i class="fas fa-check-circle success-icon"></i>
            <h2>Thank You for Your Purchase!</h2>
            <p class="lead">Your order has been successfully placed.</p>
            
            <div class="order-details">
                <h4>Order Details</h4>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
                        
                        String orderQuery = "SELECT * FROM orders WHERE orderID = ?";
                        ps = conn.prepareStatement(orderQuery);
                        ps.setInt(1, Integer.parseInt(request.getParameter("orderID")));
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            //out.println("<p><strong>Order Number:</strong> #" + rs.getInt("orderID") + "</p>");
                            out.println("<p><strong>Order Date:</strong> " + rs.getString("createdAt") + "</p>");
                            out.println("<p><strong>Name:</strong> " + rs.getString("fullName") + "</p>");
                            out.println("<p><strong>Contact:</strong> " + rs.getString("phone") + "</p>");
                            out.println("<p><strong>Shipping Address:</strong> " + rs.getString("address") + "</p>");
                           
                        } else {
                            out.println("<p>No order details found.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching order details. Please try again later.</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>
<div style="background-color:#e6f7ff; color:#0050b3; padding:10px; text-align:center; font-weight:bold; border-radius:5px; margin-top:20px;">
    Your order will be delivered in 3 days
</div>

            <div class="mt-4">
                <a href="index.jsp" class="btn btn-primary me-3">Continue Shopping</a>
            </div>
        </div>
    </div>
<br>
  <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 