<%@ page import="dtopackage.com.Cab" %>
<%@ page import="dtopackage.com.User" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("userObj");
    if(user == null){
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Cab> list = (List<Cab>) request.getAttribute("vehicles");
    List<Integer> booked = (List<Integer>) request.getAttribute("bookedIds");
%>

<!DOCTYPE html>
<html>
<head>
<title>Vehicle Booking - TripEase</title>

<style>
    table{width:85%;border-collapse:collapse;margin-top:20px;}
    th,td{border:1px solid black;padding:10px;text-align:center;}
    th{background:#dfe8ff;}
    .book-btn{background:green;color:white;border:none;padding:6px 12px;border-radius:5px;}
</style>
</head>
<body>

<h2>Welcome <%= user.getFull_name() %></h2>
<h3>Cabs & Bikes Booking</h3>
<hr>

<table>
<tr>
    <th>ID</th>
    <th>Type</th>
    <th>Model</th>
    <th>Price/Day</th>
    <th>Status</th>
    <th>Passengers</th>
    <th>Action</th>
</tr>

<% if(list!=null && !list.isEmpty()){ for(Cab c : list){ %>

<% boolean isBooked = booked.contains(c.getRentalId()); %>

<tr>
    <td><%= c.getRentalId() %></td>
    <td><%= c.getVehicleType() %></td>
    <td><%= c.getModel() %></td>
    <td>₹ <%= c.getPricePerDay() %></td>
    <td style="color:<%= isBooked?"red":"green" %>;">
        <%= isBooked ? "Booked" : "Available" %>
    </td>

    <% if(!isBooked){ %>
    <td>
        <form method="post" action="VehicleListServlet">
            <input type="number" name="passengers" min="1" max="10" required>
    </td>
    <td>
            <input type="hidden" name="rentalId" value="<%=c.getRentalId()%>">
            <button type="submit" class="book-btn">Book Now</button>
        </form>
    </td>
    <% } else { %>
        <td colspan="2" style="color:red;font-weight:bold;">Not Available</td>
    <% } %>
</tr>

<% } } else{ %>
<tr><td colspan="7" style="color:red;">No Vehicles Found</td></tr>
<% } %>
</table>

<h3 style="color:blue;"><%= request.getAttribute("message")==null?"":request.getAttribute("message") %></h3>

</body>
</html>
