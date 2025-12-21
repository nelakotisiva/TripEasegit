<!DOCTYPE html>
<html>
<head>
<title>Admin Login | TripEase</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:#f5f2ec;
    font-family:Inter;
}
.box{
    background:#fff;
    padding:30px;
    width:320px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}
input{
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
    color:white;
    border:none;
    border-radius:10px;
    font-weight:600;
}
</style>
</head>

<body>
<div class="box">
<h2>Admin Login</h2>

<form action="AdminServlet" method="post">
    <input name="username" placeholder="Enter Username" required>
    <input type="password" name="password" placeholder="Enter Password" required>
    <button type="submit">Login</button>
</form>
</div>
</body>
</html>
