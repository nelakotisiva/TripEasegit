<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dtopackage.com.Hotel" %>
<%@ page import="dtopackage.com.User" %>

<%
    User user = (User) session.getAttribute("userObj");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Hotel hotel = (Hotel) request.getAttribute("hotel");
    if (hotel == null) {
        response.sendRedirect("HotelListServlet");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Hotel - <%= hotel.getHotelName() %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        body {
            background:#e9f7f7;
            font-family:'Poppins', sans-serif;
            padding:25px;
        }

        .back-wrap{
            max-width:920px;
            margin:0 auto 16px;
        }
        .back-btn{
            display:inline-flex;
            align-items:center;
            gap:8px;
            background:linear-gradient(135deg,#3ba58b,#2f8a74);
            color:white;
            padding:10px 20px;
            border-radius:999px;
            text-decoration:none;
            font-weight:600;
            box-shadow:0 6px 18px rgba(59,165,139,.35);
            transition:.3s;
        }
        .back-btn:hover{
            transform:translateX(-4px);
            box-shadow:0 10px 24px rgba(59,165,139,.45);
        }

        .card {
            max-width:920px;
            margin:auto;
            background:#fff;
            border-radius:16px;
            overflow:hidden;
            box-shadow:0 10px 30px rgba(0,0,0,0.12);
        }
        .hotel-img {
            width:100%;
            height:380px;
            object-fit:cover;
        }
        .card-body {
            padding:22px;
            display:grid;
            grid-template-columns: 1.1fr 1fr;
            gap:26px;
        }
        .title {
            font-size:28px;
            font-weight:800;
            color:#1f3a3d;
        }
        .info {
            margin-top:10px;
            line-height:1.6;
            color:#444;
        }
        .price {
            color:#28a745;
            font-size:22px;
            font-weight:800;
            margin-top:12px;
        }
        .badge {
            display:inline-block;
            background:#3ba58b;
            color:#fff;
            padding:6px 12px;
            border-radius:20px;
            font-size:13px;
            margin-top:8px;
        }
        .booking-form {
            background:#f6fffd;
            padding:18px;
            border-radius:14px;
            border:1px solid #d7eeea;
        }
        label {
            font-weight:600;
            margin-top:10px;
            display:block;
        }
        input {
            width:100%;
            padding:10px;
            border-radius:8px;
            border:1px solid #ccc;
            margin-top:4px;
        }
        .btn {
            width:100%;
            margin-top:16px;
            padding:12px;
            background:linear-gradient(90deg,#ff4b2b,#ff416c);
            border:none;
            border-radius:10px;
            color:white;
            font-size:16px;
            font-weight:700;
            cursor:pointer;
        }
        .btn:hover {
            opacity:0.95;
        }
        .error {
            background:#ffe6e6;
            color:#b10000;
            padding:10px 14px;
            border-radius:8px;
            margin-bottom:12px;
        }
        @media(max-width:768px){
            .card-body{
                grid-template-columns:1fr;
            }
        }
    </style>
</head>

<body>

<!-- BACK BUTTON -->
<div class="back-wrap">
    <a href="HotelList.jsp" class="back-btn">← Back to Hotels</a>
</div>

<div class="card">

    <img class="hotel-img"
         src="<%= (hotel.getImageUrl() != null && !hotel.getImageUrl().isEmpty())
                ? hotel.getImageUrl()
                : "https://source.unsplash.com/1200x800/?hotel,resort" %>">

    <div class="card-body">

        <!-- LEFT : HOTEL DETAILS -->
        <div>
            <div class="title"><%= hotel.getHotelName() %></div>

            <div class="info">
                📍 <strong>Location:</strong> <%= hotel.getNearLocation() %><br>
                ⭐ <strong>Rating:</strong> <%= hotel.getRating() %> / 5<br>
                🏨 <strong>Rooms Available:</strong> <%= hotel.getRoomsAvailable() %>
            </div>

            <div class="price">
                ₹ <%= hotel.getPricePerNight() %> / night
            </div>

            <span class="badge">Free Cancellation</span>
        </div>

        <!-- RIGHT : BOOKING FORM -->
        <div class="booking-form">

            <% if (error != null) { %>
                <div class="error"><%= error %></div>
            <% } %>

            <form action="ConfirmHotelBooking" method="post">

                <input type="hidden" name="hotelId"
                       value="<%= hotel.getHotelId() %>">

                <label>Check-in Date</label>
                <input type="date" id="checkin" name="checkin" required>

                <label>Check-out Date</label>
                <input type="date" id="checkout" name="checkout" required>

                <label>Guests</label>
                <input type="number"
                       name="guests"
                       min="1"
                       value="1"
                       max="<%= hotel.getRoomsAvailable() %>">

                <button class="btn">Confirm Booking</button>

            </form>
        </div>

    </div>
</div>

<!-- ✅ DATE LOGIC (NO PAST DATES) -->
<script>
    const today = new Date().toISOString().split("T")[0];

    const checkin = document.getElementById("checkin");
    const checkout = document.getElementById("checkout");

    // Disable past dates
    checkin.min = today;
    checkout.min = today;

    // Checkout must be after check-in
    checkin.addEventListener("change", function () {
        checkout.min = this.value;
    });
</script>

</body>
</html>
