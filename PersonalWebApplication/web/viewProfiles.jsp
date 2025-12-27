<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    // 1. DATABASE CONFIGURATION (Using your specific DB details)
    String dbURL = "jdbc:derby://localhost:1527/student_profiles";
    String dbUser = "app";
    String dbPass = "app";
    String driver = "org.apache.derby.jdbc.ClientDriver";
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Profiles</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    
    <%
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idToDelete = request.getParameter("id");
            if (idToDelete != null) {
                try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    String deleteSQL = "DELETE FROM profiles WHERE student_id = ?";
                    PreparedStatement pst = conn.prepareStatement(deleteSQL);
                    pst.setString(1, idToDelete);
                    pst.executeUpdate();
                    conn.close();
                    // Refresh page
                    response.sendRedirect("viewProfiles.jsp"); 
                    return;
                } catch (Exception e) {
                    out.println("<script>alert('Error deleting: " + e.getMessage() + "');</script>");
                }
            }
        }
    %>

    <div class="profile-container">
        
        <div class="banner-section purple-glow" style="height: 150px;">
             <div class="banner-content">
                <h1>Student Database</h1>
            </div>
        </div>

        <div class="card purple-glow" style="margin-top: 20px;">
            <form action="viewProfiles.jsp" method="GET" class="input-group">
                <label>Search by Name or ID:</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="search" placeholder="Enter keyword..." style="flex-grow: 1;" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit" class="btn-submit" style="margin:0; width: 150px;">Search</button>
                    <a href="viewProfiles.jsp" class="btn-submit" style="text-align:center; text-decoration:none; background:#333; color:white; margin:0; display:flex; align-items:center; justify-content:center; width: 100px;">Reset</a>
                </div>
            </form>
        </div>

        <div class="card purple-glow">
            <table style="width: 100%; color: white; text-align: left; border-collapse: collapse;">
                <tr style="border-bottom: 2px solid #BB86FC;">
                    <th style="padding: 10px;">Name</th>
                    <th style="padding: 10px;">Student ID</th>
                    <th style="padding: 10px;">Program</th>
                    <th style="padding: 10px;">Email</th>
                    <th style="padding: 10px;">Action</th>
                </tr>
                
                <%-- LOOPING START SINI --%>
                <% 
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    String searchQuery = request.getParameter("search");

                    try {
                        Class.forName(driver);
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                        
                        String sql = "SELECT * FROM profiles"; // Your table name
                        
                        if(searchQuery != null && !searchQuery.trim().isEmpty()){
                            sql += " WHERE LOWER(name) LIKE ? OR student_id LIKE ?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, "%" + searchQuery.toLowerCase() + "%");
                            ps.setString(2, "%" + searchQuery + "%");
                        } else {
                            ps = conn.prepareStatement(sql);
                        }

                        rs = ps.executeQuery();
                        
                        boolean hasData = false;
                        
                        // THE LOOP LOGIC, DOUBLE CHECK
                        // kene add unique feat later, delete or view
                        while(rs.next()) { 
                            hasData = true;
                %>
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 10px;"><%= rs.getString("name") %></td>
                        <td style="padding: 10px;"><%= rs.getString("student_id") %></td>
                        <td style="padding: 10px;"><%= rs.getString("program") %></td>
                        <td style="padding: 10px;"><%= rs.getString("email") %></td>
                        <td style="padding: 10px;">
                            <a href="profile.jsp?id=<%= rs.getString("student_id") %>" 
                               style="color: #03DAC6; text-decoration: none; font-weight: bold; margin-right: 10px;">
                               [View]
                            </a>
                            
                            <a href="viewProfiles.jsp?action=delete&id=<%= rs.getString("student_id") %>" 
                               onclick="return confirm('Are you sure you want to delete this profile?');"
                               style="color: #FF5555; text-decoration: none; font-weight: bold;">
                               [Delete]
                            </a>
                        </td>
                    </tr>
                <% 
                        } // End While Loop 
                        
                        if(!hasData) {
                %>
                    <tr>
                        <td colspan="5" style="padding: 20px; text-align: center; color: #888;">No profiles found.</td>
                    </tr>
                <%
                        }

                    } catch(Exception e) {
                        out.println("<tr><td colspan='5' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if(conn != null) conn.close();
                    }
                %>
                
                
            </table>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="index.html" style="color: #BB86FC; text-decoration: none;">&larr; Add New Profile</a>
        </div>
    </div>
</body>
</html>