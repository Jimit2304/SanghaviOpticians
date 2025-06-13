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
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

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

                table th {
                    background: linear-gradient(to right, var(--primary-color), var(--accent-color));
                    color: white;
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
                     </li><li onclick="window.location.href='order.jsp'"><i class="fas fa-shopping-cart me-2"></i>Order</li>
                        </ul>
                    
                </div>

                <!-- Content -->
                <div class="content">
                    <h2>Lens Management</h2>
                    <a href="addLens.jsp" class="btn btn-primary mb-3">Add New Lens</a>
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Material</th>
                                <th>Coating</th>
                                <th>Coating Color</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% Connection conn=null; Statement stmt=null; ResultSet rs=null; try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123"
                                ); stmt=conn.createStatement(); rs=stmt.executeQuery("SELECT * FROM lenses"); while
                                (rs.next()) { %>
                                <tr>
                                    <td>
                                        <%= rs.getInt("lensID") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("name") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("type") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("material") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("coating") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("coatingColor") %>
                                    </td>
                                    <td>₹<%= rs.getDouble("price") %>
                                    </td>
                                    <td>
                                        <%= rs.getInt("stock") %>
                                    </td>
                                    <td>
                                        <a href="editLens.jsp?id=<%= rs.getInt("lensID") %>" class="btn btn-custom"><i class="fas fa-edit"></i></a>
                                        <a href="DeleteLensServlet?id=<%= rs.getInt("lensID") %>" class="btn btn-delete" onclick="return confirm('Are you sure?');"><i  class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                                <% } } catch (Exception e) { out.println("Error: " + e.getMessage()); 
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
</body>

</html>