<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products | Sanghavi Opticians</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
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
            width: 250px;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px;
            min-height: 100vh;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        form input, form select, form textarea {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
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

        .dashboard {
            display: none;
        }

        .active {
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        table th, table td {
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
            margin: 5px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .btn-delete {
            background: linear-gradient(to right, #f44336, #d32f2f);
        }

        h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .card h3 {
            color: var(--primary-color);
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px 0;
            margin-top: 20px;
        }
    </style>
</head>

<body>

    <!-- Navbar -->
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
                       <li onclick="window.location.href='order.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order
                     </li>
        </ul>
        
        
        </div>



    
    <div class="container">
        <div class="content">
            <div id="dashboard" class="dashboard active">
                <h2>Dashboard</h2>
                <div class="row">
                    <!-- Total Users Section -->
                    <div class="col-md-6">
                        <div class="card">
                            <h3><i class="fas fa-users me-2"></i>Total Users: 
                            <% 
                                Connection conn = null;
                                PreparedStatement stmt = null;
                                ResultSet rs = null;
                                int totalUsers = 0;
                                
                                try {
                                    // Step 1: Establish database connection
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
                                    
                                    // Step 2: Create SQL query for total users
                                    String queryUsers = "SELECT COUNT(*) AS total_users FROM users WHERE role = 'User'";
                                    stmt = conn.prepareStatement(queryUsers);
                                    
                                    // Step 3: Execute query
                                    rs = stmt.executeQuery();
                                    
                                    // Step 4: Process result for users
                                    if (rs.next()) {
                                        totalUsers = rs.getInt("total_users");
                                    }
                            %>
                            <%= totalUsers %>  <!-- Display the total number of users -->
                            <% 
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) rs.close();
                                        if (stmt != null) stmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            %>
                            </h3>
                        </div>
                    </div>

                    <!-- Total Orders Section -->
                    <div class="col-md-6">
                        <div class="card">
                            <h3><i class="fas fa-shopping-bag me-2"></i>Total Orders: 
                            <% 
                                int totalOrders = 0;
                                
                                try {
                                    // Step 1: Establish database connection again
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
                                    
                                    // Step 2: Create SQL query for total orders
                                    String queryOrders = "SELECT COUNT(*) AS total_orders FROM orders";
                                    stmt = conn.prepareStatement(queryOrders);
                                    
                                    // Step 3: Execute query
                                    rs = stmt.executeQuery();
                                    
                                    // Step 4: Process result for orders
                                    if (rs.next()) {
                                        totalOrders = rs.getInt("total_orders");
                                    }
                            %>
                            <%= totalOrders %>  <!-- Display the total number of orders -->
                            <% 
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) rs.close();
                                        if (stmt != null) stmt.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            %>
                            </h3>
                        </div>
                    </div>
                </div>

                <!-- Order Status Section -->
                <div class="row">
                    <% 
                        // Query to count orders by each status
                        String queryOrderStatus = "SELECT orderStatus, COUNT(*) AS status_count FROM orders GROUP BY orderStatus";
                        stmt = conn.prepareStatement(queryOrderStatus);
                        
                        try {
                            // Execute query to get the order status counts
                            rs = stmt.executeQuery();
                            while (rs.next()) {
                                String orderStatus = rs.getString("orderStatus");
                                int statusCount = rs.getInt("status_count");
                    %>
                    <div class="col-md-6" >
                        <div class="card">
                            <h3><i class="fas fa-box me-2"></i><%= orderStatus %>: <%= statusCount %></h3>
                        </div>
                    </div>
                    <% 
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
