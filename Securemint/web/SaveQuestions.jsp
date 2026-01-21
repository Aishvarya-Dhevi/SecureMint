<%@ page import="java.sql.*, java.io.*" %>
<%
    String CE_Id = request.getParameter("CE_Id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

        for (int i = 1; i <= 10; i++) {
            String question = request.getParameter("question" + i);
            String optionA = request.getParameter("optionA" + i);
            String optionB = request.getParameter("optionB" + i);
            String optionC = request.getParameter("optionC" + i);
            String optionD = request.getParameter("optionD" + i);
            String correctAnswer = request.getParameter("correctAnswer" + i); // Gets the actual text

            if (question != null && correctAnswer != null) {
                PreparedStatement pst = con.prepareStatement("INSERT INTO questions (CE_Id, question, optionA, optionB, optionC, optionD, correctAnswer) VALUES (?, ?, ?, ?, ?, ?, ?)");
                pst.setString(1, CE_Id);
                pst.setString(2, question);
                pst.setString(3, optionA);
                pst.setString(4, optionB);
                pst.setString(5, optionC);
                pst.setString(6, optionD);
                pst.setString(7, correctAnswer);
                pst.executeUpdate();
            }
        }
        
        con.close();
        response.sendRedirect("success.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
