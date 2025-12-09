<%@page import="dtopackage.com.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) request.getAttribute("userdetails");
    if (user == null) {
        response.sendRedirect("ProfileServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>TripEase | Profile</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>

    body {
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg,#d8f3dc,#b7e4c7,#95d5b2);
        background-size: 300% 300%;
        animation: bgMove 8s ease infinite;
    }

    @keyframes bgMove {
        0% {background-position: 0% 50%;}
        50% {background-position: 100% 50%;}
        100% {background-position: 0% 50%;}
    }

    .profile-card {
        width: 420px;
        background: rgba(255,255,255,0.15);
        border-radius: 20px;
        padding: 30px;
        text-align: center;
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255,255,255,0.35);
        box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        animation: fadeIn 0.7s ease;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(20px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .profile-title {
        font-size: 28px;
        font-weight: 700;
        color: #0a3d22;
        margin-bottom: 18px;
    }

    .avatar {
        width: 95px;
        height: 95px;
        background: #fff;
        border-radius: 50%;
        margin: 0 auto 18px;
        border: 3px solid #52b788;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 40px;
        color: #2d6a4f;
        font-weight: 600;
        box-shadow: 0 0 12px rgba(0,0,0,0.15);
    }

    .info {
        text-align: left;
        background: rgba(255,255,255,0.55);
        padding: 10px 14px;
        margin: 8px 0;
        border-radius: 10px;
        font-size: 15px;
        border-left: 4px solid #2d6a4f;
    }

    .btn {
        width: 48%;
        padding: 12px;
        border-radius: 10px;
        border: none;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        text-align: center;
        color: #fff;
        margin-top: 15px;
        transition: 0.25s;
        display: inline-block;
        text-decoration: none;
    }

    .edit-btn {
        background: #2d6a4f;
    }
    .edit-btn:hover {
        background: #1b4332;
        transform: translateY(-2px);
    }

    .back-btn {
        background: #6c757d;
    }
    .back-btn:hover {
        background: #495057;
        transform: translateY(-2px);
    }

    .msg-box {
        background: #d4f8d4;
        color: #145a32;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 14px;
        font-weight: 500;
    }

</style>
</head>

<body>

<div class="profile-card">

    <% String msg = (String)request.getAttribute("msg");
       if(msg != null) { %>
       <div class="msg-box"><%= msg %></div>
    <% } %>

    <div class="profile-title">Your Profile</div>

    <div class="avatar">
        <%= user.getFull_name().charAt(0) %>
    </div>

    <div class="info"><b>Full Name:</b> <%= user.getFull_name() %></div>
    <div class="info"><b>Username:</b> <%= user.getUsername() %></div>
    <div class="info"><b>Email:</b> <%= user.getEmail() %></div>
    <div class="info"><b>Phone:</b> <%= user.getPhone() %></div>
    <div class="info"><b>Role:</b> <%= user.getRole() %></div>

    <a href="ProfileEditServlet" class="btn edit-btn">Edit Profile</a>
    <a href="Dashboard.jsp" class="btn back-btn">Back</a>

</div>

</body>
</html>
