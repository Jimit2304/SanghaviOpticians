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

        PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM wishlist WHERE userID = ? AND productID = ?");
        checkStmt.setInt(1, userID);
        checkStmt.setInt(2, productID);
        ResultSet rs = checkStmt.executeQuery();

        if (!rs.next()) {
            PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO wishlist (userID, productID) VALUES (?, ?)");
            insertStmt.setInt(1, userID);
            insertStmt.setInt(2, productID);
            insertStmt.executeUpdate();
            insertStmt.close();
        }

        rs.close();
        checkStmt.close();
        conn.close();

        response.sendRedirect("wishlist.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
