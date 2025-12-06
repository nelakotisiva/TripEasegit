<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.User" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Users | TripEase Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #d7e3fc, #dfe7fd 50%, #c6d4ff);
}

.main {
    padding: 25px 40px;
}

/* Header */
.heading {
    font-size: 26px;
    font-weight: 700;
    color: #0032d8;
    margin-bottom: 18px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Buttons */
.back-btn, .add-btn {
    padding: 6px 14px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 500;
    font-size: 13px;
    display: inline-block;
    transition: 0.25s;
}

.back-btn {
    background: #ff9300;
    color: white;
    margin-right: 6px;
}
.back-btn:hover {
    background: #d97700;
}

.add-btn {
    background: #0051ff;
    color: white;
}
.add-btn:hover {
    background: #0039b8;
}

/* Search Bar */
.search-bar input {
    width: 230px;
    padding: 8px 12px;
    border-radius: 7px;
    border: 1.5px solid #013bff;
    background: rgba(255,255,255,0.9);
    font-size: 13px;
}

/* Table */
.table-box {
    background: rgba(255,255,255,0.7);
    padding: 16px;
    margin-top: 18px;
    border-radius: 12px;
    backdrop-filter: blur(10px);
    box-shadow: 0px 4px 14px rgba(0,0,0,0.15);
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}

th {
    background: rgba(1,59,255,0.18);
    padding: 12px;
    font-weight: 600;
    color: #0032d8;
}

td {
    padding: 10px;
    background: rgba(255,255,255,0.65);
    font-size: 13px;
}

tr:hover td {
    background: rgba(1,59,255,0.12);
    transition: .25s;
}

/* Action Buttons */
.action-btn {
    padding: 4px 10px;
    font-size: 11px;
    border-radius: 6px;
    text-decoration: none;
    color: white;
    font-weight: 600;
    margin: 2px;
    display: inline-block;
}

.edit-btn { background: #007bff; }
.delete-btn { background: #ff2e2e; }

.action-btn:hover {
    opacity: .85;
}
</style>

<script>
function searchUsers() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toUpperCase();
    let rows = document.querySelectorAll("tbody tr");

    rows.forEach(row => {
        let name = row.cells[1].innerText.toUpperCase();
        row.style.display = name.includes(filter) ? "" : "none";
    });
}
</script>

</head>

<body>

<div class="main">

    <div class="heading">
        Manage Users
        <div>
            <a href="AdminDashboard.jsp" class="back-btn">Back</a>
            <a href="ManageUsers?action=add" class="add-btn">Add User</a>
        </div>
    </div>

    <div class="search-bar">
        <input type="text" id="searchInput" onkeyup="searchUsers()" placeholder="Search by Name">
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>
            <%
                if (users != null) {
                    for (User u : users) {
            %>
                <tr>
                    <td><%=u.getUser_id()%></td>
                    <td><%=u.getFull_name()%></td>
                    <td><%=u.getUsername()%></td>
                    <td><%=u.getEmail()%></td>
                    <td><%=u.getPhone()%></td>
                    <td><%=u.getRole()%></td>
                    <td>
                        <a href="ManageUsers?action=edit&id=<%=u.getUser_id()%>" class="action-btn edit-btn">Edit</a>
                        <a href="ManageUsers?action=delete&id=<%=u.getUser_id()%>"
                           class="action-btn delete-btn"
                           onclick="return confirm('Are you sure?');">Delete</a>
                    </td>
                </tr>
            <% 
                    }
                }
            %>
            </tbody>

        </table>
    </div>

</div>

</body>
</html>
