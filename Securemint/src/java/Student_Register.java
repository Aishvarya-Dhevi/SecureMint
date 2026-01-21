
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

@WebServlet(urlPatterns = {"/Student_Register"})
public class Student_Register extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);

        try {
            String User_Name = "", College_Name = "", Register_Number = "", Department = "", Year = "", Email = "", Password = "", Address = "", Contact = "", State = "", City = "";
            String saveFile = "";

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

                    if (name.equalsIgnoreCase("User_Name")) {
                        User_Name = value;
                    } else if (name.equalsIgnoreCase("College_Name")) {
                        College_Name = value;
                    } else if (name.equalsIgnoreCase("Register_Number")) {
                        Register_Number = value;
                    } else if (name.equalsIgnoreCase("Department")) {
                        Department = value;
                    } else if (name.equalsIgnoreCase("Year")) {
                        Year = value;
                    } else if (name.equalsIgnoreCase("Email")) {
                        Email = value;
                    } else if (name.equalsIgnoreCase("Contact")) {
                        Contact = value;
                    } else if (name.equalsIgnoreCase("Password")) {
                        Password = value;
                    } else if (name.equalsIgnoreCase("State")) {
                        State = value;
                    } else if (name.equalsIgnoreCase("City")) {
                        City = value;
                    } else if (name.equalsIgnoreCase("Address")) {
                        Address = value;
                    }

                } else {
                    data = item.get();
                    fileName = item.getName();
                }
            }

            if (fileName != null && !fileName.isEmpty()) {
                String path1 = request.getSession().getServletContext().getRealPath("/");
                String strPath1 = path1 + File.separator + fileName;
                File file = new File(strPath1);
                FileOutputStream fileOut = new FileOutputStream(file);
                fileOut.write(data, 0, data.length);
                fileOut.flush();
                fileOut.close();

                FileInputStream fis = new FileInputStream(file);
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

                String query = "SELECT * FROM student_register WHERE Email=?";
                PreparedStatement st = con.prepareStatement(query);
                st.setString(1, Email);

                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    session.setAttribute("msg", "Email already exists. Please choose a different username or Email.");
                    response.sendRedirect("Student_Register.jsp");
                } else {
                    PreparedStatement stInsert = con.prepareStatement("INSERT INTO student_register VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,'NO')");
                    stInsert.setInt(1, 0); // Assuming this is an auto-increment ID
                    stInsert.setString(2, User_Name);
                    stInsert.setString(3, Register_Number);
                    stInsert.setString(4, College_Name);
                    stInsert.setString(5, Department);
                    stInsert.setString(6, Year);
                    stInsert.setString(7, Email);
                    stInsert.setString(8, Password);
                    stInsert.setString(9, Contact);
                    stInsert.setString(10, State);
                    stInsert.setString(11, City);
                    stInsert.setString(12, Address);

                    stInsert.setBinaryStream(13, fis, (int) file.length());
                    int result = stInsert.executeUpdate();

                    fis.close();
                    file.delete(); // Delete the temporary uploaded file
                    if (result > 0) {
                        session.setAttribute("msg", "Successfully registered. Please log in.");
                        response.sendRedirect("Student_Login.jsp"); // Redirect to login page
                    }
                }
            } else {
                session.setAttribute("msg", "Please upload a file.");
                response.sendRedirect("Student_Register.jsp");
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
