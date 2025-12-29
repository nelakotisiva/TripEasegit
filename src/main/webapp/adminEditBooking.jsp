<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dtopackage.com.Booking" %>
<%@ page import="dtopackage.com.Admin" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    Admin admin = (Admin) adminObj;
    Booking booking = (Booking) request.getAttribute("booking");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | Edit Booking</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    padding:40px;
}
.card{
    max-width:500px;
    margin:auto;
    background:#fff;
    padding:28px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}
h2{margin-top:0}
label{display:block;margin-top:16px;font-weight:600}
input, select{
    width:100%;
    padding:10px;
    border-radius:8px;
    border:1px solid #d9d2c3;
    margin-top:6px;
}
.actions{
    margin-top:24px;
    display:flex;
    gap:12px;
}
.btn{
    padding:10px 18px;
    border-radius:10px;
    font-weight:600;
    border:none;
}
.save{background:#8a9a5b;color:white}
.cancel{background:#b94a48;color:white;text-decoration:none;text-align:center}
</style>
</head>

<body>

<div class="card">
    <h2>Edit Booking</h2>

    <p><strong>Admin:</strong> <%= admin.getUsername() %></p>

    <form action="EditBooking" method="post">

        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

        <label>Booking ID</label>
        <input type="text" value="<%= booking.getBookingId() %>" disabled>

        <label>Status</label>
        <select name="status">
            <option value="Confirmed"
                <%= "Confirmed".equalsIgnoreCase(booking.getStatus()) ? "selected" : "" %>>
                Confirmed
            </option>
            <option value="Cancelled"
                <%= "Cancelled".equalsIgnoreCase(booking.getStatus()) ? "selected" : "" %>>
                Cancelled
            </option>
        </select>

        <label>Number of People</label>
        <input type="number" name="numPeople"
               value="<%= booking.getNumOfPeople() %>" min="1">

        <div class="actions">
            <button type="submit" class="btn save">Save</button>
            <a href="AdminManageBookings" class="btn cancel">Cancel</a>
        </div>

    </form>
</div>

</body>
</html>
