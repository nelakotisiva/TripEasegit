<%@page import="dtopackage.com.Restaurant"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Nearby Restaurants | TripEase</title>

<style>

/* ----- Soft Mint Background (TripEase Theme) ----- */
body {
    font-family: "Poppins", sans-serif;
    background:#e8f5f3;
    margin:0;
    padding:20px;
}

/* Heading */
h2 {
    margin-bottom:15px;
    color:#1f3a3d;
    font-weight:600;
}

/* Back Button */
.back-btn {
    background:#3ba58b;
    padding:10px 16px;
    border:none;
    color:white;
    cursor:pointer;
    border-radius:8px;
    font-size:15px;
    font-weight:600;
    text-decoration:none;
    transition:0.25s;
}

.back-btn:hover {
    background:#328a74;
}

/* Use My Location Button */
.location-btn {
    background:#3ba58b;
    padding:10px 16px;
    border:none;
    color:white;
    cursor:pointer;
    border-radius:8px;
    font-size:15px;
    font-weight:600;
    margin-top:10px;
    transition:0.25s;
}

.location-btn:hover {
    background:#328a74;
}

/* Cards Grid */
.container {
    display:grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap:22px;
    margin-top:20px;
}

/* Restaurant Card */
.card {
    background:#ffffff;
    padding:15px;
    border-radius:14px;
    box-shadow:0 6px 20px rgba(0,0,0,0.08);
    transition:0.3s;
}

.card:hover {
    transform:translateY(-3px);
}

/* Restaurant Image */
.card img {
    width:100%;
    height:180px;
    object-fit:cover;
    border-radius:12px;
}

/* Booking Input */
input {
    padding:10px;
    width:100%;
    border-radius:8px;
    margin-top:10px;
    border:1px solid #b8d4cf;
    background:#f8fbfa;
    transition:0.25s;
}

input:focus {
    border-color:#3ba58b;
    box-shadow:0 0 8px rgba(59,165,139,0.3);
    background:white;
    outline:none;
}

/* Book Button */
.book-btn {
    background:#3ba58b;
    padding:10px 16px;
    width:100%;
    border:none;
    color:white;
    font-weight:600;
    border-radius:8px;
    margin-top:10px;
    cursor:pointer;
    transition:0.25s;
}

.book-btn:hover {
    background:#328a74;
}

</style>

</head>
<body>

<!-- Back Button -->
<a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

<h2>🍽 Find Restaurants Near You</h2>

<!-- Location Button -->
<button class="location-btn" onclick="getLocationAndRedirect()">📍 Use My Location</button>
<br><br>

<!-- Booking Message -->
<%
String msg = (String) session.getAttribute("msg");
if(msg != null){
%>
    <p style="color:green; font-weight:600;"><%= msg %></p>
<%
session.removeAttribute("msg");
}
%>

<!-- Budget Display -->
<%
Double budget = (Double) request.getAttribute("budget");
if (budget != null && budget > 0) {
%>
    <p style="color:#1f3a3d;"><b>Your last booking spending:</b> ₹ <%= budget %></p>
<%
}
%>

<!-- Restaurants Grid -->
<div class="container">

<%
List<Restaurant> list = (List<Restaurant>) request.getAttribute("restaurants");

if (list != null && !list.isEmpty()) {
for (Restaurant r : list) {
%>

<div class="card">

    <img src="<%= r.getImageUrl() != null ? r.getImageUrl() : "https://via.placeholder.com/300" %>">

    <h3 style="color:#1f3a3d;"><%= r.getName() %></h3>
    <p><b>Type:</b> <%= r.getType() %></p>
    <p><b>Rating:</b> ⭐ <%= r.getRating() %></p>
    <p><b>Avg Price:</b> ₹ <%= r.getAvgPrice() %></p>
    <p><b>Contact:</b> <%= r.getContact() %></p>

    <!-- Booking Form -->
    <form action="bookRestaurant" method="post">
        <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">
        <input type="number" name="people" placeholder="Number of People" required>
        <button type="submit" class="book-btn">Book Now</button>
    </form>

</div>

<%
}} else {
%>

    <p style="color:#1f3a3d; font-weight:600;">No restaurants found.</p>

<%
}
%>

</div>

<script>
function getLocationAndRedirect(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos){
            window.location.href =
                "nearbyRestaurants?lat=" + pos.coords.latitude +
                "&lon=" + pos.coords.longitude;
        }, function(){
            alert("Location access denied! Showing all restaurants.");
            window.location.href = "nearbyRestaurants";
        });
    } else {
         alert("GPS not supported! Showing all restaurants.");
         window.location.href = "nearbyRestaurants";
    }
}
</script>

</body>
</html>
