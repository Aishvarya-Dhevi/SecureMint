import Connection.Dbconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Staff_Login"})
public class Staff_Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);

        try {
            Dbconnection dbConnection = new Dbconnection(); // Create instance of Dbconnection
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String enteredOtp = request.getParameter("otp");

            // Retrieve OTP from session
            String sessionEmail = (String) session.getAttribute("email");
            int sessionOtp = (int) session.getAttribute("otp");

            if (email.equals(sessionEmail) && Integer.parseInt(enteredOtp) == sessionOtp) {
                // OTP is correct, proceed with login
                String query = "SELECT * FROM staff_register WHERE Email='" + email + "' AND Password='" + password + "'";
                ResultSet rs = dbConnection.Select(query); // Use your custom Dbconnection class

                if (rs.next()) {
                    int id = rs.getInt("SF_Id");
                    session.setAttribute("msg", "Successfully Login");
                    session.setAttribute("SF_Id", id);
                    session.setAttribute("Email", email);
                    response.sendRedirect("Staff_Home.jsp");
                } else {
                    session.setAttribute("msg", "Invalid username and password");
                    response.sendRedirect("Staff_Login.jsp");
                }
            } else {
                session.setAttribute("msg", "Invalid OTP");
                response.sendRedirect("Staff_Login.jsp");
            }
        } catch (Exception ex) {
            out.println(ex);
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
