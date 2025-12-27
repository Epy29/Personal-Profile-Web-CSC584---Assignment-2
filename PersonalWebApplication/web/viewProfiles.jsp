<%-- 
    Document   : viewProfiles
    Created on : Dec 24, 2025, 9:59:11 PM
    Author     : Epy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Profiles</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="profile-container">
        
        <div class="banner-section purple-glow" style="height: 150px;">
             <div class="banner-content">
                <h1>Student Database</h1>
            </div>
        </div>

        <div class="card purple-glow" style="margin-top: 20px;">
            <form action="ViewServlet" method="GET" class="input-group">
                <label>Search by Name or ID:</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="search" placeholder="Enter keyword..." style="flex-grow: 1;">
                    <button type="submit" class="btn-submit" style="margin:0; width: 150px;">Search</button>
                    <a href="ViewServlet" class="btn-submit" style="text-align:center; text-decoration:none; background:#333; color:white; margin:0; display:flex; align-items:center; justify-content:center; width: 100px;">Reset</a>
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
                
                <c:forEach var="p" items="${profileList}">
                    <tr style="border-bottom: 1px solid #333;">
                        <td style="padding: 10px;">${p.name}</td>
                        <td style="padding: 10px;">${p.studentId}</td>
                        <td style="padding: 10px;">${p.program}</td>
                        <td style="padding: 10px;">${p.email}</td>
                        <td style="padding: 10px;">
                            <a href="ViewServlet?action=delete&id=${p.studentId}" 
                               onclick="return confirm('Are you sure you want to delete this profile?');"
                               style="color: #FF5555; text-decoration: none; font-weight: bold;">
                               [Delete]
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty profileList}">
                    <tr>
                        <td colspan="4" style="padding: 20px; text-align: center; color: #888;">No profiles found.</td>
                    </tr>
                </c:if>
            </table>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="index.html" style="color: #BB86FC; text-decoration: none;">&larr; Add New Profile</a>
        </div>
    </div>
</body>
</html>
