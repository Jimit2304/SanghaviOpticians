  <%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sanghavi Opticians | Premium Eyewear</title>
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

                .navbar {
                    background: linear-gradient(135deg, var(--primary-color), var(--accent-color)) !important;
                    padding: 1rem 0;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
                    background-color: white;/*rgba(255, 255, 255, 0.1);*/
                    color: var(--primary-color) !important ;/*var(--secondary-color) !important;*/
                    transform: translateY(-2px);
                }

                .btn-custom {
                    background-color: var(--accent-color);
                    color: white;
                    border: none;
                    padding: 0.8rem 2rem;
                    border-radius: 25px;
                    font-weight: 500;
                    letter-spacing: 0.5px;
                    transition: all 0.3s ease;
                }

                .btn-custom:hover {
                    background-color: #f4511e;
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(244, 81, 30, 0.3);
                }

                .product-card {
                    border: none;
                    border-radius: 15px;
                    overflow: hidden;
                    transition: all 0.3s ease;
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                }

                .product-card:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                }

                .card-img-top {
                    height: auto;
                    object-fit: cover;
                    height: 150px;
    width: 100%;
    object-fit: contain; /* or use 'cover' for filling the area */
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 10px;
                }

                .card-body {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    padding: 1.5rem;
                    flex-grow: 1;
                }

                .card-title {
                    font-size: 1.25rem;
                    font-weight: 600;
                    margin-bottom: 0.5rem;
                    text-align: center;
                }

                .text-muted {
                    font-size: 0.9rem;
                    margin-bottom: 1rem;
                }

                .price {
                    color: var(--price-color);
                    font-size: 1.2rem;
                    margin-bottom: 1.5rem;
                    text-decoration: line-through;
                }

                .discountprice {
                    color: var(--discount-color);
                    font-size: 1.3rem;
                    font-weight: bold;
                    margin-bottom: 1.5rem;
                }

                .featured-section {
                    background-color: white;
                    padding: 5rem 0;
                }

                .featured-section h2 {
                    color: var(--primary-color);
                    font-weight: 700;
                    margin-bottom: 3rem;
                    position: relative;
                }

                .featured-section h2:after {
                    content: '';
                    position: absolute;
                    bottom: -10px;
                    left: 50%;
                    transform: translateX(-50%);
                    width: 50px;
                    height: 3px;
                    background-color: var(--secondary-color);
                }

                /* New Banner Styles */
                .banner-section {
                    padding: 3rem 0;
                    background: linear-gradient(45deg, #f3f4f6, #e5e7eb);
                }

                .banner-card {
                    background: white;
                    border-radius: 20px;
                    padding: 2rem;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    margin-bottom: 2rem;
                }

                .banner-image {
                    width: 100%;
                    height: 300px;
                    object-fit: cover;
                    border-radius: 15px;
                    margin-bottom: 1.5rem;
                }

                /* Filter Styles */
                .filters {
                    background: white;
                    padding: 1.5rem;
                    border-radius: 10px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .filters h4 {
                    color: var(--primary-color);
                    font-weight: 600;
                    border-bottom: 2px solid var(--accent-color);
                    padding-bottom: 0.5rem;
                    margin-top: 1.5rem;
                }

                .form-check-input:checked {
                    background-color: var(--accent-color);
                    border-color: var(--accent-color);
                }

                .filter-btn {
                    background: var(--accent-color);
                    color: white;
                    border: none;
                    padding: 0.8rem 2rem;
                    border-radius: 25px;
                    width: 100%;
                    margin-top: 1.5rem;
                    transition: all 0.3s ease;
                }

                .filter-btn:hover {
                    background: var(--primary-color);
                    transform: translateY(-2px);
                }

                @media (max-width: 768px) {
                    .navbar-brand {
                        font-size: 1.2rem;
                    }

                    .product-card {
                        margin-bottom: 1.5rem;
                    }

                    .card-title {
                        font-size: 1.1rem;
                    }

                    .filters {
                        padding: 1rem;
                        display: none;
                        /* Hide filters on mobile */
                    }

                    .filter-btn {
                        padding: 0.6rem 1.5rem;
                    }

                    .filter-toggle {
                        display: block;
                        cursor: pointer;
                        margin-bottom: 1rem;
                    }
                }
            </style>
        </head>

        <body class="d-flex flex-column min-vh-100">
                <!-- Navigation -->
        <jsp:include page="w.jsp" />
    

            <div class="container-fluid my-5">
                <div class="row">
                    <div class="col-lg-3 col-md-4 col-sm-12">
                        <div class="filter-toggle" onclick="toggleFilters()"></div>
                        <form id="filterForm" method="get" action="product.jsp">
                            <div class="filters mb-4" id="filterSection">
                                <h4 class="mb-3">Category</h4>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="category" value="Eye Frames"
                                        id="eyeFrames">
                                    <label class="form-check-label" for="eyeFrames">Eye Frames</label>
                                </div>

                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="category" value="Sun Glass"
                                        id="Sun Glass">
                                    <label class="form-check-label" for="contactLenses">Sun Glasses</label>
                                </div>

                                <h4 class="mb-3">Style</h4>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="style" value="Square"
                                        id="square">
                                    <label class="form-check-label" for="square">square</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="style" value="Round"
                                        id="round">
                                    <label class="form-check-label" for="round">Round</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="style" value="Aviator"
                                        id="aviator">
                                    <label class="form-check-label" for="aviator">Aviator</label>
                                </div>
                                 <div class="form-check mb-2">
                                   <input class="form-check-input" type="checkbox" name="style" value="cateye" id="cateye">
<label class="form-check-label" for="cateye">Cat Eye</label>

                                </div> 

                                <h4 class="mb-3">Price Range</h4>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="priceRange" value="0-2500"
                                        id="price1">
                                    <label class="form-check-label" for="price1">₹0 - ₹2,500</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="priceRange" value="2501-5000"
                                        id="price2">
                                    <label class="form-check-label" for="price2">₹2,501 - ₹5,000</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="priceRange" value="5001-10000"
                                        id="price3">
                                    <label class="form-check-label" for="price3">₹5,001 - ₹10,000</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="priceRange" value="10001-above"
                                        id="price4">
                                    <label class="form-check-label" for="price4">Above ₹10,000</label>
                                </div>

                                <h4 class="mb-3">Gender</h4>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="gender" value="Men" id="men">
                                    <label class="form-check-label" for="men">Men</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="gender" value="Women"
                                        id="women">
                                    <label class="form-check-label" for="women">Women</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="gender" value="Unisex"
                                        id="unisex">
                                    <label class="form-check-label" for="unisex">Unisex</label>
                                </div>
                                <button type="submit" class="filter-btn">Apply Filters</button>
                                <button type="resetPage" class="filter-btn mt-2"
                                    style="background: var(--secondary-color);">Reset Filters</button>
                                
                            </div>

                        </form>
                    </div>
                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <div class="row g-4">
                            <% Connection conn=null; PreparedStatement ps=null; ResultSet rs=null; try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123"
                                ); StringBuilder sql=new StringBuilder("SELECT * FROM products WHERE stock> 0");

                                // Get filter parameters
                                String[] categories = request.getParameterValues("category");
                                String[] styles = request.getParameterValues("style");
                                String priceRange = request.getParameter("priceRange");
                                String[] genders = request.getParameterValues("gender");

                                // Build WHERE clause based on filters
                                if (categories != null && categories.length > 0) {
                                sql.append(" AND category IN (");
                                for (int i = 0; i < categories.length; i++) { if (i> 0) sql.append(",");
                                    sql.append("?");
                                    }
                                    sql.append(")");
                                    }

                                    if (styles != null && styles.length > 0) {
                                    sql.append(" AND style IN (");
                                    for (int i = 0; i < styles.length; i++) { if (i> 0) sql.append(",");
                                        sql.append("?");
                                        }
                                        sql.append(")");
                                        }

                                        if (priceRange != null) {
                                        String[] range = priceRange.split("-");
                                        if (range[1].equals("above")) {
                                        sql.append(" AND finalPrice > ?");
                                        } else {
                                        sql.append(" AND finalPrice BETWEEN ? AND ?");
                                        }
                                        }

                                        if (genders != null && genders.length > 0) {
                                        sql.append(" AND gender IN (");
                                        for (int i = 0; i < genders.length; i++) { if (i> 0) sql.append(",");
                                            sql.append("?");
                                            }
                                            sql.append(")");
                                            }

                                            ps = conn.prepareStatement(sql.toString());

                                            // Set parameters
                                            int paramIndex = 1;

                                            if (categories != null) {
                                            for (String category : categories) {
                                            ps.setString(paramIndex++, category);
                                            }
                                            }

                                            if (styles != null) {
                                            for (String style : styles) {
                                            ps.setString(paramIndex++, style);
                                            }
                                            }

                                            if (priceRange != null) {
                                            String[] range = priceRange.split("-");
                                            ps.setDouble(paramIndex++, Double.parseDouble(range[0]));
                                            if (!range[1].equals("above")) {
                                            ps.setDouble(paramIndex++, Double.parseDouble(range[1]));
                                            }
                                            }

                                            if (genders != null) {
                                            for (String gender : genders) {
                                            ps.setString(paramIndex++, gender);
                                            }
                                            }
                                           
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                            %>
                                            <div class="col-lg-3 col-md-6 col-sm-12">
                                                <div class="product-card shadow">
                                                    <img src="<%= rs.getString("images") %>" class="card-img-top" alt="
                                                    <%= rs.getString("name") %>">
                                                        <div class="card-body">
                                                            <h5 class="card-title">
                                                                <%= rs.getString("name") %>
                                                            </h5>
                                                            <p class="text-muted">
                                                                <%= rs.getString("category") %>
                                                            </p>
                                                            <p class="finalPrice">Special Price: ₹<%=
                                                                    rs.getDouble("finalPrice") %>
                                                            </p>
                                                            <p class="price">Price: ₹<%= rs.getDouble("price") %>
                                                            </p>
                                                            <a href="product-detail.jsp?productID=<%= rs.getInt("productID") %>" class="btn btn-custom w-100">View Detail</a>
                                                        </div>
                                                </div>
                                            </div>
                                            <% } } catch (Exception e) { e.printStackTrace(); } finally { if (rs !=null)
                                                try { rs.close(); } catch (Exception e) {} if (ps !=null) try {
                                                ps.close(); } catch (Exception e) {} if (conn !=null) try {
                                                conn.close(); } catch (Exception e) {} } %>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer -->
    
           
<jsp:include page="footer.jsp" />


            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
               /*  function toggleFilters() {
                    var filterSection = document.getElementById('filterSection');
                    filterSection.style.display = (filterSection.style.display === "none" || filterSection.style.display === "") ? "block" : "none";
                }

                function clearFilters() {
                    document.getElementById('filterForm').reset();
                } */
                <script>
                function toggleFilters() {
                    var filterSection = document.getElementById('filterSection');
                    filterSection.style.display = (filterSection.style.display === "none" || filterSection.style.display === "") ? "block" : "none";
                }

                function clearFilters() {
                    document.getElementById('filterForm').reset();
                }

                function resetPage() {
                    window.location.href = "product.jsp"; // change if the page name differs
                }
            </script>

            </script>
        </body>

        </html> 
        
        
        
     