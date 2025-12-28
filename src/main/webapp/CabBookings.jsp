<%@ page import="java.util.*" %>
<%@ page import="dtopackage.com.Cab" %>

<!DOCTYPE html>
<html>
<head>
<title>My Booked Cabs</title>

<style>
body{
    margin:0;
    padding:40px;
    background:#f1f5f9;
    font-family:Arial, sans-serif;
}
.container{
    max-width:1100px;
    margin:auto;
    background:#fff;
    padding:30px;
    border-radius:10px;
}
h2{text-align:center;margin-bottom:20px;}
table{width:100%;border-collapse:collapse;}
th, td{
    padding:12px;
    border:1px solid #ddd;
    text-align:center;
}
th{background:#2563eb;color:white;}

.cancel-btn{
    background:#ef4444;
    color:white;
    border:none;
    padding:8px 14px;
    border-radius:4px;
    cursor:pointer;
}

.cancelled{
    color:red;
    font-weight:bold;
}

.back-btn{
    display:block;
    width:200px;
    margin:20px auto 0;
    text-align:center;
    background:#2563eb;
    color:white;
    padding:10px;
    border-radius:6px;
    text-decoration:none;
}
</style>
</head>

<body>

<div class="container">
<h2>🚕 My Booked Cabs</h2>

<table>
<tr>
    <th>Model</th>
    <th>Location</th>
    <th>Price</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
List<Cab> list = (List<Cab>) request.getAttribute("bookedCabs");

if(list != null && !list.isEmpty()){
    for(Cab c : list){
%>
<tr>
    <td><%= c.getModel() %></td>
    <td><%= c.getLocation() %></td>
    <td>₹ <%= c.getPricePerDay() %></td>

    <!-- STATUS -->
    <td>
        <%= c.getStatus() %>
    </td>

    <!-- ACTION -->
    <td>
        <% if(!"Cancelled".equalsIgnoreCase(c.getStatus())){ %>
            <form action="CabBookingServlet" method="post">
                <input type="hidden" name="bookingId" value="<%= c.getBookingId() %>">
                <button type="submit" class="cancel-btn">Cancel</button>
            </form>
        <% } else { %>
            <span class="cancelled">❌ Cancelled</span>
        <% } %>
    </td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="5">No bookings found</td>
</tr>
<%
}
%>
</table>

<a class="back-btn" href="Dashboard.jsp">⬅ Back to Dashboard</a>
</div>

</body>
</html>
