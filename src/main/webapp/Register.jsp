<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="Register" method="post">
    <h1>Register Form</h1>

    <input type="number" name="User_id" placeholder="Enter User ID"><br>

    <input type="text" name="Username" placeholder="Enter Username"><br>

    <input type="email" name="email" placeholder="Enter Email"><br>

    <input type="password" name="password" placeholder="Enter Password"><br>

    <input type="password" name="Confirm_password" placeholder="Re-enter Password"><br>

    <input type="text" name="full_name" placeholder="Enter Full Name"><br>

    <input type="text" name="phone" placeholder="Enter Phone"><br>  
    <!-- FIXED: text instead of number -->

    <input type="text" name="role" placeholder="Enter Role"><br>

    <button type="submit">Register</button><br>
    <button type="reset">Cancel</button><br>

    <a href="Login.jsp">Already have an Account?</a>
</form>

</body>
</html>