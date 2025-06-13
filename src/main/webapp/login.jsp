<%@ page import="java.sql.*, java.security.MessageDigest, java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Processing...</title>

    <script>
        function showAlert(message, redirectUrl) {
            alert(message);
            window.location.href = redirectUrl;
        }
    </script>
</head>
<body>

<%
    // Retrieve form data
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Validate input
    if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
%>
    <script>
        showAlert("⚠️ Please enter your email and password!", "sign.html");
    </script>
<%
        return;
    }

    // Hash the password using SHA-256
    String hashedPassword = "";
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        hashedPassword = Base64.getEncoder().encodeToString(hash);
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        showAlert("⚠️ Error hashing password. Try again!", "index.jsp");
    </script>
<%
        return;
    }

    // Database connection
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/ma?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String dbPassword = "Jimit@123";
        conn = DriverManager.getConnection(url, user, dbPassword);

        // Fetch user details
        String sql = "SELECT userID, firstName, role, password FROM users WHERE email = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        rs = ps.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");
            String role = rs.getString("role").trim();
            int userID = rs.getInt("userID"); // Get userID

            // Check if password matches
            if (storedPassword.equals(hashedPassword)) {
                // Start session and store user details
                session.setAttribute("userID", userID);
                session.setAttribute("user", rs.getString("firstName"));
                session.setAttribute("role", role);

                // Redirect based on role
                if ("SuperAdmin".equalsIgnoreCase(role)) {
%>
    <script>
        showAlert("✅ Welcome, SuperAdmin!", "ad.jsp");
    </script>
<%
                } else if ("Manager".equalsIgnoreCase(role)) {
%>
    <script>
        showAlert("✅ Welcome, Manager!", "manager.jsp");
    </script>
<%
                } else if ("User".equalsIgnoreCase(role)) { // ✅ Allow regular users
%>
    <script>
        showAlert("✅ Welcome, User!", "dashboard.html");
    </script>
<%
                } else {
%>
    <script>
        showAlert("❌ Unknown role detected!", "index.jsp");
    </script>
<%
                }
            } else {
%>
    <script>
        showAlert("❌ Invalid email or password!", "sign.html");
    </script>
<%
            }
        } else {
%>
    <script>
        showAlert("❌ Invalid email or password!", "sign.html");
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        showAlert("⚠️ Database connection error!", "sign.html");
    </script>
<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

</body>
</html>
