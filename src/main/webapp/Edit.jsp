<%@page import="dtopackage.com.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
User user = (User) request.getAttribute("userdetails");
if(user == null){
    response.sendRedirect("ProfileServlet");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>TripEase | Edit Profile</title>

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
.edit-card{
    width:420px;
    background:#ffffff;
    border-radius:18px;
    padding:30px 28px;
    box-shadow:0 15px 40px rgba(0,0,0,0.12);
    animation:slideUp .6s ease;
}

@keyframes slideUp{
    from{opacity:0; transform:translateY(25px);}
    to{opacity:1; transform:translateY(0);}
}

/* TITLE */
.title{
    text-align:center;
    font-size:24px;
    font-weight:700;
    color:#1f3a3d;
    margin-bottom:22px;
}

/* INPUT */
.input-box{
    margin-bottom:14px;
}

.input-box label{
    display:block;
    font-size:13px;
    font-weight:600;
    color:#475569;
    margin-bottom:6px;
}

.input-box input{
    width:100%;
    padding:12px;
    border-radius:10px;
    border:1px solid #d1d5db;
    font-size:14px;
    outline:none;
    transition:.25s;
}

.input-box input:focus{
    border-color:#3ba58b;
    box-shadow:0 0 0 3px rgba(59,165,139,.15);
}

/* READONLY ROLE */
.role-box{
    background:#f1f5f9;
    border:1px dashed #cbd5e1;
    padding:12px;
    border-radius:10px;
    font-size:14px;
    font-weight:600;
    color:#334155;
}

/* BUTTONS */
.btn-group{
    display:flex;
    gap:12px;
    margin-top:20px;
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

.save-btn{
    background:#3ba58b;
    color:#fff;
}
.save-btn:hover{
    background:#2f8f77;
    transform:translateY(-2px);
}

.cancel-btn{
    background:#e5e7eb;
    color:#374151;
}
.cancel-btn:hover{
    background:#d1d5db;
    transform:translateY(-2px);
}
</style>
</head>

<body>

<div class="edit-card">

    <div class="title">Edit Profile</div>

    <form action="update" method="post">

        <div class="input-box">
            <label>Full Name</label>
            <input type="text" name="full_name" value="<%= user.getFull_name() %>" required>
        </div>

        <div class="input-box">
            <label>Username</label>
            <input type="text" name="username" value="<%= user.getUsername() %>" required>
        </div>

        <div class="input-box">
            <label>Email</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" required>
        </div>

        <div class="input-box">
            <label>Phone Number</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>" required>
        </div>

        <!-- ✅ ROLE (READ-ONLY) -->
       <div class="input-box">
    <label>Role</label>
    <input type="text"
           name="role"
           value="<%= user.getRole() %>"
           required>
</div>


        <div class="btn-group">
            <button type="submit" class="btn save-btn">Save Changes</button>
            <a href="ProfileServlet" class="btn cancel-btn">Cancel</a>
        </div>

    </form>

</div>

</body>
</html>
