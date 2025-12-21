<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

    if (bookings == null) bookings = new ArrayList<>();

    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Hotel Bookings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        body {
            margin: 0;
            padding: 20px;
            font-family: "Poppins", sans-serif;
            background: #e8f5f3;
        }

        .wrap {
            max-width: 920px;
            margin: 0 auto;
        }

        .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .title {
            font-size: 24px;
            font-weight: 700;
            color: #1f3a3d;
        }

        /* ✅ BACK BUTTON */
        .back-btn {
            text-decoration: none;
            padding: 8px 14px;
            background: #1f3a3d;
            color: #ffffff;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
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
            align-items: flex-start;
        }

        .meta {
            font-weight: 600;
            font-size: 16px;
            color: #1f3a3d;
        }

        .sub {
            font-size: 14px;
            margin-top: 8px;
            color: #555;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .location-icon {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .price {
            color: #28a745;
            font-weight: 800;
            font-size: 18px;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #555;
            background: #ffffff;
            border-radius: 12px;
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="head">
        <div class="title">My Hotel Bookings</div>

        <div>
            <a href="Dashboard.jsp" class="back-btn">← Back to Dashboard</a>
            &nbsp;&nbsp;
            Welcome, <strong><%= user.getFull_name() %></strong>
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
            <div class="row">

                <!-- LEFT DETAILS -->
                <div>
                    <div class="meta">
                        <%= b.getHotelName() %>
                    </div>

                    <div class="sub">
                        <img
                            src="https://external-preview.redd.it/i-quit-my-job-to-create-a-travel-itinerary-app-navigate-is-v0-FPHxWuyB7_x_DX942QmUv4NmTPJpE6WI2HzzaQ_fMo8.jpg?width=1080&crop=smart&auto=webp&s=27d92bc34d196f32e3551d3f2515508ec71ae6c4"
                            alt="Trending Location"
                            class="location-icon">
                        <%= b.getHotelLocation() %>
                    </div>

                    <div class="sub"><strong>Check-in:</strong> <%= b.getCheckin() %></div>
                    <div class="sub"><strong>Check-out:</strong> <%= b.getCheckout() %></div>
                    <div class="sub"><strong>Guests:</strong> <%= b.getGuests() %></div>

                    <div class="sub">
                        <strong>Booked on:</strong>
                        <%= b.getBookingDate() != null
                                ? df.format(b.getBookingDate())
                                : "N/A" %>
                    </div>
                </div>

                <!-- RIGHT PRICE -->
                <div class="price">
                    &#8377; <%= String.format("%.2f", b.getTotalAmount()) %>
                </div>

            </div>
        </div>

    <% } } %>

</div>

</body>
</html>
