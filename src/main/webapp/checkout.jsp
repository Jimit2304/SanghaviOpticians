<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("sign.html");
        return;
    }

    double totalAmount = 0.0;
    if (request.getParameter("totalAmount") != null) {
        totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
    }
%>
<%
    // Check if user is logged in

   
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
    <title>Checkout | Sanghavi Opticians</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <!-- Google Fonts -->
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

        .checkout-container {
            max-width: 600px;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 3rem auto;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 10px;
        }

        .form-check-label {
            font-weight: 500;
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
        
        .payment-methods label {
            cursor: pointer;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            width: 100%;
            display: block;
            text-align: center;
            transition: 0.3s;
        }

        .payment-methods input:checked + label {
            border-color: var(--primary-color);
            background: var(--primary-color);
            color: white;
        }

    </style>
</head>

<body class="d-flex flex-column min-vh-100">
       <!-- Navigation -->
         <jsp:include page="w.jsp" />   

            <div class="container checkout-container">
        <h2 class="text-center mb-4">Checkout</h2>

        <form action="process" method="post">
            <!-- Shipping Details -->
            <h4 class="mb-3">Shipping Details</h4>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" class="form-control" value="<%= firstName +" " + lastName %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="<%= email%>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="tel" name="phone" class="form-control" value="<%=phoneNumber %>" required pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
                <div class="invalid-feedback">
                    Please provide a valid phone number.
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <textarea name="address" class="form-control" rows="3"  required><%=address %></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">City</label>
                <input type="text" name="city" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Pincode</label>
                <input type="text" name="pincode" class="form-control" required>
            </div>

            <!-- Payment Method -->
           
           <div class="mb-3" style="display: none;">
                <input type="radio" name="paymentMethod" value="COD" id="cod" checked>
                <label for="cod">Cash on Delivery</label>
            </div>
            <input type="hidden" name="paymentMethod" value="COD">

           
            <!-- Submit Button -->
            <button type="submit" class="btn btn-custom">Place Order</button>
            
            <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
            
        </form>
   
    </div>
    <br>
     <footer class="mt-auto">
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
</body>
</html>     