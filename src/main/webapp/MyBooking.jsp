<%@page import="java.util.List"%>
<%@page import="dtopackage.com.Bookingg"%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
</head>

<body>

<h2>Your Bookings</h2>

<table border="1" cellpadding="10" cellspacing="0">
<tr>
    <th>Hotel</th>
    <th>Check-in</th>
    <th>Check-out</th>
    <th>Guests</th>
    <th>Total</th>
</tr>

<%
List<Bookingg> list = (List<Bookingg>) request.getAttribute("bookings");
if (list != null && !list.isEmpty()) {
    for (Bookingg b : list) {
%>
<tr>
    <td><%= b.getHotelName() %></td>
    <td><%= b.getCheckIn() %></td>
    <td><%= b.getCheckOut() %></td>
    <td><%= b.getGuests() %></td>
    <td>₹<%= b.getTotal() %></td>
</tr>
<%
    } 
} else {
%>
<tr>
    <td colspan="5">No bookings found.</td>
</tr>
<%
}
%>

</table>

</body>
</html>
