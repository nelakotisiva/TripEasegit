<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Login</title>

<style>

    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;

        /* 🌄 TripEase Realistic Background */
        background: url('https://chatgpt.com/backend-api/estuary/content?id=file_0000000018707207a9b51e0f7bc3572b&ts=490072&p=fs&cid=1&sig=7e9306902bc774173591cefb71f72d392d0241dc90d27e5e9e732e62fe6491e4&v=0') no-repeat center center/cover;

        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;

        backdrop-filter: blur(3px); /* Soft blur to highlight card */
    }

    .container {
        width: 360px;
        background: rgba(255,255,255,0.95);
        padding: 30px;
        border-radius: 15px;
        text-align: center;
        box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        animation: slideDown 0.6s ease;
    }

    @keyframes slideDown {
        from { opacity: 0; transform: translateY(-15px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h1 {
        color: #0d6efd;
        margin-bottom: 20px;
        font-size: 28px;
        font-weight: bold;
    }

    .input-field {
        width: 90%;
        padding: 12px;
        margin: 10px 0;
        border-radius: 8px;
        border: 2px solid #ddd;
        font-size: 15px;
        transition: 0.2s;
    }

    .input-field:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 5px rgba(13,110,253,0.3);
        outline: none;
    }

    .btn {
        width: 94%;
        padding: 12px;
        margin-top: 15px;
        border: none;
        border-radius: 8px;
        font-size: 17px;
        cursor: pointer;
        background: #0d6efd;
        color: white;
        transition: 0.3s;
    }

    .btn:hover {
        background: #004ab9;
    }

    .cancel-btn {
        background: #e63946;
        margin-top: 10px;
    }

    .cancel-btn:hover {
        background: #b81e28;
    }

    a {
        text-decoration: none;
        color: #0d6efd;
        font-size: 15px;
        display: block;
        margin-top: 15px;
    }

    a:hover {
        text-decoration: underline;
    }

</style>
</head>

<body>

<div class="container">
    <h1>Login</h1>

    <form action="Login" method="post">

        <input type="text" class="input-field" name="username" placeholder="Enter Username" required>

        <input type="password" class="input-field" name="password" placeholder="Enter Password" required>

        <button type="submit" class="btn">Login</button>

        <button type="reset" class="btn cancel-btn">Cancel</button>

        <a href="Register.jsp">Don't have an account? Register</a>
    </form>
</div>

</body>
</html>
