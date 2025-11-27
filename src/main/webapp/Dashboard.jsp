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
        padding: 22px;
        color: white;
        text-align: center;
        font-size: 30px;
        font-weight: bold;
        box-shadow: 0 3px 7px rgba(0,0,0,0.2);
    }

    .welcome {
        text-align: center;
        font-size: 22px;
        margin: 25px 0 5px;
        color: #333;
        font-weight: bold;
    }

    .dashboard-container {
        width: 90%;
        margin: 25px auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
        grid-gap: 20px;
    }

    .card {
        background: white;
        padding: 25px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        transition: transform 0.25s ease, box-shadow 0.25s ease;
        cursor: pointer;
        border-top: 5px solid #0d6efd;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 22px rgba(0,0,0,0.15);
    }

    .icon {
        font-size: 40px;
        margin-bottom: 10px;
        color: #0d6efd;
    }

    .card-title {
        font-size: 20px;
        font-weight: bold;
        color: #444;
        margin-top: 10px;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    .logout-btn {
        text-align: center;
        margin-top: 30px;
    }

    .logout-btn a {
        background: #ff3333;
        color: white;
        padding: 12px 22px;
        font-size: 18px;
        border-radius: 8px;
        text-decoration: none;
        transition: background 0.25s;
    }

    .logout-btn a:hover {
        background: #cc0000;
    }

</style>

</head>

<body>

<div class="header">TripEase User Dashboard</div>

<div class="welcome">
    Welcome, <%= userObj.getFull_name() %> 👋
</div>

<div class="dashboard-container">

    <a href="ProfileServlet">
        <div class="card">
            <div class="icon">👤</div>
            <div class="card-title">View Profile</div>
        </div>
    </a>

    <a href="HotelListServlet">
        <div class="card">
            <div class="icon">🏨</div>
            <div class="card-title">Hotels</div>
        </div>
    </a>

    <a href="VehicleListServlet">
        <div class="card">
            <div class="icon">🚗</div>
            <div class="card-title">Cabs / Bikes</div>
        </div>
    </a>

    <a href="RestaurantListServlet">
        <div class="card">
            <div class="icon">🍽️</div>
            <div class="card-title">Restaurants</div>
        </div>
    </a>

    <a href="PackageListServlet">
        <div class="card">
            <div class="icon">🎒</div>
            <div class="card-title">Tour Packages</div>
        </div>
    </a>

    <a href="PlacesServlet">
        <div class="card">
            <div class="icon">📍</div>
            <div class="card-title">Famous Places</div>
        </div>
    </a>

    <a href="SearchFlight">
        <div class="card">
            <div class="icon">✈️</div>
            <div class="card-title">Flights</div>
        </div>
    </a>

    <a href="MyBookingsServlet">
        <div class="card">
            <div class="icon">📜</div>
            <div class="card-title">My Bookings</div>
        </div>
    </a>

</div>

<div class="logout-btn">
    <a href="LogoutServlet">Logout</a>
</div>
<h2>Welcome, <%= userObj.getFull_name() %>!</h2>
<hr>

<h3>TripEase User Dashboard</h3>

<ul>
    <li><a href="ProfileServlet">View Profile</a></li>
    <li><a href="HotelListServlet">Hotels</a></li>
    <li><a href="VehicleListServlet">Cabs / Bikes</a></li>
    <li><a href="nearbyRestaurants?type=auto">Restaurants</a></li>
    <li><a href="PackageListServlet">Tour Packages</a></li>
    <li><a href="PlacesServlet">Famous Places</a></li>
    <li><a href="MyBookingsServlet">My Bookings</a></li>
    <li><a href="LogoutServlet">Logout</a></li>
</ul>
<li><a href="javascript:getLocation()">Restaurants</a></li>

<script>
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos) {
            const lat = pos.coords.latitude;
            const lon = pos.coords.longitude;
            window.location.href = "nearbyRestaurants?lat=" + lat + "&lon=" + lon;
        }, function() {
            window.location.href = "nearbyRestaurants"; // no location
        });
    } else {
        window.location.href = "nearbyRestaurants";
    }
}
</script>

</body>
</html>
