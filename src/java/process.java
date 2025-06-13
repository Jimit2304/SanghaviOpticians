//import java.io.IOException;
//import java.sql.*;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/process")
//public class process extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer userID = (Integer) session.getAttribute("userID");
//
//        if (userID == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Get form data
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email");
//        String phone = request.getParameter("phone");
//        String address = request.getParameter("address");
//        String city = request.getParameter("city");
//        String pincode = request.getParameter("pincode");
//        String paymentMethod = request.getParameter("paymentMethod");
//        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
//
//        Connection conn = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            // Database connection
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
//
//            // Insert into orders table
//            String insertOrderSQL = "INSERT INTO orders (userID, fullName, email, phone, address, city, pincode, paymentMethod, totalAmount, orderStatus, createdAt) " +
//                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', NOW())";
//            ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
//            ps.setInt(1, userID);
//            ps.setString(2, fullName);
//            ps.setString(3, email);
//            ps.setString(4, phone);
//            ps.setString(5, address);
//            ps.setString(6, city);
//            ps.setString(7, pincode);
//            ps.setString(8, paymentMethod);
//            ps.setDouble(9, totalAmount);
//
//            int rowsAffected = ps.executeUpdate();
//            if (rowsAffected == 0) {
//                throw new SQLException("Failed to insert order.");
//            }
//
//            // Get generated orderID
//            rs = ps.getGeneratedKeys();
//            int orderID = 0;
//            if (rs.next()) {
//                orderID = rs.getInt(1);
//            }
//
//            // Insert order items from cart
//            String insertOrderItemsSQL = "INSERT INTO order_items (orderID, productID, quantity, Oprice) " +
//                                         "SELECT ?, c.productID, c.quantity, p.finalPrice FROM cart c " +
//                                         "JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
//            ps = conn.prepareStatement(insertOrderItemsSQL);
//            ps.setInt(1, orderID);
//            ps.setInt(2, userID);
//            ps.executeUpdate();
//
//            // Clear cart after order placement
//            String clearCartSQL = "DELETE FROM cart WHERE userID = ?";
//            ps = conn.prepareStatement(clearCartSQL);
//            ps.setInt(1, userID);
//            ps.executeUpdate();
//
//            // Redirect to order confirmation page
//            response.sendRedirect("orderConfermation.jsp?orderID=" + orderID);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("checkout.jsp?error=Something went wrong.");
//        } finally {
//            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
//        }
//    }
//}
//
//import java.io.IOException;
//import java.sql.*;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/process")
//public class process extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer userID = (Integer) session.getAttribute("userID");
//
//        if (userID == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Get form data
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email");
//        String phone = request.getParameter("phone");
//        String address = request.getParameter("address");
//        String city = request.getParameter("city");
//        String pincode = request.getParameter("pincode");
//        String paymentMethod = request.getParameter("paymentMethod");
//        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
//
//        Connection conn = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            // Database connection
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
//
//            // Insert into orders table
//            String insertOrderSQL = "INSERT INTO orders (userID, fullName, email, phone, address, city, pincode, paymentMethod, totalAmount, orderStatus, createdAt) " +
//                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', NOW())";
//            ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
//            ps.setInt(1, userID);
//            ps.setString(2, fullName);
//            ps.setString(3, email);
//            ps.setString(4, phone);
//            ps.setString(5, address);
//            ps.setString(6, city);
//            ps.setString(7, pincode);
//            ps.setString(8, paymentMethod);
//            ps.setDouble(9, totalAmount);
//
//            int rowsAffected = ps.executeUpdate();
//            if (rowsAffected == 0) {
//                throw new SQLException("Failed to insert order.");
//            }
//
//            // Get generated orderID
//            rs = ps.getGeneratedKeys();
//            int orderID = 0;
//            if (rs.next()) {
//                orderID = rs.getInt(1);
//            }
//
//            // Insert order items from cart, including lensID
//            String insertOrderItemsSQL = "INSERT INTO order_items (orderID, productID, lensID, quantity, Oprice) " +
//                                         "SELECT ?, c.productID, c.lensID, c.quantity, p.finalPrice FROM cart c " +
//                                         "JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
//            ps = conn.prepareStatement(insertOrderItemsSQL);
//            ps.setInt(1, orderID);
//            ps.setInt(2, userID);
//            ps.executeUpdate();
//
//            // Clear cart after order placement
//            String clearCartSQL = "DELETE FROM cart WHERE userID = ?";
//            ps = conn.prepareStatement(clearCartSQL);
//            ps.setInt(1, userID);
//            ps.executeUpdate();
//
//            // Redirect to order confirmation page
//            response.sendRedirect("orderConfermation.jsp?orderID=" + orderID);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("checkout.jsp?error=Something went wrong.");
//        } finally {
//            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
//        }
//    }
//}


