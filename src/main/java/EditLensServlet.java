import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/EditLensServlet")
public class EditLensServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int lensID = Integer.parseInt(request.getParameter("lensID"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String material = request.getParameter("material");
        String coating = request.getParameter("coating");
        
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String coatingColor=request.getParameter("coatingColor");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");

            String query = "UPDATE lenses SET name=?, type=?, material=?, coating=?, price=?, stock=? , coatingColor=?WHERE lensID=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, type);
            pstmt.setString(3, material);
            pstmt.setString(4, coating);
            pstmt.setDouble(5, price);
            pstmt.setInt(6, stock);
            pstmt.setString(7, coatingColor);
            pstmt.setInt(8, lensID);
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("manageLens.jsp");
    }
}
