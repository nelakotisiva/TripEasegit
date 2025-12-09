<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Register</title>

<style>

    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', sans-serif;

        /* 🌄 Realistic Background */
        background: url('https://chatgpt.com/backend-api/estuary/content?id=file_0000000018707207a9b51e0f7bc3572b&ts=490072&p=fs&cid=1&sig=7e9306902bc774173591cefb71f72d392d0241dc90d27e5e9e732e62fe6491e4&v=0')
                    no-repeat center center/cover;

        height: 100vh;
        width: 100vw;

        display: flex;
        justify-content: center;
        align-items: center;

        backdrop-filter: blur(5px);
    }

    /* 🔥 Smaller Responsive Form Card */
    .card {
        width: 300px;
        background: rgba(255, 255, 255, 0.92);
        padding: 18px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0px 8px 25px rgba(0,0,0,0.25);
        animation: fadeIn 0.6s ease;
        border-top: 4px solid #8e2de2;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .brand {
        font-size: 26px;
        font-weight: bold;
        color: #8e2de2;
        margin-bottom: 5px;
    }

    .sub {
        font-size: 12px;
        color: gray;
        margin-bottom: 12px;
    }

    .input-box {
        width: 90%;
        padding: 10px;
        margin: 6px 0;
        border-radius: 6px;
        border: 2px solid #ddd;
        font-size: 14px;
    }

    .input-box:focus {
        border-color: #8e2de2;
        box-shadow: 0 0 4px rgba(142,45,226,0.3);
        outline: none;
    }

    .btn {
        width: 92%;
        padding: 10px;
        font-size: 15px;
        margin-top: 10px;
        border-radius: 7px;
        background: #8e2de2;
        color: white;
        border: none;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn:hover {
        background: #4a00e0;
    }

    .cancel-btn {
        background: #ff4d6d;
    }

    .cancel-btn:hover {
        background: #d72642;
    }

    a {
        margin-top: 10px;
        font-size: 12px;
        display: block;
        color: #8e2de2;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    /* 📱 Mobile Responsive */
    @media (max-width: 450px) {
        .card {
            width: 85%;
            padding: 14px;
        }

        .brand {
            font-size: 22px;
        }
    }

</style>
</head>

<body>

<div class="card">

    <div class="brand">TripEase</div>
    <div class="sub">Create your travel account ✈️</div>

    <form action="Register" method="post">

        <input type="number" name="User_id" class="input-box" placeholder="User ID" required>
        <input type="text" name="Username" class="input-box" placeholder="Username" required>
        <input type="email" name="email" class="input-box" placeholder="Email Address" required>
        <input type="password" name="password" class="input-box" placeholder="Password" required>
        <input type="password" name="Confirm_password" class="input-box" placeholder="Confirm Password" required>
        <input type="text" name="full_name" class="input-box" placeholder="Full Name" required>
        <input type="text" name="phone" class="input-box" placeholder="Phone Number" required>
        <input type="text" name="role" class="input-box" placeholder="Role (User/Admin)" required>

        <button class="btn" type="submit">Register</button>
        <button class="btn cancel-btn" type="reset">Cancel</button>

        <a href="Login.jsp">Already have an account? Login</a>
    </form>
</div>

</body>
</html>