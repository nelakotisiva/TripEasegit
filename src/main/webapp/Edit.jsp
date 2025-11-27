<%@page import="dtopackage.com.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String message=(String)request.getAttribute("error");
if (message != null) {
%>
 <p > <%= message %>
        </p>
<%
    }
%>


<%
User user=(User) session.getAttribute("userObj");
%>
<form action="update" method="post">
 <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">

    Full Name:<br>
    <input type="text" name="full_name" value="<%= user.getFull_name() %>" ><br><br>

    Username:<br>
    <input type="text" name="username" value="<%= user.getUsername() %>" ><br><br>
	
    Email:<br>
    <input type="email" name="email" value="<%= user.getEmail() %>" ><br><br>

    Phone:<br>
    <input type="number" name="phone" value="<%= user.getPhone() %>" ><br><br>

	Role:<br>
    <input type="text" name="role" value="<%= user.getRole() %>" ><br><br>
    <input type="submit" value="Update Profile">
</form>
<a href="Dashboard.jsp"><button>back</button></a>
</body>
</html>