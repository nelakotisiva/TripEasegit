<%@ page import="java.util.*, dtopackage.com.User" %>
<%
if(session.getAttribute("adminObj")==null){
    response.sendRedirect("Adminlogin.jsp"); 
    return;
}
List<User> users=(List<User>)request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Users</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter;
    background:#f5f2ec;
}

.container{
    padding:30px;
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

.card{
    background:#fff;
    padding:20px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}

table{
    width:100%;
    border-collapse:collapse;
}

th,td{
    padding:12px;
    border-bottom:1px solid #eee;
}

th{
    background:#f1efe8;
}

.action{
    padding:6px 10px;
    border-radius:6px;
    color:#fff;
    text-decoration:none;
    font-size:13px;
}

.edit{ background:#8a9a5b; }
.del{ background:#b94a48; }
</style>
</head>

<body>

<div class="container">

    <!-- HEADER WITH BACK BUTTON -->
    <div class="header">
        <h2>Manage Users</h2>
        <a href="AdminDashboard.jsp" class="back-btn">Back</a>
    </div>

    <div class="card">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>

            <% for(User u:users){ %>
            <tr>
                <td><%=u.getUser_id()%></td>
                <td><%=u.getFull_name()%></td>
                <td><%=u.getEmail()%></td>
                <td><%=u.getRole()%></td>
                <td>
                    <a class="action edit"
                       href="ManageUsers?action=edit&id=<%=u.getUser_id()%>">Edit</a>

                    <a class="action del"
                       href="ManageUsers?action=delete&id=<%=u.getUser_id()%>"
                       onclick="return confirm('Delete this user?')">Delete</a>
                </td>
            </tr>
            <% } %>

        </table>
    </div>

</div>

</body>
</html>
