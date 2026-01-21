
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Add_Question")
public class Add_Question extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String CE_Id = request.getParameter("CE_Id");
        String Staff_Name = request.getParameter("Staff_Name");
        String Staff_Id = request.getParameter("Staff_Id");
        String Staff_Email = request.getParameter("Staff_Email");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

            // Check if CE_Id already exists in the questions table
            String checkQuery = "SELECT * FROM questions WHERE CE_Id = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, CE_Id);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) { // If CE_Id already exists, show an error
                request.getSession().setAttribute("msg", "Questions already exist for this exam. You cannot add more.");
                response.sendRedirect("error.jsp");
            } else {
                // If no questions exist for this CE_Id, insert new ones
                String insertQuery = "INSERT INTO questions  VALUES (?, ?, ?, ?, ?, ?, ?,?,?,?,?)";
                PreparedStatement insertStmt = con.prepareStatement(insertQuery);

                for (int i = 1; i <= 10; i++) {
                    String question = request.getParameter("question" + i);
                    String optionA = request.getParameter("optionA" + i);
                    String optionB = request.getParameter("optionB" + i);
                    String optionC = request.getParameter("optionC" + i);
                    String optionD = request.getParameter("optionD" + i);
                    String correctAnswer = request.getParameter("correctAnswer" + i); // Gets actual text

                    if (question != null && correctAnswer != null) {
                        insertStmt.setInt(1, 0);
                        insertStmt.setString(2, CE_Id);
                        insertStmt.setString(3, question);
                        insertStmt.setString(4, optionA);
                        insertStmt.setString(5, optionB);
                        insertStmt.setString(6, optionC);
                        insertStmt.setString(7, optionD);
                        insertStmt.setString(8, correctAnswer);
                        insertStmt.setString(9, Staff_Name);
                        insertStmt.setString(10, Staff_Id);
                        insertStmt.setString(11, Staff_Email);

                        insertStmt.executeUpdate();
                    }
                }

                con.close();
                response.sendRedirect("Add_Question.jsp");
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
