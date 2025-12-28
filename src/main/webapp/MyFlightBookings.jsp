<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="dtopackage.com.Flight" %>
<%@ page import="dtopackage.com.User" %>

<%
User user = (User) session.getAttribute("userObj");
if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
}

List<Flight> bookings =
    (List<Flight>) request.getAttribute("flightBookings");

if(bookings == null) bookings = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Flight Bookings</title>

<style>
body{
    font-family:Poppins, sans-serif;
    background:#e8f5f3;
    padding:20px;
}

h2{color:#1f3a3d;margin-bottom:20px;}

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

.card p{margin:6px 0;color:#1f3a3d;}
.price{font-weight:700;}
</style>
</head>

<body>

<a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
<h2>✈ My Flight Bookings</h2>

<% if(bookings.isEmpty()){ %>
<p>No flight bookings found.</p>
<% } else {
   for(Flight f : bookings){ %>

<div class="card">
    <p><b>Airline:</b> <%= f.getAirline() %></p>
    <p><b>Route:</b> <%= f.getSource() %> → <%= f.getDestination() %></p>
    <p><b>Status:</b> <%= f.getStatus() %></p>
    <div class="price">₹ <%= f.getPrice() %></div>
</div>

<% } } %>

</body>
</html>
