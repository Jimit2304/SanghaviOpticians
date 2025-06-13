<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <title>Wishlist | Sanghavi Opticians</title>
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


        .btn-custom {
            background-color: var(--primary-color);
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

<body class="d-flex flex-column min-vh-100">

      <jsp:include page="w.jsp" />

    <div class="container my-5">
        <h2 class="text-center mb-4">Your Wishlist</h2>
        <div class="row g-4">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

                    PreparedStatement ps = conn.prepareStatement(
                        "SELECT p.productID, p.name, p.finalPrice, p.images FROM wishlist w " +
                        "JOIN products p ON w.productID = p.productID WHERE w.userID = ?"
                    );
                    ps.setInt(1, userID);
                    ResultSet rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) { %>
                        <div class="col-12 text-center">
                            <p>No items in your wishlist.</p>
                        </div>
                    <% } else { while (rs.next()) { %>
                        <div class="col-md-4">
                            <div class="card product-card h-100 shadow-sm">
                                <img src="<%= rs.getString("images") %>" class="card-img-top" alt="<%= rs.getString("name") %>">
                                <div class="card-body text-center">
                                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                                    <p class="price fw-bold">₹<%= String.format("%.2f", rs.getDouble("finalPrice")) %></p>

                                    <form action="removeFromWishlist.jsp" method="POST" class="d-inline">
                                        <input type="hidden" name="productID" value="<%= rs.getInt("productID") %>">
                                        <button type="submit" class="btn btn-danger btn-custom">Remove</button>
                                    </form>

                                    <form action="addToCart.jsp" method="POST" class="d-inline">
                                        <input type="hidden" name="productID" value="<%= rs.getInt("productID") %>">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-primary btn-custom">Add to Cart</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    <% } }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>


    <!-- Footer -->
   <jsp:include page="footer.jsp" />


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
