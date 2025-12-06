<!DOCTYPE html>
<html>
<head>
<title>Admin Login | TripEase</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body {
    display:flex; justify-content:center; align-items:center;
    height:100vh; background:#f0f4ff; font-family:Poppins;
}
.box {
    background:#fff; padding:25px; border-radius:12px;
    width:320px; text-align:center; box-shadow:0 4px 12px rgba(0,0,0,.2);
}
input { width:90%; padding:10px; margin:10px 0; border-radius:8px; border:1px solid #013bff;}
button {
    width:90%; padding:10px; background:#013bff; border:none; border-radius:8px;
    color:#fff; font-size:15px; cursor:pointer;
}
button:hover{ background:#021b99; }
.msg{ color:red; }
</style>
</head>

<body>

<div class="box">
    <h2>Admin Login</h2>

    <form action="AdminServlet" method="post">
        <input type="text" name="username" placeholder="Enter Username" required>
        <input type="password" name="password" placeholder="Enter Password" required>
        <button type="submit">Login</button>
    </form>

    
</div>

</body>
</html>
