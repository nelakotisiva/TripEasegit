<%@page import="dtopackage.com.Restaurant"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nearby Restaurants</title>
</head>
<body>

<h2>Nearby Restaurants Based on Location & Previous Booking Budget</h2>

<!-- Button to get location -->
<button onclick="getLocationAndRedirect()">📍 Find Restaurants Near Me</button>
<br><br>

<!-- Display Booking Message -->
<%
String msg = (String) session.getAttribute("msg");
if(msg != null){
%>
    <p style="color:green; font-weight:bold;"><%= msg %></p>
<%
    session.removeAttribute("msg");
}
%>

<!-- Display Budget Info -->
<%
Double budget = (Double) request.getAttribute("budget");
if(budget != null && budget > 0){
%>
    <p>Your last booking amount: ₹ <%= budget %> </p>
<%
}
List<Restaurant> list = (List<Restaurant>) request.getAttribute("restaurants");
if(list == null || list.isEmpty()){
%>
    <p>No Restaurants found based on your location/budget.</p>
<%
} else {
%>

<!-- Table of Restaurants -->
<table border="1" cellpadding="10">
<tr>
    <th>Name</th>
    <th>Type</th>
    <th>Rating</th>
    <th>Avg Price</th>
    <th>Contact</th>
    <th>Action</th>
</tr>

<%
for(Restaurant r : list){
%>
<tr>
    <td><%= r.getName() %></td>
    <td><%= r.getType() %></td>
    <td><%= r.getRating() %></td>
    <td>₹ <%= r.getAvgPrice() %></td>
    <td><%= r.getContact() %></td>
    <td>
        <form action="bookRestaurant" method="post">
            <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">
            <input type="number" name="people" placeholder="No. of People" required>
            <button type="submit">Book Now</button>
        </form>
    </td>
</tr>
<%
}
%>
</table>

<%
}
%>

<script>
function getLocationAndRedirect(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos) {
            const lat = pos.coords.latitude;
            const lon = pos.coords.longitude;
            window.location.href = "nearbyRestaurants?lat=" + lat + "&lon=" + lon;
        }, function() {
            alert("Location Permission Denied! Showing all restaurants.");
            window.location.href = "nearbyRestaurants";
        });
    } else {
        alert("Geolocation not supported.");
        window.location.href = "nearbyRestaurants";
    }
}
</script>

</body>
</html>
