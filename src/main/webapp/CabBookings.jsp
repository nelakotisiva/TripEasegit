<%@ page import="java.util.*" %>
<%@ page import="dtopackage.com.Cab" %>

<!DOCTYPE html>
<html>
<head>
<title>My Booked Cabs</title>

<style>
body{
    margin:0;
    background:linear-gradient(135deg,#667eea,#764ba2);
    font-family:Segoe UI;
    padding:40px;
}

.container{
    max-width:1100px;
    margin:auto;
    background:#fff;
    padding:30px;
    border-radius:18px;
    box-shadow:0 12px 30px rgba(0,0,0,0.25);
}

h2{
    text-align:center;
    margin-bottom:25px;
}

.table{
    width:100%;
    border-collapse:collapse;
}

th,td{
    padding:12px;
    text-align:center;
}

th{
    background:#4a00e0;
    color:white;
}

tr:nth-child(even){
    background:#f4f4f4;
}

img{
    border-radius:10px;
}

.cancel-btn{
    background:#ff3d3d;
    color:white;
    border:none;
    padding:8px 16px;
    border-radius:6px;
    cursor:pointer;
    font-weight:600;
}

.back-btn{
    display:block;
    width:200px;
    margin:25px auto 0;
    text-align:center;
    text-decoration:none;
    background:#00c6ff;
    color:white;
    padding:12px;
    border-radius:8px;
    font-weight:600;
}
</style>

</head>

<body>

<div class="container">

<h2>My Booked Cabs</h2>

<table class="table">
<tr>
    <th>Image</th>
    <th>Model</th>
    <th>Seater</th>
    <th>Price</th>
    <th>Location</th>
    <th>Action</th>
</tr>

<%
    List<Cab> list = (List<Cab>) request.getAttribute("bookedCabs");

    if (list != null && !list.isEmpty()) {
        for (Cab c : list) {
%>

<tr>
    <td>
        <img src="<%= c.getImageUrl() %>" width="120" height="75">
    </td>
    <td><%= c.getModel() %></td>
    <td><%= c.getSeaterType() %></td>
    <td>₹ <%= c.getPricePerDay() %></td>
    <td><%= c.getLocation() %></td>

    <td>
        <form method="post" action="CabBookingServlet">
            <input type="hidden" name="rentalId" value="<%= c.getRentalId() %>">
            <button class="cancel-btn">Cancel</button>
        </form>
    </td>
</tr>

<%
        }
    } else {
%>

<tr>
    <td colspan="6">No bookings found</td>
</tr>

<%
    }
%>
</table>

<a class="back-btn" href="VehicleListServlet">⬅ Back to Cabs</a>

</div>

</body>
</html>