<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get the product ID from the URL parameter
    String productId = request.getParameter("id");

    if (productId != null && !productId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            // Prepare SQL delete statement
            String sql = "DELETE FROM products WHERE productID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));

            // Execute delete
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("manage.jsp?message=Product Deleted Successfully");
            } else {
                response.sendRedirect("manage.jsp?error=Product Not Found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage.jsp?error=Database Error");
        } finally {
            // Close resources
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("manage.jsp?error=Invalid Product ID");
    }
%>
