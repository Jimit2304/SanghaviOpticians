<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int userID = (session.getAttribute("userID") != null) ? (int) session.getAttribute("userID") : -1;
    if (userID == -1) {
        response.sendRedirect("login.jsp");
        return;
    }

    int cartID = Integer.parseInt(request.getParameter("cartID"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        String updateQuery = "UPDATE cart SET quantity = ? WHERE cartID = ? AND userID = ?";
        ps = conn.prepareStatement(updateQuery);
        ps.setInt(1, quantity);
        ps.setInt(2, cartID);
        ps.setInt(3, userID);
        ps.executeUpdate();

        response.sendRedirect("cart.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
