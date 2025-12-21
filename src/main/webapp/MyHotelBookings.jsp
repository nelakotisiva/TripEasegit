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

    // 🔥 FIX: Prevent direct JSP access
    if (bookings == null) {
        response.sendRedirect("MyHotelBookings");
        return;
    }

    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Hotel Bookings</title>

<style>
body {
    margin: 0;
    padding: 20px;
    font-family: "Poppins", sans-serif;
    background: #e8f5f3;
}
.wrap {
    max-width: 920px;
    margin: auto;
}
.head {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}
.back-btn {
    background: #1f3a3d;
    color: white;
    padding: 8px 14px;
    text-decoration: none;
    border-radius: 8px;
}
.card {
    background: white;
    padding: 16px;
    border-radius: 12px;
    margin-bottom: 12px;
}
.price {
    font-weight: bold;
    color: green;
}
.empty {
    background: white;
    padding: 40px;
    text-align: center;
    border-radius: 12px;
}
</style>
</head>

<body>

<div class="wrap">

<div class="head">
    <h2>My Hotel Bookings</h2>
    <div>
        <a href="Dashboard.jsp" class="back-btn">← Dashboard</a>
        Welcome, <b><%= user.getFull_name() %></b>
    </div>
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
    📍 <%= b.getHotelLocation() %><br><br>
    Check-in: <%= b.getCheckin() %><br>
    Check-out: <%= b.getCheckout() %><br>
    Guests: <%= b.getGuests() %><br>
    Booked on: <%= df.format(b.getBookingDate()) %><br><br>
    <div class="price">₹ <%= b.getTotalAmount() %></div>
</div>

<% } } %>

</div>

</body>
</html>
