<%@ page import="java.sql.*" %>
<%
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String orderIDStr = request.getParameter("orderID");
    if (orderIDStr == null || orderIDStr.isEmpty()) {
        response.sendRedirect("orderHistory.jsp");
        return;
    }

    int orderID = Integer.parseInt(orderIDStr);
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Make sure the order belongs to the logged-in user and is pending
        String checkQuery = "SELECT orderStatus FROM orders WHERE orderID = ? AND userID = ?";
        ps = conn.prepareStatement(checkQuery);
        ps.setInt(1, orderID);
        ps.setInt(2, userID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String status = rs.getString("orderStatus");
            if ("Pending".equalsIgnoreCase(status)) {
                // Update the order status to Cancelled
                ps.close();
                String cancelQuery = "UPDATE orders SET orderStatus = 'Cancelled' WHERE orderID = ?";
                ps = conn.prepareStatement(cancelQuery);
                ps.setInt(1, orderID);
                ps.executeUpdate();
            }
        }

        rs.close();
        ps.close();
        conn.close();

        response.sendRedirect("orderHistory.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("orderHistory.jsp");
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
