<%-- 
    Document   : profile
    Created on : Nov 21, 2025
    Author     : Epy
--%>
<%@page import="java.sql.*"%>
<%@page import="com.model.ProfileBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--============kene tukar ke jsp tag==============-->

<%
    
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    
    
    String idParam = request.getParameter("id");
    
    if (profile == null && idParam != null) {
        String dbURL = "jdbc:derby://localhost:1527/student_profiles";
        String dbUser = "app";
        String dbPass = "app";
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            String sql = "SELECT * FROM profiles WHERE student_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idParam);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                profile = new ProfileBean(
                    rs.getString("name"),
                    rs.getString("student_id"),
                    rs.getString("program"),
                    rs.getString("email"),
                    rs.getString("hobbies"),
                    rs.getString("intro")
                );
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    if(profile == null) {
        profile = new ProfileBean("Not Found", "-", "-", "-", "-", "Profile not found.");
    }
%>



<!DOCTYPE html>
<html>
<head>
    <title>Profile: <%= profile.getName() %></title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="profile-container">
        
        <div class="banner-section purple-glow">
            <img src="images/gadget.png" alt="Background Gadget" class="banner-bg">
            <div class="banner-content">
                <h1><%= profile.getName() %></h1>
                <p><%= profile.getProgram() %></p>
            </div>
        </div>

        <div class="content-grid">
            
            <div class="card purple-glow">
                <h3>About Me</h3>
                <div class="divider"></div>
                <p><%= profile.getIntro() %></p>
            </div>

            <div class="card purple-glow">
                <h3>Details</h3>
                <div class="divider" style="width: 100%;"></div>
                
                <div class="details-row">
                    <div class="detail-box">
                        <span class="icon">&#127380;</span> <span class="label">Student ID:</span>
                        <span class="value"><%= profile.getStudentId() %></span>
                    </div>

                    <div class="detail-box">
                        <span class="icon">&#9993;</span> <span class="label">Email:</span>
                        <span class="value"><%= profile.getEmail() %></span>
                    </div>

                    <div class="detail-box">
                        <span class="icon">&#127912;</span> <span class="label">Hobbies:</span>
                        <span class="value"><%= profile.getHobbies() %></span>
                    </div>
                </div>
            </div>
        </div>
                    
        <div style="text-align: center; margin-top: 10px;">
            <a href="viewProfiles.jsp" style="color: #BB86FC; text-decoration: none;">View Database List</a>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
             <a href="index.html" style="color: #BB86FC; text-decoration: none;">&larr; Create New Profile</a>
        </div>

    </div>

</body>
</html>