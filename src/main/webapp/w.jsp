<%@ page session="true" %>
<!-- Navbar with CSS -->
<head>

</head>
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
        background-color: white;
        color: var(--primary-color) !important;
        transform: translateY(-2px);
    }
</style>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Sanghavi Opticians</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home me-2"></i>Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="product.jsp"><i class="fas fa-glasses me-2"></i>Shop</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart me-2"></i>Cart</a>
                </li>
                <% if (session.getAttribute("userID") != null) { %>
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.html"><i class="fas fa-user-circle me-2"></i>Account</a>
                </li>
               
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
