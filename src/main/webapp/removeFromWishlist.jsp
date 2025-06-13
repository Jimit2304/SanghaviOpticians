<%@ page import="java.sql.*" %>
<%
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int productID = Integer.parseInt(request.getParameter("productID"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        PreparedStatement ps = conn.prepareStatement("DELETE FROM wishlist WHERE userID = ? AND productID = ?");
        ps.setInt(1, userID);
        ps.setInt(2, productID);

        int rowsAffected = ps.executeUpdate();
        ps.close();
        conn.close();

        if (rowsAffected > 0) {
            response.sendRedirect("wishlist.jsp");
        } else {
            out.println("<script>alert('Item not found in wishlist!'); window.location.href='wishlist.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
