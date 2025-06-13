<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Check if user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("sign.html"); // Redirect to login if not logged in
        return;
    }

   
    String dbURL = "jdbc:mysql://localhost:3306/ma?useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Jimit@123";
    
    String firstName = "", lastName = "", email = "", phoneNumber = "", address = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch user details from database
        String sql = "SELECT firstName, lastName, email, phoneNumber, address FROM users WHERE userID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            firstName = rs.getString("firstName");
            lastName = rs.getString("lastName");
            email = rs.getString("email");
            phoneNumber = rs.getString("phoneNumber");
            address = rs.getString("address");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Account - Sanghavi Opticians</title>
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
        .account-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .btn-update {
            background-color: var(--accent-color);
            color: white;
        }
        .btn-update:hover {
            background-color: #2980b9;
            color: white;
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
 <jsp:include page="w.jsp" /> 
    <div class="account-container">
        <h2 class="mb-4">Manage Your Account</h2>

        <form action="updateAccount" method="POST">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="<%= firstName %>">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="<%= lastName %>">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= email %>" readonly>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>">
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <textarea class="form-control" id="address" name="address" rows="3"><%= address %></textarea>
            </div>

            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="newPassword">New Password (optional)</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-update">Update Account</button>
        </form>
    </div>

    <footer class="py-4" style="background: linear-gradient(135deg, var(--primary-color), var(--accent-color));">
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
</html>
