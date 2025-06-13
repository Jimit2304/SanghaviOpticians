<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*" %>
        <% try { int couponID=Integer.parseInt(request.getParameter("couponID")); String
            code=request.getParameter("code"); String discountType=request.getParameter("discountType"); double
            discountValue=Double.parseDouble(request.getParameter("discountValue")); double
            minPurchase=Double.parseDouble(request.getParameter("minPurchase")); String
            startDate=request.getParameter("startDate"); String expiryDate=request.getParameter("expiryDate");
            Class.forName("com.mysql.cj.jdbc.Driver"); Connection
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root" , "Jimit@123" ); String
            sql="UPDATE coupons SET code=?, discountType=?, discountValue=?, minPurchase=?, startDate=?, expiryDate=? WHERE couponID=?"
            ; PreparedStatement pstmt=con.prepareStatement(sql); pstmt.setString(1, code); pstmt.setString(2,
            discountType); pstmt.setDouble(3, discountValue); pstmt.setDouble(4, minPurchase); pstmt.setString(5,
            startDate); pstmt.setString(6, expiryDate); pstmt.setInt(7, couponID); pstmt.executeUpdate(); pstmt.close();
            con.close(); response.sendRedirect("coupons.jsp"); } catch(Exception e) { out.println("Error: " + e.getMessage());
}
%> 