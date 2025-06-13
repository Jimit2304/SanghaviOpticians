<%-- <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
    int userID = (session.getAttribute("userID") != null) ? (int) session.getAttribute("userID") : -1;
    if (userID == -1) {
        response.sendRedirect("login.jsp"); // Redirect if user not logged in
        return;
    }
%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Shopping Cart | Sanghavi Opticians</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="style.css">
            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
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
                    padding: 2rem;
                    border-radius: 10px;
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                    margin: 3rem auto;
                }

                .cart-item {
                    border-bottom: 1px solid #eee;
                    padding: 1rem 0;
                }

                .btn-custom {
                    background-color: var(--secondary-color);
                    color: white;
                    padding: 0.8rem 2rem;
                    border: none;
                    border-radius: 5px;
                    transition: all 0.3s ease;
                    text-decoration: none;
                    display: inline-block;
                    margin: 0.5rem;
                }

                .btn-custom:hover {
                    background-color: var(--primary-color);
                    transform: translateY(-2px);
                    color: white;
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
                    <a class="navbar-brand" href="index.jsp">Sanghavi Opticians</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="product.jsp">Shop</a></li>
                            <li class="nav-item"><a class="nav-link" href="wishlist.jsp">WishList</a></li>
                            <li class="nav-item"><a class="nav-link" href="dashboard.html">Account</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container cart-container">
                <h2 class="text-center mb-4">Shopping Cart</h2>
                <% Connection conn=null; PreparedStatement ps=null; ResultSet rs=null; double total=0.0; try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123" );
                   // int userID=(session.getAttribute("userID") !=null) ? (Integer) session.getAttribute("userID") : 0;
                    if(userID> 0) {
                    String query = "SELECT c.cartID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, userID);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                    int cartID = rs.getInt("cartID");
                    String name = rs.getString("name");
                    String image = rs.getString("images");
                    double finalPrice = rs.getDouble("finalPrice");
                    int quantity = rs.getInt("quantity");
                    double itemTotal = finalPrice * quantity;
                    total += itemTotal;
                    %>

                    <div class="cart-item row align-items-center">
                        <div class="col-md-3">
                            <img src="<%= image %>" class="img-fluid rounded">
                        </div>
                        <div class="col-md-6">
                            <h5 class="mb-2">
                                <%= name %>
                            </h5>
                            <p class="text-muted mb-1">Quantity: <%= quantity %>
                            </p>
                            <p class="fw-bold mb-0">₹<%= finalPrice %>
                            </p>
                        </div>
                        <div class="col-md-3 text-end">
                            <a href="removeCart.jsp?cartID=<%= cartID %>" class="btn-custom mb-2">Remove</a>
                        </div>
                    </div>

                    <% } } else { out.println("<p class='text-center'>Your cart is empty.</p>");
                        }
                        } catch (Exception e) {
                        e.printStackTrace();
                        } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (ps != null) try { ps.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                        }
                        %>

                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <h4 class="fw-bold">Total: ₹<%= total %>
                            </h4>
                            <a href="checkout.jsp" class="btn-custom">Proceed to Checkout</a>
                        </div>
            </div>

            <footer class="mt-auto">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <h5>Sanghavi Opticians</h5>
                            <p class="text-white-50">Your trusted partner for premium eyewear since 1990</p>
                        </div>
                        <div class="col-md-4">
                            <h5>Quick Links</h5>
                            <ul class="list-unstyled">
                                <li><a href="#" class="text-white-50 text-decoration-none">About Us</a></li>
                                <li><a href="#" class="text-white-50 text-decoration-none">Contact</a></li>
                                <li><a href="#" class="text-white-50 text-decoration-none">Store Locator</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4">
                            <h5>Connect With Us</h5>
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

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html> --%>
        
      <%--   <%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check if user is logged in
    int userID = (session.getAttribute("userID") != null) ? (int) session.getAttribute("userID") : -1;
    if (userID == -1) {
        response.sendRedirect("login.jsp");
        return;
    }
