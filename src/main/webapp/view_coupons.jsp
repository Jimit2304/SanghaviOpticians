<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Coupons | Sanghavi Opticians</title>

            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

            <!-- Custom CSS -->
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
                }

                .sidebar {
                    width: 250px;
                    background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
                    color: white;
                    padding: 20px;
                    min-height: 100vh;
                }

                .navbar-links {
                    display: flex;
                    gap: 1.5rem;
                }

                .navbar a {
                    color: white !important;
                    font-weight: 500;
                    text-decoration: none;
                    transition: all 0.3s ease;
                    padding: 0.5rem 1rem;
                    border-radius: 5px;
                }

                .navbar a:hover {
                    background: rgba(255, 255, 255, 0.1);
                    color: var(--secondary-color) !important;
                    transform: translateY(-2px);
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

                .table {
                    width: 100%;
                    background: white;
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                }

                .table thead th {
                    background: linear-gradient(to right, var(--primary-color), var(--accent-color));
                    color: white;
                    border: 1px solid var(--secondary-color); /* Added grid effect */
                }

                .table tbody td {
                    border: 1px solid #ddd; /* Added grid effect */
                }

                .btn-danger {
                    background: var(--accent-color);
                    color: white;
                    padding: 8px 12px;
                    border-radius: 5px;
                    transition: 0.3s;
                }

                .btn-danger:hover {
                    background-color: #c0392b;
                }

                h2 {
                    color: var(--primary-color);
                    margin-bottom: 20px;
                    font-weight: bold;
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
                     <li onclick="window.location.href='adminWishlist.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order
                     </li>   </ul>
                        </div>

                <!-- Content -->
                <div class="content">
                    <h2><i class="fas fa-tag me-2"></i>Manage Coupons</h2>
                    <form action="addCoupon.jsp" method="post" class="row g-3">
                        <!-- Form fields -->
                    </form>

                    <!-- Coupons Table -->
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Coupon ID</th>
                                <th>Coupon Code</th>
                                <th>Discount</th>
                                <th>Min Purchase</th>
                                <th>Start Date</th>
                                <th>Expiry Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% Connection con=null; Statement stmt=null; ResultSet rs=null; try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123"
                                ); stmt=con.createStatement(); rs=stmt.executeQuery("SELECT * FROM coupons"); while
                                (rs.next()) { String couponId=rs.getString("couponID"); %>
                                <tr>
                                    <td>
                                        <%= rs.getInt("couponID") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("code") %>
                                    </td>
                                    <td>
                                        <%= "percentage" .equals(rs.getString("discountType")) ?
                                            rs.getDouble("discountValue") + "%" : "₹" + rs.getDouble("discountValue") %>
                                    </td>
                                    <td>₹<%= rs.getDouble("minPurchase") %>
                                    </td>
                                    <td>
                                        <%= rs.getDate("startDate") %>
                                    </td>
                                    <td>
                                        <%= rs.getDate("expiryDate") %>
                                    </td>
                                    <td>
                                        <a href="deleteCoupon.jsp?id=<%= couponId %>" class="btn-custom btn-delete"
                                            onclick="return confirm('Are you sure you want to delete this coupon?');"><i
                                                class="fas fa-trash me-1"></i></a>
                                    </td>
                                </tr>
                                <% } } catch (SQLException | ClassNotFoundException e) { e.printStackTrace();
                                    out.println("<tr><td colspan='7'>Error retrieving data.</td></tr>");
                                    } finally {
                                    try {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (con != null) con.close();
                                    } catch (SQLException e) {
                                    e.printStackTrace();
                                    }
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