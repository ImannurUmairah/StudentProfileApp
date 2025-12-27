/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.profile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/student_profiles";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String studentID = request.getParameter("studentID");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String about = request.getParameter("about");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "UPDATE STUDENT_PROFILES SET name=?, studentID=?, program=?, email=?, hobbies=?, about=? WHERE ID=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, studentID);
            ps.setString(3, program);
            ps.setString(4, email);
            ps.setString(5, hobbies);
            ps.setString(6, about);
            ps.setInt(7, id);

            ps.executeUpdate();

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("viewProfiles.jsp");
    }
}