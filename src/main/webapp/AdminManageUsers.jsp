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
    padding: 30px;
}

/* Header */
.heading {
    font-size: 28px;
    font-weight: 700;
    color: #0032d8;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Search Bar */
.search-bar input {
    width: 260px;
    padding: 10px 14px;
    border-radius: 10px;
    border: 1.5px solid #013bff;
    background: rgba(255,255,255,0.8);
}

/* Add Button */
.add-btn {
    background: #013bff;
    color: white;
    padding: 10px 18px;
    border-radius: 10px;
    text-decoration: none;
    font-weight: 600;
    transition: 0.3s;
}
.add-btn:hover {
    background: #0026a2;
}

/* Table */
.table-box {
    background: rgba(255,255,255,0.75);
    padding: 20px;
    margin-top: 20px;
    border-radius: 15px;
    backdrop-filter: blur(10px);
    box-shadow: 0px 6px 18px rgba(0,0,0,0.15);
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
}

th {
    background: rgba(1,59,255,0.18);
    padding: 14px;
    font-weight: 600;
    color: #0032d8;
}

td {
    padding: 12px;
    background: rgba(255,255,255,0.65);
}

tr:hover td {
    background: rgba(1,59,255,0.12);
    transition: .25s;
}

/* Buttons */
.action-btn {
    padding: 6px 12px;
    font-size: 12px;
    border-radius: 8px;
    text-decoration: none;
    color: white;
    font-weight: 600;
    margin: 3px;
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
        <a href="ManageUsers?action=add" class="add-btn">Add User</a>
    </div>

    <div class="search-bar">
        <input type="text" id="searchInput"
               onkeyup="searchUsers()"
               placeholder="Search by Name">
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
                        <a href="ManageUsers?action=edit&id=<%=u.getUser_id()%>"
                           class="action-btn edit-btn">Edit</a>
                        <a href="ManageUsers?action=delete&id=<%=u.getUser_id()%>"
                           class="action-btn delete-btn"
                           onclick="return confirm('Are you sure?');">
                           Delete
                        </a>
                    </td>
                </tr>
            <% } } %>
            </tbody>

        </table>
    </div>
</div>

</body>
</html>
