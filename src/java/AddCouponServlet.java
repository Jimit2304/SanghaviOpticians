import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddCouponServlet")
public class AddCouponServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String discountType = request.getParameter("discountType");
        String startDate = request.getParameter("startDate");
        String expiryDate = request.getParameter("expiryDate");
        double discountValue = Double.parseDouble(request.getParameter("discountValue"));
        double minPurchase = Double.parseDouble(request.getParameter("minPurchase"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO coupons (code, discountType, startDate, expiryDate, discountValue, minPurchase) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, code);
            stmt.setString(2, discountType);
            stmt.setString(3, startDate);
            stmt.setString(4, expiryDate);
            stmt.setDouble(5, discountValue);
            stmt.setDouble(6, minPurchase);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("view_coupons.jsp");
    }
}
