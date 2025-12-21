<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

    if (bookings == null) bookings = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Flight Bookings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        body {
            margin: 0;
            padding: 20px;
            font-family: Poppins, sans-serif;
            background: #eef4ff;
        }

        .wrap {
            max-width: 920px;
            margin: 0 auto;
        }

        .head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }

        .title {
            font-size: 24px;
            color: #1f2d4f;
            font-weight: 700;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
        }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .meta {
            color: #1f2d4f;
            font-weight: 600;
            font-size: 16px;
        }

        .sub {
            color: #555555;
            font-size: 14px;
            margin-top: 6px;
        }

        .total {
            color: #0d6efd;
            font-weight: 800;
            font-size: 18px;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #555555;
            background: #ffffff;
            border-radius: 12px;
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="head">
        <!-- ❌ airplane symbol removed -->
        <div class="title">My Flight Bookings</div>
        <div>Welcome <strong><%= user.getFull_name() %></strong></div>
    </div>

    <% if (bookings.isEmpty()) { %>

        <div class="empty">
            You have no flight bookings yet.
        </div>

    <% } else {
        for (Flight f : bookings) {
    %>

        <div class="card">
            <div class="row">

                <!-- LEFT DETAILS -->
                <div>
                    <div class="meta">
                        <%= f.getAirline() %>
                        (<%= f.getSource() %> - <%= f.getDestination() %>)
                    </div>

                    <div class="sub">
                        Flight ID: <%= f.getFlightId() %>
                    </div>

                    <div class="sub">
                        Status: <strong>CONFIRMED</strong>
                    </div>
                </div>

                <!-- RIGHT PRICE -->
                <div class="total">
                    &#8377; <%= String.format("%.2f", f.getPrice()) %>
                </div>

            </div>
        </div>

    <% } } %>

</div>

</body>
</html>
