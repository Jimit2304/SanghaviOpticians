import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Time;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class book extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection con;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
        } catch (Exception e) {
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");

        try {
            String fullName = request.getParameter("full_name");
            String phoneNumber = request.getParameter("phone_number");
            String emailAddress = request.getParameter("email_address");
            String preferredDateStr = request.getParameter("preferred_date");
            String preferredTimeStr = request.getParameter("preferred_time");
            String specificConcerns = request.getParameter("specific_concerns");

            if (fullName == null || phoneNumber == null || emailAddress == null || preferredDateStr == null || preferredTimeStr == null) {
                response.getWriter().println("<script>alert('Error: Missing required fields'); window.location='book.html';</script>");
                return;
            }

            // Convert date and time to SQL format
            Date preferredDate = Date.valueOf(preferredDateStr);
            Time preferredTime = Time.valueOf(preferredTimeStr + ":00");

            // Prepare SQL Query
            String sql = "INSERT INTO book (full_name, phone_number, email_address, preferred_date, preferred_time, specific_concerns, created_at) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, fullName);
                ps.setString(2, phoneNumber);
                ps.setString(3, emailAddress);
                ps.setDate(4, preferredDate);
                ps.setTime(5, preferredTime);
                ps.setString(6, specificConcerns);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    response.getWriter().println("<script>alert('Appointment booked successfully!'); window.location='dashboard.html';</script>");
                } else {
                    response.getWriter().println("<script>alert('Error: Appointment not saved.'); window.location='book.html';</script>");
                }
            }
        } catch (IllegalArgumentException e) {
            response.getWriter().println("<script>alert('Error: Invalid date or time format.'); window.location='book.html';</script>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "'); window.location='book.html';</script>");
        }
    }

    @Override
    public void destroy() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
