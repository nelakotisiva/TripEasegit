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
</style>
</head>

<body>

<h2>My Hotel Bookings</h2>

<% if (bookings.isEmpty()) { %>
    <p>You have no hotel bookings yet.</p>
<% } else {
   for (Bookingg b : bookings) {
%>

<div class="card">
    <h3><%= b.getHotelName() %></h3>
    📍 <%= b.getHotelLocation() %><br>
    Check-in: <%= b.getCheckin() %><br>
    Check-out: <%= b.getCheckout() %><br>
    Guests: <%= b.getGuests() %><br>
    Booked on: <%= df.format(b.getBookingDate()) %><br>
    <div class="price">₹ <%= b.getTotalAmount() %></div>
</div>

<% } } %>

</body>
</html>
