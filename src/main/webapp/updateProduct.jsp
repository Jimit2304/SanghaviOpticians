<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve form data
    int productID = Integer.parseInt(request.getParameter("productID"));
    String name = request.getParameter("name");
    double price = Double.parseDouble(request.getParameter("price"));
    double discountPrice = Double.parseDouble(request.getParameter("discountPrice"));
    int stock = Integer.parseInt(request.getParameter("stock"));

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish Connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Update query
        String sql = "UPDATE products SET name=?, price=?, discountPrice=?, stock=? WHERE productID=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setDouble(2, price);
        stmt.setDouble(3, discountPrice);
        stmt.setInt(4, stock);
        stmt.setInt(5, productID);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("manage.jsp?success=Product Updated Successfully");
        } else {
            response.sendRedirect("manage.jsp?error=Failed to update product");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage.jsp?error=Error: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
