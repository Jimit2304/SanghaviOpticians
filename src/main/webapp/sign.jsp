<%@ page import="java.sql.*, java.security.MessageDigest, java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get form data
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phoneNumber = request.getParameter("phoneNumber");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String address = request.getParameter("address");
    String role = request.getParameter("role");

    // Check if any field is empty
    if (firstName == null || lastName == null || email == null || password == null || 
        phoneNumber == null || dateOfBirth == null || address == null || role == null ||
        firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty() || 
        phoneNumber.isEmpty() || dateOfBirth.isEmpty() || address.isEmpty() || role.isEmpty()) {
        
        out.println("<p class='text-danger text-center'>All fields are required!</p>");
        return;
    }

    // Hash the password for security
    String hashedPassword = "";
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        hashedPassword = Base64.getEncoder().encodeToString(hash);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='text-danger text-center'>Error hashing password</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Database connection
        String url = "jdbc:mysql://localhost:3306/ma?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String dbPassword = "Jimit@123";

        conn = DriverManager.getConnection(url, user, dbPassword);

        // Check if email already exists
        String checkEmailSQL = "SELECT * FROM users WHERE email = ?";
        ps = conn.prepareStatement(checkEmailSQL);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            out.println("<p class='text-danger text-center'>Email already exists. Try another!</p>");
        } else {
            // Insert new user
            String sql = "INSERT INTO users (firstName, lastName, email, password, phoneNumber, dateOfBirth, address, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, hashedPassword);
            ps.setString(5, phoneNumber);
            ps.setString(6, dateOfBirth);
            ps.setString(7, address);
            ps.setString(8, role);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("index.jsp?signup=success"); // Redirect to login page
            } else {
                out.println("<p class='text-danger text-center'>Signup failed. Try again!</p>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='text-danger text-center'>Database error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
