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

/* ✅ MY BOOKINGS BUTTON */
.my-bookings-btn {
    background:#1f3a3d;
    padding:10px 16px;
    border:none;
    color:white;
    cursor:pointer;
    border-radius:8px;
    font-size:15px;
    font-weight:600;
    text-decoration:none;
    margin-left:10px;
    transition:0.25s;
}

.my-bookings-btn:hover {
    background:#162a2c;
}

/* Location Button */
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

/* Image */
.card img {
    width:100%;
    height:180px;
    object-fit:cover;
    border-radius:12px;
}

/* Input */
input {
    padding:10px;
    width:100%;
    border-radius:8px;
    margin-top:10px;
    border:1px solid #b8d4cf;
    background:#f8fbfa;
}

input:focus {
    border-color:#3ba58b;
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
}

.book-btn:hover {
    background:#328a74;
}

/* ---------- POPUP ---------- */
#popup {
    display:none;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.4);
    z-index:9999;
    align-items:center;
    justify-content:center;
}

.popup-box {
    background:white;
    padding:25px 30px;
    border-radius:14px;
    width:320px;
    text-align:center;
    box-shadow:0 10px 30px rgba(0,0,0,0.2);
}

.popup-box h3 {
    color:#1f3a3d;
    margin-bottom:10px;
}

.popup-box button {
    background:#3ba58b;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
}

.popup-box button:hover {
    background:#328a74;
}

</style>
</head>

<body>

<!-- 🔹 TOP ACTION BUTTONS -->
<a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

<a href="myRestaurantsBookings" class="my-bookings-btn">📖 My Restaurants Bookings</a>

<h2>🍽 Find Restaurants Near You</h2>

<button class="location-btn" onclick="getLocationAndRedirect()">📍 Use My Location</button>
<br><br>

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

    <form action="bookRestaurant" method="post">
        <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">

        <input type="number" name="people" placeholder="Number of People" required>

        <input type="datetime-local" name="bookingDateTime" class="dt" required>

        <button type="submit" class="book-btn">Book Now</button>
    </form>
</div>

<%
    }
} else {
%>
    <p style="color:#1f3a3d; font-weight:600;">No restaurants found.</p>
<%
}
%>

</div>

<!-- ---------- POPUP ---------- -->
<div id="popup">
    <div class="popup-box">
        <h3>Booking Status</h3>
        <p id="popupMsg"></p>
        <button onclick="closePopup()">OK</button>
    </div>
</div>

<script>
function getLocationAndRedirect(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos){
            window.location.href =
                "nearbyRestaurants?lat=" + pos.coords.latitude +
                "&lon=" + pos.coords.longitude;
        }, function(){
            window.location.href = "nearbyRestaurants";
        });
    } else {
        window.location.href = "nearbyRestaurants";
    }
}

function showPopup(msg){
    document.getElementById("popupMsg").innerText = msg;
    document.getElementById("popup").style.display = "flex";
}

function closePopup(){
    document.getElementById("popup").style.display = "none";
}

/* Disable past date & time */
window.onload = function () {
    let now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    let minDateTime = now.toISOString().slice(0,16);

    document.querySelectorAll(".dt").forEach(input => {
        input.min = minDateTime;
    });
};
</script>

<%
String msg = (String) session.getAttribute("msg");
if (msg != null) {
%>
<script>
    showPopup("<%= msg %>");
</script>
<%
    session.removeAttribute("msg");
}
%>

</body>
</html>
