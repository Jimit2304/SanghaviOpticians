<%@ page import="java.sql.*" %>
<%
    int cartID = Integer.parseInt(request.getParameter("cartID"));
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        String query = "DELETE FROM cart WHERE cartID = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, cartID);
        ps.executeUpdate();

        response.sendRedirect("cartAdmin.jsp"); // Redirect back to cart page
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
