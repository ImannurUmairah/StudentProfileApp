/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.profile;

/**
 *
 * @author LENOVO
 */
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private static final String URL =
        "jdbc:derby://localhost:1527/student_profiles";
    private static final String USER = "app";
    private static final String PASS = "app";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("name");
        String studentID = request.getParameter("studentID");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String about = request.getParameter("about");

        try {
            // Connect to Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);

            // Insert without ID — auto-generated
            String sql = "INSERT INTO STUDENT_PROFILES (name, studentID, program, email, hobbies, about) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, studentID);
            ps.setString(3, program);
            ps.setString(4, email);
            ps.setString(5, hobbies);
            ps.setString(6, about);

            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }

        // Set attributes for JSP
        request.setAttribute("name", name);
        request.setAttribute("studentID", studentID);
        request.setAttribute("program", program);
        request.setAttribute("email", email);
        request.setAttribute("hobbies", hobbies);
        request.setAttribute("about", about);

        // Forward to profile.jsp
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}