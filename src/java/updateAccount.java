
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.security.MessageDigest;
import java.util.Base64;

/**
 * Servlet implementation class updateAccount
 */
@WebServlet("/updateAccount")
public class updateAccount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateAccount() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("manageAccount.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Retrieve form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/ma"; // Update with your database URL
        String dbUser = "root"; // Update with your database username
        String dbPassword = "Jimit@123"; // Update with your database password

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Hash the new password if provided
            String passwordToStore = newPassword.isEmpty() ? currentPassword : newPassword;
            if (!newPassword.isEmpty()) {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(passwordToStore.getBytes());
                passwordToStore = Base64.getEncoder().encodeToString(hash);
            }

            // Update user account in the database
            String sql = "UPDATE users SET firstName=?, lastName=?, phoneNumber=?, address=?, password=? WHERE email=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, phoneNumber);
            statement.setString(4, address);
            statement.setString(5, passwordToStore); // Store the hashed password
            statement.setString(6, email);
            statement.executeUpdate();

            // Close the connection
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to manageAccount.jsp after updating
        response.sendRedirect("manageAccount.jsp");
    }
}
