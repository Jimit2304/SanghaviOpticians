<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int userID = (session.getAttribute("userID") != null) ? (Integer) session.getAttribute("userID") : 0;
    int productID = Integer.parseInt(request.getParameter("productID"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    if (userID > 0) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            String query = "INSERT INTO cart (userID, productID, quantity) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE quantity = quantity + ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity);
            ps.executeUpdate();

            response.sendRedirect("cart.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
