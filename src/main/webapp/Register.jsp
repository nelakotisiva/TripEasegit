<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Register</title>

<style>

    /* ------- Soft Mint Background ------- */
    body {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        min-height: 100vh;
        background: #e8f5f3;   /* Soft Mint Grey */
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* ------- Clean Card ------- */
    .register-box {
        width: 360px;
        padding: 25px 22px;
        background: #ffffff;     /* Solid white for clarity */
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.10);
        animation: emerge 0.5s ease-in-out;
    }

    @keyframes emerge {
        from { opacity: 0; transform: translateY(15px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .title {
        text-align: center;
        font-size: 24px;
        font-weight: 700;
        color: #1f3a3d;  /* Dark Teal */
        margin-bottom: 15px;
    }

    /* ------- Inputs & Dropdown ------- */
    input, select {
        width: 100%;
        padding: 12px;
        margin: 8px 0;
        border: 1px solid #b8d4cf;
        font-size: 14px;
        border-radius: 8px;
        background: #f8fbfa;
        transition: 0.2s;
    }

    input:focus, select:focus {
        background: #ffffff;
        border-color: #3ba58b;     /* Mint Green */
        box-shadow: 0 0 8px rgba(59,165,139,0.3);
        outline: none;
    }

    /* ------- Buttons ------- */
    .btn {
        width: 100%;
        padding: 12px;
        border-radius: 10px;
        border: none;
        margin-top: 10px;
        font-size: 15px;
        color: white;
        font-weight: bold;
        cursor: pointer;
    }

    .register-btn {
        background: #3ba58b;    /* Mint Green */
    }
    .register-btn:hover {
        background: #2f8a74;
    }

    .cancel-btn {
        background: #6c757d;   /* Soft Grey */
    }
    .cancel-btn:hover {
        background: #5a6268;
    }

    p {
        color: #1f3a3d;
        text-align: center;
        font-size: 13px;
        margin-top: 12px;
    }

    a {
        color: #2f8a74;
        font-weight: bold;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

</style>

</head>

<body>

<div class="register-box">

    <div class="title">TripEase – Create Account</div>

    <form action="RegisterServlet" method="post">

        <input type="text" name="userid" placeholder="User ID" required>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirmpassword" placeholder="Confirm Password" required>
        <input type="text" name="fullname" placeholder="Full Name" required>
        <input type="text" name="phone" placeholder="Phone Number" required>

        <select name="role" required>
            <option value="" disabled selected>Select Role</option>
            <option>User</option>
            <option>Admin</option>
        </select>

        <button class="btn register-btn">Register</button>
        <button type="reset" class="btn cancel-btn">Cancel</button>

    </form>

    <p>Already have an account? <a href="Login.jsp">Login</a></p>

</div>

</body>
</html>
