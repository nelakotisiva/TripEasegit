<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.AdminBookingDTO" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<AdminBookingDTO> bookings =
        (List<AdminBookingDTO>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | Manage Bookings</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    padding:30px;
    color:#2f2a23;
}

.container{max-width:1300px;margin:auto}

.header{
    background:#fff;
    padding:22px 26px;
    border-radius:16px;
    border:1px solid #d9d2c3;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.btn{
    padding:10px 18px;
    border-radius:10px;
    background:#6b6256;
    color:white;
    text-decoration:none;
    font-weight:600;
}

/* TABLE */
.table-box{
    background:#fff;
    padding:22px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}

table{width:100%;border-collapse:collapse}

th{
    background:#f1efe8;
    padding:14px;
    text-align:center;
    font-size:13px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
    font-size:13px;
}

tr:hover td{background:#faf9f6}

/* SERVICE BADGES */
.badge{
    padding:6px 12px;
    border-radius:14px;
    font-size:12px;
    font-weight:600;
}
.HOTEL{background:#e3efe6;color:#1f7a36}
.CAB{background:#fff2d9;color:#9a6b00}
.FLIGHT{background:#e8f0fe;color:#1a4fb4}
.RESTAURANT{background:#fdecec;color:#a11725}

/* STATUS */
.status.CONFIRMED{color:#1f7a36;font-weight:600}
.status.CANCELLED{color:#a11725;font-weight:600}

/* ACTION BUTTONS */
.action-btn{
    padding:6px 14px;
    border-radius:8px;
    text-decoration:none;
    color:white;
    font-size:12px;
    font-weight:600;
    margin:0 4px;
}
.edit{background:#8a9a5b}
.delete{background:#b94a48}
</style>
</head>

<body>

<div class="container">

<!-- HEADER -->
<div class="header">
    <h1>Manage All Bookings</h1>
    <a href="AdminDashboard.jsp" class="btn">Back</a>
</div>

<!-- TABLE -->
<div class="table-box">
<table>
<tr>
    <th>Booking ID</th>
    <th>User ID</th>
    <th>User Name</th>
    <th>Service</th>
    <th>Booking Date</th>
    <th>People</th>
    <th>Status</th>
    <th>Actions</th>
</tr>

<% if (bookings != null && !bookings.isEmpty()) {
   for (AdminBookingDTO b : bookings) { %>

<tr>
    <td><%= b.getBookingId() %></td>
    <td><%= b.getUserId() %></td>
<td><%= b.getUserName() %></td>
    <td>
        <span class="badge <%= b.getServiceType() %>">
            <%= b.getServiceType() %>
        </span>
    </td>

    <td><%= b.getBookingDate() %></td>
    <td><%= b.getPeople() %></td>

    <td class="status <%= b.getStatus().toUpperCase() %>">
        <%= b.getStatus() %>
    </td>

    <td>
        <!-- EDIT -->
        <a class="action-btn edit"
           href="EditBooking?bookingId=<%= b.getBookingId() %>">
           Edit
        </a>

        <!-- DELETE -->
        <a class="action-btn delete"
           href="DeleteBooking?bookingId=<%= b.getBookingId() %>&service=<%= b.getServiceType() %>"
           onclick="return confirm('Delete this booking?')">
           Delete
        </a>
    </td>
</tr>

<% }} else { %>
<tr>
    <td colspan="10">No bookings found</td>
</tr>
<% } %>

</table>
</div>

</div>

</body>
</html>
