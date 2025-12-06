<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Login</title>

<style>

    /* ----- Soft Mint Background ----- */
    body {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background: #e8f5f3;   /* Soft Mint */
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* ----- Modern Card ----- */
    .login-box {
        width: 340px;
        background: white;
        padding: 28px;
        border-radius: 14px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        animation: fadeIn 0.4s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* ----- Title ----- */
    .title {
        font-size: 26px;
        font-weight: 700;
        color: #1f3a3d;   /* Dark Teal */
        text-align: center;
        margin-bottom: 20px;
    }

    /* ----- Input ----- */
    input {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #b8d4cf;
        border-radius: 8px;
        font-size: 14px;
        background: #f8fbfa;
        transition: 0.2s;
    }

    input:focus {
        border-color: #3ba58b;      /* Mint Green */
        box-shadow: 0 0 8px rgba(59,165,139,0.3);
        outline: none;
        background: #ffffff;
    }

    /* ----- Buttons ----- */
    .btn {
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 8px;
        margin-top: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        color: #fff;
        transition: 0.25s;
    }

    .login-btn {
        background: #3ba58b;      /* Mint Green */
    }

    .login-btn:hover {
        background: #328a74;
    }

    .cancel-btn {
        background: #6c757d;      /* Soft Grey */
    }

    .cancel-btn:hover {
        background: #5a6268;
    }

    /* ----- Register Link ----- */
    .reg-link {
        text-align: center;
        margin-top: 14px;
        font-size: 14px;
        color: #1f3a3d;
    }

    .reg-link a {
        color: #328a74;
        text-decoration: none;
        font-weight: 600;
    }

    .reg-link a:hover {
        text-decoration: underline;
    }

</style>

</head>

<body>

    <div class="login-box">

        <div class="title">TripEase Login</div>

        <form action="Login" method="post">

            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>

            <button type="submit" class="btn login-btn">Login</button>
            <button type="reset" class="btn cancel-btn">Cancel</button>

            <div class="reg-link">
                New here? <a href="Register.jsp">Create an account</a>
            </div>

        </form>

    </div>

</body>
</html>
