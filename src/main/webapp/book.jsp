<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Bookings | Sanghavi Opticians</title>
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
                            <li class="nav-item">
                                <a class="nav-link" href="ad.jsp">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout.jsp">Logout</a>
                            </li>
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

                <!-- Content -->
                <div class="content">
                    <h2>Manage Bookings</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Preferred Date</th>
                                <th>Preferred Time</th>
                                <th>Concerns</th>
                                <th>Created At</th>

                            </tr>
                        </thead>
                        <tbody>
                            <% Connection conn=null; Statement stmt=null; ResultSet rs=null; try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123"
                                ); stmt=conn.createStatement(); rs=stmt.executeQuery("SELECT * FROM book"); while
                                (rs.next()) { %>
                                <tr>
                                    <td>
                                        <%= rs.getInt("appointment_id") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("full_name") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("phone_number") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("email_address") %>
                                    </td>
                                    <td>
                                        <%= rs.getDate("preferred_date") %>
                                    </td>
                                    <td>
                                        <%= rs.getTime("preferred_time") %>
                                    </td>
                                    <td>
                                        <%= rs.getString("specific_concerns") %>
                                    </td>
                                    <td>
                                        <%= rs.getTimestamp("created_at") %>
                                    </td>

                                </tr>
                                <% } } catch (Exception e) { %>
                                    <tr>
                                        <td colspan="8">Error fetching bookings: <%= e.getMessage() %>
                                        </td>
                                    </tr>
                                    <% e.printStackTrace(); } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <script>
                function deleteBooking(id) {
                    if (confirm("Are you sure you want to delete this booking?")) {
                        window.location.href = "deleteBooking.jsp?id=" + id;
                    }
                }
            </script>

        </body>

        </html>