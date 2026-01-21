
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

@WebServlet(urlPatterns = {"/Create_Exam"})
public class Create_Exam extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);

        try {
            String Exam_Name = "", Start_Time = "", End_Time = "", Duration = "", Total_Marks = "", Total_Ques = "", Staff_Name = "", Staff_Id = "", Staff_Email = "";

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(4012);

            ServletFileUpload upload = new ServletFileUpload(factory);

            List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
            byte[] data = null;
            String fileName = null;
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString();

                    if (name.equalsIgnoreCase("Exam_Name")) {
                        Exam_Name = value;
                    } else if (name.equalsIgnoreCase("Start_Time")) {
                        Start_Time = value;
                    } else if (name.equalsIgnoreCase("End_Time")) {
                        End_Time = value;
                    } else if (name.equalsIgnoreCase("Duration")) {
                        Duration = value;
                    } else if (name.equalsIgnoreCase("Total_Marks")) {
                        Total_Marks = value;
                    } else if (name.equalsIgnoreCase("Total_Ques")) {
                        Total_Ques = value;
                    } else if (name.equalsIgnoreCase("Staff_Name")) {
                        Staff_Name = value;
                    } else if (name.equalsIgnoreCase("Staff_Email")) {
                        Staff_Email = value;
                    } else if (name.equalsIgnoreCase("Staff_Id")) {
                        Staff_Id = value;
                    }

                } else {
                    data = item.get();
                    fileName = item.getName();
                }
            }

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

            PreparedStatement stInsert = con.prepareStatement("INSERT INTO create_exam VALUES (?,?,?,?,?,?,?,?,?,?,'NO')");
            stInsert.setInt(1, 0);
            stInsert.setString(2, Exam_Name);
            stInsert.setString(3, Start_Time);
            stInsert.setString(4, End_Time);
            stInsert.setString(5, Duration);
            stInsert.setString(6, Total_Marks);
            stInsert.setString(7, Total_Ques);
            stInsert.setString(8, Staff_Name);
            stInsert.setString(9, Staff_Email);
            stInsert.setString(10, Staff_Id);

            int result = stInsert.executeUpdate();

            if (result > 0) {
                session.setAttribute("msg", "Exam Successfully Created. Please Upload Questions");
                response.sendRedirect("Create_Exam.jsp"); // Redirect to login page
            } else {
                session.setAttribute("msg", "Exam is not created");
                response.sendRedirect("Create_Exam.jsp");
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (FileUploadException e) {
            Logger.getLogger(Staff_Register.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "File upload failed.");
        } catch (ClassNotFoundException e) {
            Logger.getLogger(Staff_Register.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database driver not found.");
        } catch (SQLException e) {
            Logger.getLogger(Staff_Register.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database access error.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
