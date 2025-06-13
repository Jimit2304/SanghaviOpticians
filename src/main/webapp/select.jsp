
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure the user is logged in
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp"); // Redirect if user is not logged in
        return;
    }
   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Lens | Sanghavi Opticians</title>
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
                    background-color: rgba(255, 255, 255, 0.1);
                    color: var(--secondary-color) !important;
                    transform: translateY(-2px);
                }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
        }
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
            text-align: center;
        }
        .btn-custom:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        .prescription-form {
            display: none;
        }
    </style>
</head>
        <body class="d-flex flex-column min-vh-100">
           <!-- Navigation -->
         <jsp:include page="w.jsp" />
    


    <div class="container mt-5">
        <div class="card">
            <div class="card-body">
                <h2 class="text-center mb-4">Select Your Lenses</h2>
                <form action="savePrescription.jsp" method="post" class="needs-validation" novalidate>

                    <!-- Lens Selection -->
                    <div class="form-section">
                        <h4>Lens Type</h4>
                        <select name="lensID" id="lensType" class="form-select" required>
                            <option value="">Select Lens</option>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM lenses");

                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("lensID") %>"
                                data-type="<%= rs.getString("type") %>"
                                data-material="<%= rs.getString("material") %>"
                                data-coating="<%= rs.getString("coating") %>"
                                data-color="<%= rs.getString("coatingColor") %>"
                                data-price="<%= rs.getDouble("price") %>"
                                data-stock="<%= rs.getInt("stock") %>">
                                <%= rs.getString("name") %> - ₹<%= rs.getDouble("price") %>
                            </option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>

                    <!-- Lens Details (Auto-filled) -->
                    <div class="form-section">
                        <h4>Lens Details</h4>
                        <p><b>Type:</b> <span id="lensTypeDetail"></span></p>
                        <p><b>Material:</b> <span id="lensMaterial"></span></p>
                        <p><b>Coating:</b> <span id="lensCoating"></span></p>
                        <p><b>Coating Color:</b> <span id="lensColor"></span></p>
                        <p><b>Price:</b> ₹<span id="lensPrice"></span></p>
                        <p><b>Stock Available:</b> <span id="lensStock"></span></p>
                    </div>

<!-- Prescription Form -->
<div class="form-section prescription-form" id="prescriptionForm">
    <h4>Enter Your Prescription</h4>
    <div class="row">
        <!-- Right Eye (OD) -->
        <div class="col-md-6">
            <h5>Right Eye (OD)</h5>
            
            <label>Sphere (SPH)</label>
            <select class="form-control" name="right_sph">
                <option value="">Select SPH</option>
                <% for (double i = -10.00; i <= 10.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Cylinder (CYL)</label>
            <select class="form-control" name="right_cyl">
                <option value="">Select CYL</option>
                <% for (double i = -6.00; i <= 6.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Axis</label>
            <select class="form-control" name="right_axis">
                <option value="">Select Axis</option>
                <% for (int i = 0; i <= 180; i += 1) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Addition</label>
            <select class="form-control" name="right_add">
                <option value="">Select ADD</option>
                <% for (double i = 0.75; i <= 3.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>
        </div>

        <!-- Left Eye (OS) -->
        <div class="col-md-6">
            <h5>Left Eye (OS)</h5>
            
            <label>Sphere (SPH)</label>
            <select class="form-control" name="left_sph">
                <option value="">Select SPH</option>
                <% for (double i = -10.00; i <= 10.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Cylinder (CYL)</label>
            <select class="form-control" name="left_cyl">
                <option value="">Select CYL</option>
                <% for (double i = -6.00; i <= 6.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Axis</label>
            <select class="form-control" name="left_axis">
                <option value="">Select Axis</option>
                <% for (int i = 0; i <= 180; i += 1) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <label>Addition</label>
            <select class="form-control" name="left_add">
                <option value="">Select ADD</option>
                <% for (double i = 0.75; i <= 3.00; i += 0.25) { %>
                    <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>
        </div>
    </div>
</div>

                    <button type="submit" class="btn btn-custom">Save & Continue</button>
                </form>

            </div>
        </div>
    </div>
<jsp:include page="footer.jsp" />

    <script>
    document.getElementById('lensType').addEventListener('change', function () {
        var selectedLens = this.options[this.selectedIndex];

        document.getElementById('lensTypeDetail').innerText = selectedLens.getAttribute('data-type');
        document.getElementById('lensMaterial').innerText = selectedLens.getAttribute('data-material');
        document.getElementById('lensCoating').innerText = selectedLens.getAttribute('data-coating');
        document.getElementById('lensColor').innerText = selectedLens.getAttribute('data-color');
        document.getElementById('lensPrice').innerText = selectedLens.getAttribute('data-price');
        document.getElementById('lensStock').innerText = selectedLens.getAttribute('data-stock');

        var prescriptionForm = document.getElementById('prescriptionForm');
        var lensType = selectedLens.getAttribute('data-type');

        // Hide prescription form if the selected lens type is "Single Vision"
        if (lensType === "Single Vision") {
            prescriptionForm.style.display = "none";
        } else {
            prescriptionForm.style.display = "block";
        }
    });
</script>


</body>
</html>