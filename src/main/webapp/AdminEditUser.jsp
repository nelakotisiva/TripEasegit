<%@ page import="dtopackage.com.User" %>
<%
    User u = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit User | TripEase Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body{
    background:#e8f0ff;
    font-family:Poppins;
}
.form-container {
    width: 450px;
    margin: 60px auto;
    background:#fff;
    padding: 25px;
    border-radius:14px;
    box-shadow:0 0 20px rgba(0,0,0,0.15);
}
input {
    width:95%;padding:10px;margin:8px 0;
    border-radius:8px;border:1px solid #013bff;
}
button {
    width:100%;padding:10px;
    background:#013bff;color:#fff;
    border:none;border-radius:8px;
    cursor:pointer;
}
button:hover { background:#01199b; }
a { text-decoration:none;color:#013bff;font-size:14px; }
</style>
</head>
<body>

<div class="form-container">
    <h2>Edit User</h2>

    <form action="ManageUsers" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="user_id" value="<%=u.getUser_id()%>">

        <input type="text" name="full_name" value="<%=u.getFull_name()%>" required>
        <input type="text" name="username" value="<%=u.getUsername()%>" required>
        <input type="email" name="email" value="<%=u.getEmail()%>" required>
        <input type="number" name="phone" value="<%=u.getPhone()%>" required>

        <!-- Role Input Field -->
        <input type="text" name="role" value="<%=u.getRole()%>" placeholder="Enter Role (ex: admin, user)" required>

        <button type="submit">Update User</button><br><br>
        <a href="ManageUsers">Back to Manage Users</a>
    </form>
</div>

</body>
</html>
