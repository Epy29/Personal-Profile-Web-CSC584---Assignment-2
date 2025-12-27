/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;


import com.model.ProfileBean;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewServlet", urlPatterns = {"/ViewServlet"})
public class ViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String jdbcURL = "jdbc:derby://localhost:1527/student_profiles";
        String dbUser = "app";
        String dbPassword = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {

                // === DELETE LOGIC ===
                if ("delete".equals(action)) {
                    String idToDelete = request.getParameter("id");
                    if (idToDelete != null) {
                        String deleteSQL = "DELETE FROM profiles WHERE student_id = ?";
                        try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSQL)) {
                            deleteStmt.setString(1, idToDelete);
                            deleteStmt.executeUpdate();
                        }
                    }
                    // avoid "re-deleting"
                    response.sendRedirect("ViewServlet"); 
                    return; 
                }

                // === VIEW/SEARCH LOGIC ===
                List<ProfileBean> profiles = new ArrayList<>();
                String searchQuery = request.getParameter("search");
                String sql;
                PreparedStatement statement;

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sql = "SELECT * FROM profiles WHERE LOWER(name) LIKE ? OR student_id LIKE ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, "%" + searchQuery.toLowerCase() + "%");
                    statement.setString(2, "%" + searchQuery + "%");
                } else {
                    sql = "SELECT * FROM profiles";
                    statement = connection.prepareStatement(sql);
                }

                ResultSet result = statement.executeQuery();

                while (result.next()) {
                    ProfileBean p = new ProfileBean();
                    p.setName(result.getString("name"));
                    p.setStudentId(result.getString("student_id"));
                    p.setProgram(result.getString("program"));
                    p.setEmail(result.getString("email"));
                    p.setHobbies(result.getString("hobbies"));
                    p.setIntro(result.getString("intro"));
                    profiles.add(p);
                }

                request.setAttribute("profileList", profiles);
                request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
