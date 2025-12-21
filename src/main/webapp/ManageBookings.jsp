<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Booking" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
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

.container{max-width:1200px;margin:auto}

/* HEADER */
.header{
    background:#fff;
    padding:22px 26px;
    border-radius:16px;
    border:1px solid #d9d2c3;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.header h1{margin:0;font-size:26px}

/* BUTTON */
.btn{
    padding:10px 18px;
    border-radius:10px;
    background:#6b6256;
    color:white;
    text-decoration:none;
    font-weight:600;
}

/* SEARCH */
.search-bar input{
    padding:12px 14px;
    border-radius:10px;
    border:1px solid #d9d2c3;
    width:260px;
    margin-bottom:18px;
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
}
td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
}

tr:hover td{background:#faf9f6}

/* STATUS */
.status.PENDING{color:#b88600;font-weight:600}
.status.CONFIRMED{color:#1f7a36;font-weight:600}
.status.CANCELLED{color:#a11725;font-weight:600}

/* ACTIONS */
.action-btn{
    padding:6px 14px;
    border-radius:8px;
    text-decoration:none;
    color:white;
    font-size:13px;
    font-weight:600;
}
.edit{background:#8a9a5b}
.delete{background:#b94a48}
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Manage Bookings</h1>
        <a href="AdminDashboard.jsp" class="btn">Back to Dashboard</a>
    </div>

    <form class="search-bar" action="ManageBookings" method="get">
        <input type="text" name="search"
               placeholder="Search by Booking ID or User ID"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    </form>

    <div class="table-box">
        <table>
            <tr>
                <th>Booking ID</th>
                <th>User ID</th>
                <th>Destination</th>
                <th>Booking Date</th>
                <th>Travel Date</th>
                <th>Status</th>
                <th>People</th>
                <th>Actions</th>
            </tr>

            <% if (bookings != null && !bookings.isEmpty()) {
                for (Booking b : bookings) { %>
            <tr>
                <td><%= b.getBookingId() %></td>
                <td><%= b.getUserId() %></td>
                <td><%= b.getDestinationId() %></td>
                <td><%= b.getBookingDate() %></td>
                <td><%= b.getTravelDate() %></td>
                <td class="status <%= b.getStatus() %>"><%= b.getStatus() %></td>
                <td><%= b.getNumOfPeople() %></td>
                <td>
                    <a class="action-btn edit"
                       href="EditBooking?bookingId=<%= b.getBookingId() %>">Edit</a>

                    <a class="action-btn delete"
                       href="DeleteBooking?bookingId=<%= b.getBookingId() %>"
                       onclick="return confirm('Delete this booking?')">Delete</a>
                </td>
            </tr>
            <% }} else { %>
            <tr><td colspan="8">No bookings found.</td></tr>
            <% } %>
        </table>
    </div>

</div>

</body>
</html>
