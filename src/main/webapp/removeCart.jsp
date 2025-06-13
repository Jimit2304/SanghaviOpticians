<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int cartID = Integer.parseInt(request.getParameter("cartID"));
    int userID = (session.getAttribute("userID") != null) ? (Integer) session.getAttribute("userID") : 0;

    if (userID > 0) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            String query = "DELETE FROM cart WHERE cartID = ? AND userID = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartID);
            ps.setInt(2, userID);
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
