<%@ page import="java.sql.*" %>
<%
    String orderID = request.getParameter("orderID");
    String newStatus = request.getParameter("orderStatus");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        String sql = "UPDATE orders SET orderStatus = ? WHERE orderID = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, newStatus);
        ps.setInt(2, Integer.parseInt(orderID));
        ps.executeUpdate();

        response.sendRedirect("order.jsp");
    } catch(Exception e) {
        out.println("Error updating status: " + e.getMessage());
    } finally {
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
%>
