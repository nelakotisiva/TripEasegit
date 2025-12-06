<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Booking" %>
<%@ page import="dtopackage.com.User" %>
<%
    User userObj = (User) session.getAttribute("userObj");
    if (userObj == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #f0f0f0; }
        h2 { text-align: center; margin-top: 20px; }
    </style>
</head>
<body>

<h2>My Bookings</h2>
<p style="text-align:center;">Welcome, <%= userObj.getFull_name() %>!</p>

<table>
    <tr>
        <th>Booking ID</th>
        <th>Destination</th>
        <th>Booking Date</th>
        <th>Travel Date</th>
        <th>Status</th>
        <th>Number of People</th>
    </tr>

    <%
        if (bookings != null && !bookings.isEmpty()) {
            for (Booking b : bookings) {
    %>
        <tr>
            <td><%= b.getBookingId() %></td>
            <td><%= b.getDestinationId() %></td> <!-- replace with name if DTO is updated -->
            <td><%= b.getBookingDate() %></td>
            <td><%= b.getTravelDate() %></td>
            <td><%= b.getStatus() %></td>
            <td><%= b.getNumOfPeople() %></td>
        </tr>
    <%
            }
        } else {
    %>
        <tr>
            <td colspan="6">No bookings found.</td>
        </tr>
    <%
        }
    %>
</table>

</body>
</html>
