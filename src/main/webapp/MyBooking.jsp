<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<title>My Bookings</title>

<style>
body{background:#e8f5f3;font-family:Poppins;padding:20px;}
.wrap{max-width:900px;margin:auto;}
.card{
    background:#fff;
    border-radius:14px;
    padding:16px;
    margin-bottom:16px;
    box-shadow:0 6px 20px rgba(0,0,0,.08);
}
.type{font-weight:700;color:#1f3a3d;}
.sub{color:#555;font-size:14px;}
.total{color:#28a745;font-weight:800;margin-top:6px;}
.btn{
    background:#ff5252;
    color:#fff;
    border:none;
    padding:6px 12px;
    border-radius:8px;
    cursor:pointer;
    margin-top:10px;
}
.cancelled{
    color:red;
    font-weight:700;
    margin-top:8px;
}
</style>
</head>

<body>
<div class="wrap">

<h2>My Bookings</h2>
<p>Welcome, <b><%= user.getFull_name() %></b></p>

<% if (bookings == null || bookings.isEmpty()) { %>

    <p>No bookings found.</p>

<% } else {
   for (UserBooking b : bookings) {
%>

<div class="card">

    <div class="type">
        <%= b.getIcon() != null ? b.getIcon() : "" %>
        <%= b.getBookingType() %>
    </div>

    <div class="sub"><b><%= b.getTitle() %></b></div>
    <div class="sub"><%= b.getSubtitle() %></div>

    <% if (b.getBookingDate() != null) { %>
        <div class="sub">
            Booked On: <%= sdf.format(b.getBookingDate()) %>
        </div>
    <% } %>

    <div class="total">₹ <%= b.getAmount() %></div>

    <% if (!"Cancelled".equalsIgnoreCase(b.getStatus())) { %>

        <form action="CancelBookingServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
            <input type="hidden" name="type" value="<%= b.getBookingType() %>">
            <button class="btn">Cancel</button>
        </form>

    <% } else { %>
        <div class="cancelled">Cancelled</div>
    <% } %>

</div>

<% } } %>

</div>
</body>
</html>
