<%@page import="dtopackage.com.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <title>User Dashboard</title>
</head>
<body>

<h2>Welcome, <%= userObj.getFull_name() %>!</h2>
<hr>

<h3>TripEase User Dashboard</h3>


<ul>
    <li><a href="ProfileServlet">View Profile</a></li>
    <li><a href="HotelListServlet">Hotels</a></li>
    <li><a href="VehicleListServlet">Cabs / Bikes</a></li>
    <li><a href="RestaurantListServlet">Restaurants</a></li>
    <li><a href="PackageListServlet">Tour Packages</a></li>
    <li><a href="PlacesServlet">Famous Places</a></li>
    <li><a href="MyBookingsServlet">My Bookings</a></li>
    <li><a href="LogoutServlet">Logout</a></li>
</ul>

</body>
</html>
