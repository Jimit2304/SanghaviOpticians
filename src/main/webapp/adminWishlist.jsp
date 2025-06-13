<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist Management | Sanghavi Opticians</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
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
                     <li onclick="window.location.href='order.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order</li>
                        
            </ul>
        </div>

        <!-- Content -->
        <div class="content">
            <h2>Wishlist Management</h2>

            <!-- Wishlist Table -->
 <table>
            <thead>
                <tr>
                    <th>Wishlist ID</th>
                    <th>User Name</th>
                    <th>Product Image</th>
                    <th>Added At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                        String query = "SELECT w.wishlistID, u.firstName, u.lastName, p.images, w.addedAt " +
                                       "FROM wishlist w " +
                                       "JOIN users u ON w.userID = u.userID " +
                                       "JOIN products p ON w.productID = p.productID";

                        ps = conn.prepareStatement(query);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String productImage = rs.getString("images").split(",")[0]; // Taking the first image if multiple are stored as comma-separated
                %>
                <tr>
                    <td><%= rs.getInt("wishlistID") %></td>
                    <td><%= rs.getString("firstName") + " " + rs.getString("lastName") %></td>
                    <td><img src="<%= productImage %>" alt="Product Image" style="width: 100px; height: auto;"></td>
                    <td><%= rs.getTimestamp("addedAt") %></td>
                    <td>
                        <button class="btn-custom btn-delete" onclick="deleteWishlistItem(<%= rs.getInt("wishlistID") %>)">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
        </div>
    </div>

    <script>
        function deleteWishlistItem(id) {
            if (confirm("Are you sure you want to remove this item from the wishlist?")) {
                window.location.href = "deleteWishlist.jsp?wishlistID=" + id;
            }
        }
    </script>

</body>
</html>
