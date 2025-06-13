<%-- <%
    String orderID = request.getParameter("orderID");
    double totalAmount = 0.0;

    // Fetch Total Amount From DB
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
        ps = con.prepareStatement(
            "SELECT SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
            "FROM order_items oi " +
            "JOIN products p ON oi.productID = p.productID " +
            "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
            "WHERE oi.orderID = ?"
        );
        ps.setString(1, orderID);
        rs = ps.executeQuery();
        if(rs.next()) {
            totalAmount = rs.getDouble("totalAmount");
        }
    } catch (Exception e) {
        out.print("Error fetching total amount: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
        if (ps != null) try { ps.close(); } catch (SQLException e) { /* ignored */ }
        if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
    }

    String upiId = "yourupiid@upi";  // Replace with your UPI ID
    String name = "Sanghavi Opticians";

    String qrData = "upi://pay?pa="+upiId+"&pn="+name+"&am="+totalAmount+"&cu=INR";
%>

<html>
<head>
<title>UPI Payment</title>
</head>
<body>

<h2>Scan To Pay</h2>
<p>Amount : ₹<%= totalAmount %></p>

<img src="https://chart.googleapis.com/chart?chs=250x250&cht=qr&chl=<%=qrData%>" alt="UPI QR Code">

<br><br>
<a href="orderSuccess.jsp?orderID=<%=orderID%>">I Have Paid</a>

</body>
</html>
 --%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*, java.net.URLEncoder" %>
<%
    String orderID = request.getParameter("orderID");
    double totalAmount = 0.0;

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

    PreparedStatement ps = con.prepareStatement(
        "SELECT SUM((p.finalPrice + IFNULL(l.price, 0)) * oi.quantity) AS totalAmount " +
        "FROM order_items oi " +
        "JOIN products p ON oi.productID = p.productID " +
        "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
        "WHERE oi.orderID = ?"
    );
    ps.setString(1, orderID);
    ResultSet rs = ps.executeQuery();

    if(rs.next()) {
        totalAmount = rs.getDouble("totalAmount");
    }

    rs.close();
    ps.close();
    con.close();

    String upiId = "jimitsanghavi64@upi";  
    String name = "Sanghavi Opticians";

    String qrData = "upi://pay?pa="+upiId+"&pn="+name+"&am="+totalAmount+"&cu=INR";
    String encodedQR = URLEncoder.encode(qrData, "UTF-8");
%>

<h2>Scan To Pay</h2>
<p>Amount : ₹<%= totalAmount %></p>

<img src="https://chart.googleapis.com/chart?chs=250x250&cht=qr&chl=<%=encodedQR%>" alt="UPI QR Code">

<br><br>
<a href="orderSuccess.jsp?orderID=<%=orderID%>">I Have Paid</a>
 