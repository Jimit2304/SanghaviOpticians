import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/insert")
@MultipartConfig
public class addProduct extends HttpServlet {
    private Connection con;

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma", "root", "Jimit@123");
        } catch (Exception e) {
            throw new ServletException("Failed to initialize database connection", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            // Add null checks and validation for numeric parameters
            String priceStr = request.getParameter("price");
            String discountPriceStr = request.getParameter("discountPrice"); 
            String stockStr = request.getParameter("stock");
            
            double price = 0.0;
            double discountPrice = 0.0;
            int stock = 0;
            
            if (priceStr != null && !priceStr.isEmpty()) {
                price = Double.parseDouble(priceStr);
            }
            if (discountPriceStr != null && !discountPriceStr.isEmpty()) {
                discountPrice = Double.parseDouble(discountPriceStr);
            }
            if (stockStr != null && !stockStr.isEmpty()) {
                stock = Integer.parseInt(stockStr);
            }

            String gender = request.getParameter("gender");
            String style = request.getParameter("style");
            String category = request.getParameter("category");
            String tags = request.getParameter("tags");

            Part filePart = request.getPart("images");
            if (filePart == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No file uploaded");
                return;
            }
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No file name provided");
                return;
            }
            
            // Get the real path of web application
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadsDir = new File(uploadPath);
            if (!uploadsDir.exists()) {
                uploadsDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + fileName;
            
            // Save the file
            try (FileOutputStream fos = new FileOutputStream(filePath);
                 InputStream is = filePart.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            }

            // Store relative path in database
            String dbImagePath = "uploads/" + fileName;

            String sql = "INSERT INTO products (name, description, price, discountPrice, stock, gender, style, category, tags, images) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setDouble(4, discountPrice);
            ps.setInt(5, stock);
            ps.setString(6, gender);
            ps.setString(7, style);
            ps.setString(8, category);
            ps.setString(9, tags);
            ps.setString(10, dbImagePath);

            int count = ps.executeUpdate();
            ps.close();
            
            if (count == 1) {
                response.sendRedirect("ad.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to insert product");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid numeric values provided");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
