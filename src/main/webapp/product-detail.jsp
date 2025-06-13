<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail | Sanghavi Opticians</title>
    
    <!-- Bootstrap CSS -->
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
 .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            color: white !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-size: 1.4rem;
        }
        
        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 1.2rem;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }
        
       
        .product-detail {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 3rem auto;
            flex: 1;
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
    </style>
</head>

<body>
    <!-- Navbar -->
        <!-- Navigation -->
      <jsp:include page="w.jsp" />
    
    

    <!-- Product Details -->
    <div class="container product-detail">
        <div class="row">
            <% 
                String productID = request.getParameter("productID");
                int userID = 1; // Replace this with session-based user ID

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE productID=?");
                    ps.setString(1, productID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) { 
            %>
            <div class="col-md-6">
                <img src="<%= rs.getString("images") %>" class="card-img-top" alt="<%= rs.getString("name") %>" width="100%">
            </div>
            <div class="col-md-6">
                <h2 class="mb-2"><%= rs.getString("name") %></h2>
                <p class="text-muted mb-2"><strong>Category:</strong> <%= rs.getString("category") %></p>
                                <p class="text-muted mb-2"><strong>Style:</strong> <%= rs.getString("style") %></p>
                <p class="h3 mb-2">Special Price: ₹<%= rs.getDouble("finalprice") %></p>
                <p class="text-muted mb-2"><strong>Original Price:</strong> ₹<%= rs.getDouble("price") %></p>
                
                <!-- Add to Cart Form -->
                <form action="addToCart.jsp" method="POST" class="d-inline">
                    <input type="hidden" name="productID" value="<%= rs.getInt("productID") %>">
                    <div class="mb-2">
                        <label for="quantity" class="form-label">Quantity:</label>
                        <input type="number" name="quantity" class="form-control w-25 d-inline" id="quantity" min="1" value="1">
                    </div>
                    <button type="submit" class="btn-custom">Add to Cart</button>
                </form>
                
                <!-- Add to Wishlist -->
                <form action="addToWishlist.jsp" method="POST" class="d-inline">
                    <input type="hidden" name="productID" value="<%= rs.getInt("productID") %>">
                    <button type="submit" class="btn-custom">Add to Wishlist</button>
                </form>
            </div>
            <% 
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch(Exception e) { 
                    e.printStackTrace(); 
                } 
            %>
        </div>
    </div>

<jsp:include page="footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
