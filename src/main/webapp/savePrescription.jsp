<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Ensure user is logged in
    int userID = (session.getAttribute("userID") != null) ? (int) session.getAttribute("userID") : -1;
    if (userID == -1) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Get lens and prescription details from the form
    int lensID = Integer.parseInt(request.getParameter("lensID"));
    String right_sph = request.getParameter("right_sph");
    String right_cyl = request.getParameter("right_cyl");
    String right_axis = request.getParameter("right_axis");
    String right_add = request.getParameter("right_add");
    String left_sph = request.getParameter("left_sph");
    String left_cyl = request.getParameter("left_cyl");
    String left_axis = request.getParameter("left_axis");
    String left_add = request.getParameter("left_add");

    // Save lens details in session
    session.setAttribute("selectedLensID", lensID);
    session.setAttribute("right_sph", right_sph);
    session.setAttribute("right_cyl", right_cyl);
    session.setAttribute("right_axis", right_axis);
    session.setAttribute("right_add", right_add);
    session.setAttribute("left_sph", left_sph);
    session.setAttribute("left_cyl", left_cyl);
    session.setAttribute("left_axis", left_axis);
    session.setAttribute("left_add", left_add);

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

        // Insert prescription details into the database
        String query = "INSERT INTO prescriptions (userID, lensID, right_sph, right_cyl, right_axis, right_add, left_sph, left_cyl, left_axis, left_add) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userID);
        ps.setInt(2, lensID);
        ps.setString(3, right_sph);
        ps.setString(4, right_cyl);
        ps.setString(5, right_axis);
        ps.setString(6, right_add);
        ps.setString(7, left_sph);
        ps.setString(8, left_cyl);
        ps.setString(9, left_axis);
        ps.setString(10, left_add);

        int rowsInserted = ps.executeUpdate();
        ps.close();
        conn.close();

        if (rowsInserted > 0) {
            response.sendRedirect("bill.jsp"); // Redirect to bill page after saving
        } else {
            out.println("<script>alert('Error saving prescription!'); window.location='selectLenses.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
