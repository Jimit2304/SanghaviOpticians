<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% String couponId=request.getParameter("id"); Connection con=null; PreparedStatement pstmt=null; try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123" ); String
            sql="DELETE FROM coupons WHERE couponID = ?" ; pstmt=con.prepareStatement(sql); pstmt.setString(1,
            couponId); int rowsAffected=pstmt.executeUpdate(); if(rowsAffected> 0) {
            response.sendRedirect("view_coupons.jsp");
            } else {
            out.println("Error deleting coupon");
            }

            } catch(SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
            } finally {
            try {
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
            } catch(SQLException e) {
            e.printStackTrace();
            }
            }
            %>