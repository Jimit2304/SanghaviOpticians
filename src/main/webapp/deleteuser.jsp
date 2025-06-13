<%@ page import="java.sql.*" %>
<%
    String userIdStr = request.getParameter("id");
    if (userIdStr != null) {
        int userId = Integer.parseInt(userIdStr);
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            String sql = "DELETE FROM users WHERE userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("manageuser.jsp?msg=User+Deleted+Successfully");
            } else {
                response.sendRedirect("manageuser.jsp?msg=User+Not+Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageuser.jsp?msg=Error+Occurred");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("manageuser.jsp?msg=Invalid+User+ID");
    }
%>
