<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Add User | TripEase Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:#f5f2ec;
    font-family:Inter;
}

.form-container{
    width:420px;
    margin:60px auto;
    background:#fff;
    padding:25px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:16px;
}

.back-btn{
    padding:6px 14px;
    border-radius:8px;
    background:#6b6256;
    color:white;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}

input,select{
    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:10px;
    border:1px solid #d9d2c3;
}

button{
    width:100%;
    padding:12px;
    background:#8a9a5b;
    color:#fff;
    border:none;
    border-radius:10px;
    font-weight:600;
}
</style>
</head>

<body>

<div class="form-container">

    <!-- HEADER -->
    <div class="header">
        <h2>Add New User</h2>
        <a href="ManageUsers" class="back-btn">Back</a>
    </div>

    <form action="ManageUsers" method="post">
        <input type="hidden" name="action" value="insert">

        <input name="full_name" placeholder="Full Name" required>
        <input name="username" placeholder="Username" required>
        <input name="email" placeholder="Email" required>
        <input name="password" placeholder="Password" required>
        <input name="phone" placeholder="Phone" required>

        <select name="role" required>
            <option value="">Select Role</option>
            <option value="admin">Admin</option>
            <option value="user">User</option>
        </select>

        <button>Add User</button>
    </form>

</div>

</body>
</html>
