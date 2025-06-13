<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Lens | Sanghavi Opticians</title>
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
                padding: 1rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
            }

            .navbar-brand {
                color: white !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-decoration: none;
                font-size: 1.5rem;
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

            .sidebar {
                width: 250px;
                background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
                color: white;
                padding: 20px;
                padding-top: 100px;
                position: fixed;
                height: 100%;
                top: 0;
                left: 0;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                padding: 12px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 16px;
                transition: 0.3s;
            }

            .sidebar ul li i {
                font-size: 18px;
            }

            .sidebar ul li:hover {
                background: rgba(255, 255, 255, 0.2);
                border-radius: 5px;
            }

            .content {
                margin-left: 270px;
                padding: 100px 20px 20px;
            }

            .container-box {
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 900px;
                margin: auto;
            }

            h2 {
                color: var(--primary-color);
                font-weight: 600;
                text-align: center;
                margin-bottom: 25px;
                position: relative;
            }

            h2::after {
                content: "";
                width: 80px;
                height: 4px;
                background: var(--secondary-color);
                display: block;
                margin: 5px auto 0;
                border-radius: 4px;
            }

            .form-label {
                font-weight: 500;
                color: var(--text-color);
            }

            .form-control {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--secondary-color);
                box-shadow: 0 0 5px rgba(33, 150, 243, 0.3);
            }

            .btn-custom {
                background: linear-gradient(to right, var(--primary-color), var(--accent-color));
                color: white;
                padding: 12px;
                border: none;
                cursor: pointer;
                border-radius: 6px;
                width: 100%;
                font-weight: 500;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .btn-custom:hover {
                transform: translateY(-1px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>

    <body>
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

        <div class="inherit">
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

            <div class="content">
                <div class="container-box">
                    <h2 class="text-center mb-4">Add New Lens</h2>
                    <form action="AddLensServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Lens Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type</label>
                            <select name="type" class="form-control">
                                <option value="Single Power">Single Power</option>
                                <option value="Single Vision">Single Vision</option>
                                <option value="Bifocal">Bifocal</option>
                                <option value="Progressive">Progressive</option>
                                <option value="Sun Glass">Sun Glass</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Material</label>
                            <select name="material" class="form-control">
                                <option value="Plastic">Plastic</option>
                                <option value="Polycarbonate">Polycarbonate</option>
                                <option value="High Index">High Index</option>
                                <option value="Glass">Glass</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Coating</label>
                            <select name="coating" class="form-control">
                                <option value="Anti-Glare">Anti-Glare</option>
                                <option value="UV Protection">UV Protection</option>
                                <option value="Blue Light Filter">Blue Light Filter</option>
                                <option value="None">None</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Coating</label>
                            <select name="coatingColor" class="form-select" required>
                            <option value="">Select Coating Color</option>
                            <option value="blue">Blue (Reduces Digital Eye Strain)</option>
                            <option value="green">Green (Natural Look)</option>
                            <option value="grey">Grey (Reduces Glare)</option>
                            <option value="brown">Brown (Enhanced Contrast)</option>
                        </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" name="price" step="0.01" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" name="stock" class="form-control" required>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Add Lens
                            </button>
                            <a href="manageLens.jsp" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>