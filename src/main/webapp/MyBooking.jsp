<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dtopackage.com.Bookingg" %>
<%@ page import="dtopackage.com.User" %>

<%
    User user = (User) session.getAttribute("userObj");
    if (user == null) { 
        response.sendRedirect("Login.jsp"); 
        return; 
    }

    List<Bookingg> bookings = (List<Bookingg>) request.getAttribute("bookings");
    if (bookings == null) bookings = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        body { margin:0; padding:20px; font-family:"Poppins",sans-serif; background:#e8f5f3; }
        .wrap { max-width:920px; margin:0 auto; }
        .head { display:flex; align-items:center; justify-content:space-between; margin-bottom:18px; }
        .title{ font-size:24px; color:#1f3a3d; font-weight:700; }
        .card{ background:#fff; border-radius:12px; padding:16px; margin-bottom:12px;
               box-shadow:0 6px 20px rgba(0,0,0,0.06); }
        .row { display:flex; justify-content:space-between; align-items:center; gap:12px; }
        .meta { color:#1f3a3d; font-weight:600; }
        .sub { color:#555; font-size:14px; }
        .total { color:#28a745; font-weight:800; }
        .empty { text-align:center; padding:40px; color:#555; background:#fff; border-radius:12px; }
        .btn { padding:8px 12px; border-radius:8px; border:none; color:#fff; 
               background:#3ba58b; cursor:pointer; }
        .btn:hover { background:#328a74; }
    </style>
</head>

<body>
<div class="wrap">

    <div class="head">
        <div class="title">My Bookings</div>
        <div>Welcome, <strong><%= user.getFull_name() %></strong></div>
    </div>

    <% if (bookings.isEmpty()) { %>

        <div class="empty">You have no bookings yet. Browse hotels to book a stay.</div>

    <% } else { 
        for (Bookingg b : bookings) {
    %>

        <div class="card">
            <div class="row">

                <div>
                    <div class="meta">
                        <%= b.getHotelName() %> —
                        <span class="sub"><%= b.getHotelLocation() %></span>
                    </div>

                    <div class="sub">
                        Check-in: <%= b.getCheckin() %> •
                        Check-out: <%= b.getCheckout() %> •
                        Guests: <%= b.getGuests() %>
                    </div>

                    <div class="sub">
                        Booked on: <%= b.getBookingDate() != null ? b.getBookingDate() : "N/A" %>
                    </div>
                </div>

                <div style="text-align:right">
                    <div class="total">₹ <%= String.format("%.2f", b.getTotalAmount()) %></div>
                    <div style="margin-top:8px">
                        <a href="HotelListServlet">
                            <button class="btn">Book Again</button>
                        </a>
                    </div>
                </div>

            </div>
        </div>

    <% } } %>

</div>
</body>
</html>
