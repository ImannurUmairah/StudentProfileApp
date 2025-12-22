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
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

// JDBC imports
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// import the bean
import com.profile.ProfileBean;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_profiles";
    private static final String DB_USER = "root"; // your MySQL username
    private static final String DB_PASSWORD = ""; // your MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Create ProfileBean and set data from form
        ProfileBean profile = new ProfileBean();
        profile.setName(request.getParameter("name"));
        profile.setStudentID(request.getParameter("studentID"));
        profile.setProgram(request.getParameter("program"));
        profile.setEmail(request.getParameter("email"));
        profile.setHobbies(request.getParameter("hobbies"));
        profile.setAbout(request.getParameter("about"));

        // 2. Insert data into MySQL
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO profile (name, studentID, program, email, hobbies, about) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getStudentID());
            ps.setString(3, profile.getProgram());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getAbout());

            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection problem.", e);
        }

        // 3. Set attributes for JSP
        request.setAttribute("name", profile.getName());
        request.setAttribute("studentID", profile.getStudentID());
        request.setAttribute("program", profile.getProgram());
        request.setAttribute("email", profile.getEmail());
        request.setAttribute("hobbies", profile.getHobbies());
        request.setAttribute("about", profile.getAbout());

        // 4. Forward to profile.jsp
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

} 







