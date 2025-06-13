<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
            background: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        table th {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
        }

         .product-image {
            max-width:10px;
            height: 60px;
            border-radius: 5px;
             object-fit: cover
        }

        .btn-custom {
            background: var(--accent-color);
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            transition: 0.3s;
        }

        .btn-delete {
            background: red;
        }
    </style>
</head>

<body>

    <!-- Navbar -->
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



    

        <!-- Content -->
        <div class="content">
            <h2>Manage Products</h2>
            <table class="table">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Discount Price</th>
                        <th>Stock</th>
                        <th>Gender</th>
                        <th>Style</th>
                        <th>Category</th>
                        <th>Tags</th>
                        <th>FInal PRice</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                            String sql = "SELECT * FROM products ORDER BY productID DESC ";
                            stmt = conn.prepareStatement(sql);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("productID") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td>₹<%= rs.getDouble("price") %></td>
                        <td>₹<%= rs.getDouble("discountPrice") %></td>
                        <td><%= rs.getInt("stock") %></td>
                        <td><%= rs.getString("gender") %></td>
                                <td><%= rs.getString("style") %></td>
                                <td><%= rs.getString("category") %></td>
                                <td><%= rs.getString("tags") %></td>
                                <td><%= rs.getString("finalPrice") %></td>
                        <td><img src="<%= rs.getString("images") %>" width=50 height=30 alt="<%= rs.getString("name") %>"></td>
                        <td>
                            <button class="btn btn-custom" 
                                onclick="openEditModal('<%= rs.getInt("productID") %>', 
                                                       '<%= rs.getString("name").replaceAll("'", "\\'") %>', 
                                                       '<%= rs.getDouble("price") %>',
                                                       '<%= rs.getDouble("discountPrice") %>',
                                                       '<%= rs.getInt("stock") %>')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <a href="deletProduct.jsp?id=<%= rs.getInt("productID") %>" class="btn btn-delete"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) { 
                            out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                            e.printStackTrace(new java.io.PrintWriter(out));
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="updateProduct.jsp" method="post">
                        <input type="text" id="editProductId" name="productID">
                        <input type="text" id="editProductName" name="name" class="form-control my-2" placeholder="Product Name">
                        <input type="number" id="editProductPrice" name="price" class="form-control my-2" placeholder="Price">
                        <input type="number" id="editProductDiscountPrice" name="discountPrice" class="form-control my-2" placeholder="Discount Price">
                        <input type="number" id="editProductStock" name="stock" class="form-control my-2" placeholder="Stock">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    function openEditModal(productID, name, price, discountPrice, stock) {
        document.getElementById('editProductId').value = productID;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductDiscountPrice').value = discountPrice;
        document.getElementById('editProductStock').value = stock;

        var modal = new bootstrap.Modal(document.getElementById('editModal'));
        modal.show();
    }
    </script>

</body>
</html>