<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>




<%@ page import="java.util.List" %>

<%@ page import="dtopackage.com.User" %>
<%@ page import="dtopackage.com.UserBooking" %>

<%
    User user = (User) session.getAttribute("userObj");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<UserBooking> bookings =
        (List<UserBooking>) request.getAttribute("allBookings");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Bookings</title>

<style>
body{
    margin:0;
    padding:20px;
    font-family:Poppins,sans-serif;
    background:#e8f5f3;
}
.wrap{ max-width:920px; margin:auto; }
.head{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.card{
    background:#fff;
    border-radius:14px;
    padding:16px;
    margin-bottom:14px;
    box-shadow:0 6px 20px rgba(0,0,0,.08);
    cursor:pointer;
}
.type{
    font-weight:700;
    color:#1f3a3d;
    margin-bottom:6px;
}
.sub{
    color:#555;
    font-size:14px;
}
.total{
    margin-top:8px;
    color:#28a745;
    font-weight:800;
}
.empty{
    text-align:center;
    padding:40px;
    background:#fff;
    border-radius:12px;
    color:#555;
}
</style>
</head>

<body>
<div class="wrap">

    <div class="head">
        <h2>My Bookings</h2>
        <div>Welcome, <b><%= user.getFull_name() %></b></div>
    </div>

<% if (bookings == null || bookings.isEmpty()) { %>

    <div class="empty">You have no bookings yet.</div>

<% } else {
    for (UserBooking b : bookings) {
%>

    <div class="card" onclick="location.href='<%= b.getDetailsUrl() %>'">
        <div class="type"><%= b.getBookingType() %></div>

        <div class="sub"><b><%= b.getTitle() %></b></div>

        <% if (b.getSubtitle() != null) { %>
            <div class="sub"><%= b.getSubtitle() %></div>
        <% } %>

        <% if (b.getTravelDate() != null) { %>
            <div class="sub">Date: <%= b.getTravelDate() %></div>
        <% } %>

        <div class="total">₹ <%= b.getAmount() %>
</div>
    </div>

<% } } %>

</div>
</body>
</html>