import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/process")
public class process extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String paymentMethod = request.getParameter("paymentMethod");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            // Step 1: Insert into orders table
            String insertOrderSQL = "INSERT INTO orders (userID, fullName, email, phone, address, city, pincode, paymentMethod, totalAmount, orderStatus, createdAt) " +
                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', NOW())";
            ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userID);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, city);
            ps.setString(7, pincode);
            ps.setString(8, paymentMethod);
            ps.setDouble(9, totalAmount);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Failed to insert order.");
            }

            // Get generated orderID
            rs = ps.getGeneratedKeys();
            int orderID = 0;
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
            rs.close();
            ps.close();

            // Step 2: Retrieve the latest prescription for this user
            int prescriptionID = 0;
            int lensID = 0;
            String prescriptionQuery = "SELECT prescriptionID, lensID FROM prescriptions WHERE userID = ? ORDER BY createdAt DESC LIMIT 1";
            ps = conn.prepareStatement(prescriptionQuery);
            ps.setInt(1, userID);
            rs = ps.executeQuery();

            if (rs.next()) {
                prescriptionID = rs.getInt("prescriptionID");
                lensID = rs.getInt("lensID");
            }
            rs.close();
            ps.close();

            // Step 3: Insert order items from cart, using `lensID` from `prescriptions` instead of cart
            String insertOrderItemsSQL = "INSERT INTO order_items (orderID, productID, lensID, quantity, Oprice, prescriptionID) " +
                                         "SELECT ?, c.productID, ?, c.quantity, p.finalPrice, ? FROM cart c " +
                                         "JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
            ps = conn.prepareStatement(insertOrderItemsSQL);
            ps.setInt(1, orderID);
            ps.setInt(2, lensID); // Using lensID from prescriptions
            ps.setInt(3, prescriptionID); // Storing the prescription reference
            ps.setInt(4, userID);
            ps.executeUpdate();
            ps.close();

            // Step 4: Clear cart after order placement
            String clearCartSQL = "DELETE FROM cart WHERE userID = ?";
            ps = conn.prepareStatement(clearCartSQL);
            ps.setInt(1, userID);
            ps.executeUpdate();
            ps.close();

            // Redirect to order confirmation page
            response.sendRedirect("orderConfermation.jsp?orderID=" + orderID);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=Something went wrong.");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
//import java.io.IOException;
//import java.sql.*;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/process")
//public class process extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer userID = (Integer) session.getAttribute("userID");
//
//        if (userID == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        // Get form data
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email");
//        String phone = request.getParameter("phone");
//        String address = request.getParameter("address");
//        String city = request.getParameter("city");
//        String pincode = request.getParameter("pincode");
//        String paymentMethod = request.getParameter("paymentMethod");
//        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
//
//        Connection conn = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
//
//            // Step 1: Insert into orders table
//            String insertOrderSQL = "INSERT INTO orders (userID, fullName, email, phone, address, city, pincode, paymentMethod, totalAmount, orderStatus, createdAt) " +
//                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', NOW())";
//            ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
//            ps.setInt(1, userID);
//            ps.setString(2, fullName);
//            ps.setString(3, email);
//            ps.setString(4, phone);
//            ps.setString(5, address);
//            ps.setString(6, city);
//            ps.setString(7, pincode);
//            ps.setString(8, paymentMethod);
//            ps.setDouble(9, totalAmount);
//            ps.executeUpdate();
//
//            rs = ps.getGeneratedKeys();
//            int orderID = 0;
//            if (rs.next()) {
//                orderID = rs.getInt(1);
//            }
//            rs.close();
//            ps.close();
//
//            // Step 2: Get latest prescription for user
//            int prescriptionID = 0;
//            int lensID = 0;
//            String presSQL = "SELECT prescriptionID, lensID FROM prescriptions WHERE userID = ? ORDER BY createdAt DESC LIMIT 1";
//            ps = conn.prepareStatement(presSQL);
//            ps.setInt(1, userID);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                prescriptionID = rs.getInt("prescriptionID");
//                lensID = rs.getInt("lensID");
//            }
//            rs.close();
//            ps.close();
//
//            // Step 3: Insert order items from cart
//            String orderItemsSQL = "INSERT INTO order_items (orderID, productID, lensID, quantity, Oprice, prescriptionID) " +
//                                   "SELECT ?, c.productID, ?, c.quantity, p.finalPrice, ? FROM cart c " +
//                                   "JOIN products p ON c.productID = p.productID WHERE c.userID = ?";
//            ps = conn.prepareStatement(orderItemsSQL);
//            ps.setInt(1, orderID);
//            ps.setInt(2, lensID);
//            ps.setInt(3, prescriptionID);
//            ps.setInt(4, userID);
//            ps.executeUpdate();
//            ps.close();
//
//            // Step 4: Clear Cart
//            ps = conn.prepareStatement("DELETE FROM cart WHERE userID = ?");
//            ps.setInt(1, userID);
//            ps.executeUpdate();
//            ps.close();
//
//            // Step 5: Redirect based on Payment Method
//            if ("Online Payment".equals(paymentMethod)) {
//                response.sendRedirect("paymentQR.jsp?orderID=" + orderID);
//            } else {
//                response.sendRedirect("orderConfermation.jsp?orderID=" + orderID);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("checkout.jsp?error=Something went wrong.");
//        } finally {
//            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
//            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
//        }
//    }
//}
