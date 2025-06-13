import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        ArrayList<order> orders = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            String query = "SELECT o.orderID, o.createdAt, o.totalAmount, o.paymentMethod, o.orderStatus, " +
                           "oi.productID, p.name AS productName, " +
                           "oi.lensID, l.name AS lensName, " +
                           "oi.quantity, oi.Oprice, oi.prescriptionID " +
                           "FROM orders o " +
                           "JOIN order_items oi ON o.orderID = oi.orderID " +
                           "JOIN products p ON oi.productID = p.productID " +
                           "LEFT JOIN lenses l ON oi.lensID = l.lensID " +
                           "WHERE o.userID = ? " +
                           "ORDER BY o.createdAt DESC";

            ps = con.prepareStatement(query);
            ps.setInt(1, userID);
            rs = ps.executeQuery();

            while (rs.next()) {
                order order = new order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCreatedAt(rs.getTimestamp("createdAt"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setProductID(rs.getInt("productID"));
                order.setProductName(rs.getString("productName"));
                order.setLensID(rs.getInt("lensID"));
                order.setLensName(rs.getString("lensName"));
                order.setQuantity(rs.getInt("quantity"));
                order.setOprice(rs.getDouble("Oprice"));
                order.setPrescriptionID(rs.getInt("prescriptionID"));

                orders.add(order);
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
