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

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>

    /* Background Animation */
    body {
        margin: 0;
        padding: 0;
        height: 100vh;
        font-family: "Poppins", sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg,#d8f3dc,#b7e4c7,#95d5b2);
        background-size: 300% 300%;
        animation: bgMove 8s ease-in-out infinite alternate;
    }

    @keyframes bgMove {
        from { background-position: 0% 50%; }
        to { background-position: 100% 50%; }
    }

    /* Glass Card */
    .edit-card {
        width: 420px;
        background: rgba(255,255,255,0.18);
        backdrop-filter: blur(12px);
        border-radius: 18px;
        padding: 34px 28px;
        border: 1px solid rgba(255,255,255,0.40);
        box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        animation: fadeIn 0.6s ease-out;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(20px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .title {
        text-align: center;
        font-size: 28px;
        font-weight: 700;
        color: #064e3b;
        margin-bottom: 22px;
    }

    /* Floating Input Field */
    .input-box {
        position: relative;
        margin: 14px 0;
    }

    .input-box input,
    select {
        width: 100%;
        padding: 14px 12px;
        border-radius: 10px;
        border: 1px solid #bbe4d3;
        font-size: 15px;
        background: rgba(255,255,255,0.75);
        outline: none;
        transition: .25s;
    }

    .input-box input:focus,
    select:focus {
        border-color: #2d6a4f;
        background: white;
        box-shadow: 0px 0px 10px rgba(45,106,79,0.32);
    }

    .input-box label {
        position: absolute;
        left: 12px;
        top: 13px;
        font-size: 15px;
        color: #4f4f4f;
        pointer-events: none;
        transition: .30s;
    }

    .input-box input:focus ~ label,
    .input-box input:valid ~ label {
        top: -9px;
        left: 10px;
        font-size: 11px;
        background: #e8f5f3;
        padding: 2px 6px;
        border-radius: 6px;
        font-weight: 600;
        color: #064e3b;
    }

    /* Buttons */
    .btn {
        width: 48%;
        padding: 12px;
        border-radius: 10px;
        border: none;
        font-weight: 600;
        font-size: 15px;
        cursor: pointer;
        margin-top: 22px;
        transition: .25s;
        color: white;
    }

    .save-btn {
        background: #2d6a4f;
    }
    .save-btn:hover {
        background: #1b4332;
        transform: translateY(-2px);
    }

    .cancel-btn {
        background: #6c757d;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        line-height: 40px;
    }
    .cancel-btn:hover {
        background: #4a5257;
        transform: translateY(-2px);
    }

</style>
</head>

<body>

<div class="edit-card">

    <div class="title">Edit Profile ✏️</div>

    <form action="update" method="post">

        <div class="input-box">
            <input type="text" name="full_name" value="<%= user.getFull_name() %>" required>
            <label>Full Name</label>
        </div>

        <div class="input-box">
            <input type="text" name="username" value="<%= user.getUsername() %>" required>
            <label>Username</label>
        </div>

        <div class="input-box">
            <input type="email" name="email" value="<%= user.getEmail() %>" required>
            <label>Email</label>
        </div>

        <div class="input-box">
            <input type="text" name="phone" value="<%= user.getPhone() %>" required>
            <label>Phone Number</label>
        </div>

        <select name="role" required>
            <option value="USER" <%= user.getRole().equals("USER") ? "selected" : "" %>>USER</option>
            <option value="ADMIN" <%= user.getRole().equals("ADMIN") ? "selected" : "" %>>ADMIN</option>
        </select>

        <button type="submit" class="btn save-btn">Save</button>
        <a href="ProfileServlet" class="btn cancel-btn">Cancel</a>

    </form>

</div>

</body>
</html>
