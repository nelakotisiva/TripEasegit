<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dtopackage.com.RestaurantBooking" %>

<!DOCTYPE html>
<html>
<head>
<title>My Restaurant Bookings | TripEase</title>

<style>
body{
    font-family:Poppins, sans-serif;
    background:#e8f5f3;
    padding:20px;
}

h2{
    color:#1f3a3d;
    margin-bottom:20px;
}

.back-btn{
    background:#3ba58b;
    color:white;
    padding:10px 16px;
    text-decoration:none;
    border-radius:8px;
    font-weight:600;
    display:inline-block;
    margin-bottom:20px;
}

.card{
    background:#ffffff;
    padding:18px;
    border-radius:14px;
    margin-bottom:18px;
    box-shadow:0 6px 20px rgba(0,0,0,0.08);
}

.card p{
    margin:6px 0;
    color:#1f3a3d;
}

.status{
    font-weight:600;
    color:#328a74;
}
</style>
</head>

<body>

<a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

<h2>📖 My Restaurant Bookings</h2>

<%
List<RestaurantBooking> list =
    (List<RestaurantBooking>) request.getAttribute("bookings");

SimpleDateFormat sdf =
    new SimpleDateFormat("dd MMM yyyy"); // DATE ONLY

if (list != null && !list.isEmpty()) {
    for (RestaurantBooking rb : list) {
%>

<div class="card">
    <p><b>Booking ID:</b> <%= rb.getBookingId() %></p>
    <p><b>Restaurant:</b> <%= rb.getRestaurantName() %></p>
    <p><b>Location:</b> <%= rb.getLocation() %></p>

    <p><b>Booking Date:</b>
        <%= rb.getBookingDate1() != null
                ? sdf.format(rb.getBookingDate1())
                : "N/A" %>
    </p>

    <p><b>People:</b> <%= rb.getNumPeople() %></p>
    <p><b>Status:</b>
        <span class="status"><%= rb.getStatus() %></span>
    </p>
</div>

<%
    }
} else {
%>
<p>No restaurant bookings found.</p>
<%
}
%>

</body>
</html>
