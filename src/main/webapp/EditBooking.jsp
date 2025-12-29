<%@ page import="dtopackage.com.Booking" %>

<%
    Booking booking = (Booking) request.getAttribute("booking");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Booking | TripEase Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    margin:0;
    padding:40px;
    color:#2f2a23;
}

.container{
    width:450px;
    margin:auto;
    background:#ffffff;
    padding:26px 28px;
    border-radius:18px;
    border:1px solid #d9d2c3;
}

/* HEADER */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:18px;
}

.header h2{
    margin:0;
    font-size:22px;
    font-weight:600;
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

/* FORM */
label{
    font-size:13px;
    font-weight:500;
    display:block;
    margin-top:14px;
}

input, select{
    width:100%;
    padding:11px 12px;
    border-radius:10px;
    border:1px solid #d9d2c3;
    font-size:14px;
    margin-top:6px;
}

input:focus, select:focus{
    outline:none;
    border-color:#8a9a5b;
}

/* BUTTON */
button{
    width:100%;
    padding:12px;
    margin-top:22px;
    border:none;
    background:#8a9a5b;
    color:white;
    border-radius:12px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
}

button:hover{
    background:#7b8b50;
}
</style>

</head>
<body>

<div class="container">

    <!-- HEADER WITH BACK BUTTON -->
    <div class="header">
        <h2>Edit Booking</h2>
        <a href="AdminManageBookings" class="back-btn">Back</a>
    </div>

    <form action="EditBooking" method="post">

        <input type="hidden" name="bookingId"
               value="<%= booking.getBookingId() %>">

        <label>Status</label>
        <select name="status">
            <option <%= booking.getStatus().equals("PENDING") ? "selected" : "" %>>PENDING</option>
            <option <%= booking.getStatus().equals("CONFIRMED") ? "selected" : "" %>>CONFIRMED</option>
            <option <%= booking.getStatus().equals("CANCELLED") ? "selected" : "" %>>CANCELLED</option>
        </select>

        <label>No. of People</label>
        <input type="number" name="numPeople"
               value="<%= booking.getNumOfPeople() %>" required>

        <button type="submit">Update Booking</button>

    </form>

</div>

</body>
</html>
