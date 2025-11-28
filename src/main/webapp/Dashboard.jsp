<%@page import="dtopackage.com.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User userObj = (User) session.getAttribute("userObj");
    if (userObj == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TripEase Dashboard</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;
        background: #eef3ff;
    }
    .header {
        background: #0d6efd;
        padding: 20px;
        text-align: center;
        color: #fff;
        font-size: 28px;
        font-weight: bold;
        box-shadow: 0 4px 10px rgba(0,0,0,0.18);
    }
    .welcome {
        text-align: center;
        font-size: 22px;
        margin-top: 25px;
        color: #333;
        font-weight: bold;
    }
    .dashboard-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
        gap: 25px;
        width: 90%;
        margin: 30px auto;
    }
    .card {
        background: #fff;
        padding: 25px;
        text-align: center;
        border-radius: 15px;
        cursor: pointer;
        border-top: 5px solid #0d6efd;
        box-shadow: 0px 3px 12px rgba(0,0,0,0.12);
        transition: .30s;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0px 8px 25px rgba(0,0,0,0.2);
    }
    .icon {
        font-size: 42px;
        color: #0d6efd;
        margin-bottom: 8px;
    }
    .card-title {
        font-size: 18px;
        font-weight: bold;
        color: #333;
    }
    .logout-btn {
        text-align: center;
        margin: 35px 0;
    }
    .logout-btn a {
        text-decoration: none;
        background: #ff2b2b;
        color: #fff;
        padding: 12px 25px;
        border-radius: 10px;
        font-size: 18px;
        font-weight: 600;
        transition: .3s;
    }
    .logout-btn a:hover {
        background: #c60000;
    }
</style>

<script>
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos) {
            let lat = pos.coords.latitude;
            let lon = pos.coords.longitude;
            window.location.href = "nearbyRestaurants?lat=" + lat + "&lon=" + lon;
        }, function() {
            window.location.href = "nearbyRestaurants";
        });
    } else {
        window.location.href = "nearbyRestaurants";
    }
}
</script>

</head>

<body>

<div class="header">TripEase User Dashboard</div>

<div class="welcome">
    Welcome, <%= userObj.getFull_name() %> 👋
</div>

<div class="dashboard-container">

    <div class="card" onclick="window.location.href='ProfileServlet'">
        <div class="icon">👤</div>
        <div class="card-title">Profile</div>
    </div>

    <div class="card" onclick="window.location.href='HotelListServlet'">
        <div class="icon">🏨</div>
        <div class="card-title">Hotels</div>
    </div>

    <div class="card" onclick="window.location.href='VehicleListServlet'">
        <div class="icon">🚗</div>
        <div class="card-title">Cabs / Bikes</div>
    </div>

    <div class="card" onclick="getLocation()">
        <div class="icon">🍽️</div>
        <div class="card-title">Restaurants</div>
    </div>

    <div class="card" onclick="window.location.href='PackageListServlet'">
        <div class="icon">🎒</div>
        <div class="card-title">Tour Packages</div>
    </div>

    <div class="card" onclick="window.location.href='PlacesServlet'">
        <div class="icon">📍</div>
        <div class="card-title">Famous Places</div>
    </div>

    <div class="card" onclick="window.location.href='SearchFlight'">
        <div class="icon">✈️</div>
        <div class="card-title">Flights</div>
    </div>

    <div class="card" onclick="window.location.href='MyBookingsServlet'">
        <div class="icon">📜</div>
        <div class="card-title">My Bookings</div>
    </div>

</div>

<div class="logout-btn">
    <a href="LogoutServlet">Logout</a>
</div>

</body>
</html>