%> --%>
<%-- <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | Sanghavi Opticians</title>
    <!-- Bootstrap CSS -->
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
                    <li class="nav-item"><a class="nav-link" href="product.jsp">Shop</a></li>
                    <li class="nav-item"><a class="nav-link" href="wishlist.jsp">WishList</a></li>
                    <li class="nav-item"><a class="nav-link" href="dashboard.html">Account</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container cart-container">
        <h2 class="text-center mb-4">Shopping Cart</h2>

        <% 
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            double total = 0.0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                if (userID > 0) {
                    String query = "SELECT c.cartID, p.name, p.images, p.finalPrice, c.quantity FROM cart c JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, userID);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int cartID = rs.getInt("cartID");
                        String name = rs.getString("name");
                        String image = rs.getString("images");
                        double finalPrice = rs.getDouble("finalPrice");
                        int quantity = rs.getInt("quantity");
                        double itemTotal = finalPrice * quantity;
                        total += itemTotal;
        %>
<div class="card mb-3 shadow-sm">
    <div class="card-body">
        <div class="row align-items-center">
            <div class="col-md-3">
                <img src="<%= image %>" class="img-fluid rounded">
            </div>
            <div class="col-md-6">
                <h5 class="mb-2"><%= name %></h5>
                <form action="updateCart.jsp" method="POST" class="d-flex align-items-center">
                    <input type="hidden" name="cartID" value="<%= cartID %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" class="form-control me-2" style="width: 80px;">
                    <button type="submit" class="btn btn-custom">Update</button>
                </form>
                <p class="fw-bold mt-2 text-danger">₹<%= finalPrice %></p>
            </div>
            <div class="col-md-3 text-end">
                <a href="removeCart.jsp?cartID=<%= cartID %>" class="btn btn-custom mb-2">Remove</a>
            </div>
        </div>
    </div>
</div>


        <% } } else { %>
        <p class="text-center">Your cart is empty.</p>
        <% } } catch (Exception e) { e.printStackTrace(); } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        } %>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4 class="fw-bold">Total: ₹<%= total %></h4>
            <a href="select.jsp" class="btn-custom">Proceed to Checkout</a>
        </div>
    </div>

<footer class="py-4"
                style="background: linear-gradient(135deg, var(--primary-color), var(--accent-color));">
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


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html> --%>
        <%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get user ID from session
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp"); // Redirect if user is not logged in
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double total = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | Sanghavi Opticians</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>

<body>
    <!-- Navbar -->
       <!-- Navigation -->
              <jsp:include page="w.jsp" />

    <!-- Shopping Cart -->
    <div class="container cart-container">
        <h2 class="text-center mb-4">Shopping Cart</h2>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                String query = "SELECT c.cartID, p.name,p.category, p.images, p.finalPrice, c.quantity FROM cart c " +
                        "JOIN products p ON c.productID = p.productID WHERE c.userID = ?";

                ps = conn.prepareStatement(query);
                ps.setInt(1, userID);
                rs = ps.executeQuery();

                boolean hasItems = false;
                while (rs.next()) {
                    hasItems = true;
                    int cartID = rs.getInt("cartID");
                    String name = rs.getString("name");
                    String image = rs.getString("images");
                    int finalPrice = rs.getInt("finalPrice");
                    int quantity = rs.getInt("quantity");
                    double itemTotal = finalPrice * quantity;
                    total += itemTotal;
        %>

        <div class="card mb-3 shadow-sm">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <img src="<%= image %>" class="img-fluid rounded">
                    </div>
                    <div class="col-md-6">
                    
                        <h5 class="mb-2"> <%= name %></h5>
                           <form action="updateCart.jsp" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="cartID" value="<%= cartID %>">
                            <input type="number" name="quantity" value="<%= quantity %>" min="1" class="form-control me-2" style="width: 80px;">
                            <button type="submit" class="btn btn-custom">Update</button> 
                        </form>
                        <p class="fw-bold mt-2 text-danger">₹<%= finalPrice %></p>
                    </div>
                    <div class="col-md-3 text-end">
                        <a href="removeCart.jsp?cartID=<%= cartID %>" class="btn btn-custom mb-2">Remove</a>
                    </div>
                </div>
            </div>
        </div>

        <% } if (!hasItems) { %>
        <p class="text-center">Your cart is empty.</p>
        <% } } catch (Exception e) { e.printStackTrace(); } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } %>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4 class="fw-bold">Total: ₹<%= total %></h4>
            <% if (total > 0) { %>
                <a href="select.jsp" class="btn-custom">Proceed to Select Lenses</a>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
   <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
        