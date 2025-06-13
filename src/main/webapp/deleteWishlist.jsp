<%@ page import="java.sql.*" %>
<%
    int wishlistID = Integer.parseInt(request.getParameter("wishlistID"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        PreparedStatement ps = conn.prepareStatement("DELETE FROM wishlist WHERE wishlistID = ?");
        ps.setInt(1, wishlistID);
        ps.executeUpdate();

        ps.close();
        conn.close();
        response.sendRedirect("adminWishlist.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
