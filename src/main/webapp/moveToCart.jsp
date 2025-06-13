<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    Integer userID = (Integer) session.getAttribute("userID");
    String productID = request.getParameter("productID");

    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement psCheck = null;
    PreparedStatement psInsert = null;
    PreparedStatement psDelete = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Check if the product is already in the cart
        String checkCart = "SELECT * FROM cart_items WHERE userID=? AND productID=?";
        psCheck = conn.prepareStatement(checkCart);
        psCheck.setInt(1, userID);
        psCheck.setString(2, productID);
        ResultSet rs = psCheck.executeQuery();

        if (!rs.next()) {
            // If not in cart, insert into cart
            String insertCart = "INSERT INTO cart_items (userID, productID, quantity) VALUES (?, ?, 1)";
            psInsert = conn.prepareStatement(insertCart);
            psInsert.setInt(1, userID);
            psInsert.setString(2, productID);
            psInsert.executeUpdate();
        }

        // Remove from wishlist
        String deleteWishlist = "DELETE FROM wishlist WHERE userID=? AND productID=?";
        psDelete = conn.prepareStatement(deleteWishlist);
        psDelete.setInt(1, userID);
        psDelete.setString(2, productID);
        psDelete.executeUpdate();

        response.sendRedirect("cart.jsp"); // Redirect to cart page

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        if (psCheck != null) psCheck.close();
        if (psInsert != null) psInsert.close();
        if (psDelete != null) psDelete.close();
        if (conn != null) conn.close();
    }
%>
