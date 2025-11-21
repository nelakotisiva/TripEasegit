<%@ page import="java.util.List" %>
<%@page import="dtopackage.com.Cab"%>



<h1>Cab / Bike Rentals</h1>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Destination</th>
        <th>Vehicle Type</th>
        <th>Model</th>
        <th>Price/Day</th>
        <th>Availability</th>
        <th>Action</th>
    </tr>

    <%
        List<Cab> list = (List<Cab>) request.getAttribute("rentals");

        for (Cab c : list) {
    %>
    <tr>
        <td><%= c.getRentalId() %></td>
        <td><%= c.getDestinationId() %></td>
        <td><%= c.getVehicleType() %></td>
        <td><%= c.getModel() %></td>
        <td>₹ <%= c.getPricePerDay() %></td>
        <td><%= c.getAvailability() %></td>

        <td>
            <% if (c.getAvailability().equalsIgnoreCase("Available")) { %>
                <form action="CabRentalServlet" method="post">
                    <input type="hidden" name="rentalId" value="<%= c.getRentalId() %>">
                    <button type="submit">Book Now</button>
                </form>
            <% } else { %>
                <span style="color:red;">Booked</span>
            <% } %>
        </td>
    </tr>
    <% } %>
</table>

<h3 style="color:green;"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></h3>
