/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.model.ProfileBean;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//class object, kau

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve Data
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");

        // 2. Create Bean Object 
        ProfileBean profile = new ProfileBean(name, studentId, program, email, hobbies, intro);

        // 3. Database Connection 
        String jdbcURL = "jdbc:derby://localhost:1527/student_profiles;create=true";
        String dbUser = "app";
        String dbPassword = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Connect and Insert
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
                String sql = "INSERT INTO profiles (name, student_id, program, email, hobbies, intro) VALUES (?, ?, ?, ?, ?, ?)";
                
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, profile.getName());
                statement.setString(2, profile.getStudentId());
                statement.setString(3, profile.getProgram());
                statement.setString(4, profile.getEmail());
                statement.setString(5, profile.getHobbies());
                statement.setString(6, profile.getIntro());
                
                statement.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Errors
        }

        request.setAttribute("profile", profile); 
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
