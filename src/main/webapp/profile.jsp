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

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    margin:0;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#e9f5f2,#f8fafc);
}

/* CARD */
.profile-card{
    width:420px;
    background:#ffffff;
    border-radius:18px;
    padding:28px;
    box-shadow:0 15px 40px rgba(0,0,0,0.12);
    animation:slideUp .6s ease;
}

@keyframes slideUp{
    from{opacity:0; transform:translateY(25px);}
    to{opacity:1; transform:translateY(0);}
}

/* HEADER */
.profile-header{
    text-align:center;
    margin-bottom:22px;
}

.avatar{
    width:90px;
    height:90px;
    border-radius:50%;
    background:#e8f5f3;
    margin:0 auto 12px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:36px;
    font-weight:700;
    color:#3ba58b;
}

.profile-title{
    font-size:24px;
    font-weight:700;
    color:#1f3a3d;
}

/* INFO */
.info{
    display:flex;
    justify-content:space-between;
    padding:12px 14px;
    border-radius:10px;
    background:#f4f7f6;
    margin-bottom:10px;
    font-size:14px;
}

.info b{
    color:#475569;
}

.info span{
    font-weight:500;
    color:#111827;
}

/* MESSAGE */
.msg-box{
    background:#dcfce7;
    color:#166534;
    padding:10px 14px;
    border-radius:10px;
    font-size:14px;
    margin-bottom:14px;
    text-align:center;
}

/* BUTTONS */
.btn-group{
    display:flex;
    gap:12px;
    margin-top:18px;
}

.btn{
    flex:1;
    padding:12px;
    border-radius:10px;
    border:none;
    font-size:14px;
    font-weight:600;
    cursor:pointer;
    text-align:center;
    text-decoration:none;
    transition:.25s;
}

.edit-btn{
    background:#3ba58b;
    color:#fff;
}

.edit-btn:hover{
    background:#2f8f77;
    transform:translateY(-2px);
}

.back-btn{
    background:#e5e7eb;
    color:#374151;
}

.back-btn:hover{
    background:#d1d5db;
    transform:translateY(-2px);
}
</style>
</head>

<body>

<div class="profile-card">

    <% String msg = (String)request.getAttribute("msg");
       if(msg != null) { %>
       <div class="msg-box"><%= msg %></div>
    <% } %>

    <div class="profile-header">
        <div class="avatar"><%= user.getFull_name().charAt(0) %></div>
        <div class="profile-title">My Profile</div>
    </div>

    <div class="info"><b>Full Name</b><span><%= user.getFull_name() %></span></div>
    <div class="info"><b>Username</b><span><%= user.getUsername() %></span></div>
    <div class="info"><b>Email</b><span><%= user.getEmail() %></span></div>
    <div class="info"><b>Phone</b><span><%= user.getPhone() %></span></div>
    <div class="info"><b>Role</b><span><%= user.getRole() %></span></div>

    <div class="btn-group">
        <a href="ProfileEditServlet" class="btn edit-btn">Edit Profile</a>
        <a href="Dashboard.jsp" class="btn back-btn">Back</a>
    </div>

</div>

</body>
</html>
