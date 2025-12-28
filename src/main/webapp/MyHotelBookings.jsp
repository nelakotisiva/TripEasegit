<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dtopackage.com.Bookingg" %>
<%@ page import="dtopackage.com.User" %>

<%
    User user = (User) session.getAttribute("userObj");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Bookingg> bookings =
            (List<Bookingg>) request.getAttribute("hotelBookings");

    if (bookings == null) {
        response.sendRedirect("MyHotelBookings");
        return;
    }

    SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Hotel Bookings | TripEase</title>

<style>
*{box-sizing:border-box}

body{
    margin:0;
    padding:20px;
    font-family:Poppins, sans-serif;
    background:#e8f5f3;
}

.container{
    max-width:900px;
    margin:auto;
}

/* HEADER */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

.back-btn{
    background:#3ba58b;
    color:white;
    padding:10px 16px;
    text-decoration:none;
    border-radius:8px;
    font-weight:600;
}

.title{
    font-size:22px;
    font-weight:700;
    color:#1f3a3d;
}

/* CARD */
.card{
    background:#ffffff;
    padding:18px;
    border-radius:14px;
    margin-bottom:16px;
    box-shadow:0 6px 20px rgba(0,0,0,0.08);
}

.card h3{
    margin:0 0 6px;
    color:#1f3a3d;
}

.info{
    margin:4px 0;
    color:#1f3a3d;
    font-size:14px;
}

/* STATUS */
.status{
    font-weight:700;
    margin-top:6px;
}

.confirmed{
    color:#2e7d32;
}

.cancelled{
    color:#d32f2f;
}

/* PRICE */
.price{
    font-weight:800;
    margin-top:10px;
    color:green;
}

/* EMPTY */
.empty{
    background:#ffffff;
    padding:30px;
    border-radius:14px;
    text-align:center;
    color:#555;
}
</style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
        <div class="title">🏨 My Hotel Bookings</div>
    </div>

    <% if (bookings.isEmpty()) { %>

        <div class="empty">
            You have no hotel bookings yet.
        </div>

    <% } else {
        for (Bookingg b : bookings) {
    %>

    <div class="card">

        <h3><%= b.getHotelName() %></h3>

        <div class="info">📍 <%= b.getHotelLocation() %></div>
        <div class="info">📅 Check-in: <%= b.getCheckin() %></div>
        <div class="info">📅 Check-out: <%= b.getCheckout() %></div>
        <div class="info">👥 Guests: <%= b.getGuests() %></div>

        <div class="info">
            🕒 Booked on:
            <%= b.getBookingDate() != null
                    ? df.format(b.getBookingDate())
                    : "N/A" %>
        </div>

        <div class="status">
            Status:
            <% if ("Cancelled".equalsIgnoreCase(b.getStatus())) { %>
                <span class="cancelled">❌ Cancelled</span>
            <% } else { %>
                <span class="confirmed">✅ <%= b.getStatus() %></span>
            <% } %>
        </div>

        <div class="price">
            ₹ <%= b.getTotalAmount() %>
        </div>

    </div>

    <% } } %>

</div>

</body>
</html>
