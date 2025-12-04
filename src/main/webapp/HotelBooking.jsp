<%@page import="dtopackage.com.Hotel"%>
<%@page import="dtopackage.com.User"%>

<%
    User user = (User) session.getAttribute("userObj");
    if (user == null) { response.sendRedirect("Login.jsp"); return; }

    Hotel hotel = (Hotel) request.getAttribute("hotel");
%>

<!DOCTYPE html>
<html>
<head>
<title>Hotel Booking</title>
<style>
body { font-family:Poppins;background:#e8f5f3;padding:20px }
.card { background:white;padding:20px;border-radius:12px;width:450px;margin:auto;
        box-shadow:0 5px 18px rgba(0,0,0,0.15) }
.btn { background:#3ba58b;color:white;border:none;padding:10px 20px;border-radius:8px }
</style>
</head>

<body>

<div class="card">

<h2>Book Hotel: <%= hotel.getHotelName() %></h2>
<p>Location: <%= hotel.getNearLocation() %></p>
<p>Price per night: ₹<%= hotel.getPricePerNight() %></p>

<form action="ConfirmHotelBooking" method="post">
    <input type="hidden" name="hotelId" value="<%= hotel.getHotelId() %>">

    Check-in:
    <input type="date" name="checkin" required><br><br>

    Check-out:
    <input type="date" name="checkout" required><br><br>

    Guests:
    <input type="number" name="guests" value="1" min="1"><br><br>

    <button class="btn">Confirm Booking</button>
</form>


</div>

</body>
</html>
