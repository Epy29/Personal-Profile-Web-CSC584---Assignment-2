<%-- 
    Document   : profile
    Created on : Nov 21, 2025, 8:50:52 PM
    Author     : Epy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile: ${profile.name}</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="profile-container">
        
        <div class="banner-section purple-glow">
            <img src="images/gadget.png" alt="Background Gadget" class="banner-bg">
            
            
            <div class="banner-content">
                <h1>${profile.name}</h1>
                <p>${profile.program}</p>
            </div>
        </div>

        <div class="content-grid">
            
            <div class="card purple-glow">
                <h3>About Me</h3>
                <div class="divider"></div>
                <p>${profile.intro}</p>
            </div>

            <div class="card purple-glow">
                <h3>Details</h3>
                <div class="divider" style="width: 100%;"></div>
                
                <div class="details-row">
                    <div class="detail-box">
                        <span class="icon">&#127380;</span> <span class="label">Student ID:</span>
                        <span class="value">${profile.studentId}</span>
                    </div>

                    <div class="detail-box">
                        <span class="icon">&#9993;</span> <span class="label">Email:</span>
                        <span class="value">${profile.email}</span>
                    </div>

                    <div class="detail-box">
                        <span class="icon">&#127912;</span> <span class="label">Hobbies:</span>
                        <span class="value">${profile.hobbies}</span>
                    </div>
                </div>
            </div>
        </div>
                    
        <div style="text-align: center; margin-top: 10px;">
            <a href="ViewServlet" style="color: #BB86FC; text-decoration: none;">View Database List</a>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
             <a href="index.html" style="color: #BB86FC; text-decoration: none;">&larr; Create New Profile</a>
        </div>

    </div>

</body>
</html>


