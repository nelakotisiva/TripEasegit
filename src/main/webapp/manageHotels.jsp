<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Hotel" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<Hotel> hotelList = (List<Hotel>) request.getAttribute("hotelList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Hotels</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    padding:30px;
    color:#2f2a23;
}

.container{max-width:1200px;margin:auto}

/* HEADER */
.header{
    background:#fff;
    padding:22px 26px;
    border-radius:16px;
    border:1px solid #d9d2c3;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.header h1{margin:0;font-size:26px}

/* BUTTONS */
.btn{
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
    color:white;
}
.back{background:#6b6256}
.add{background:#8a9a5b}

/* TABLE */
.table-box{
    background:#fff;
    padding:22px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}

table{width:100%;border-collapse:collapse}
th{
    background:#f1efe8;
    padding:14px;
}
td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
}

img{border-radius:8px}

/* ACTIONS */
.action-btn{
    padding:6px 12px;
    border-radius:8px;
    color:white;
    text-decoration:none;
    font-weight:600;
}
.edit{background:#8a9a5b}
.delete{background:#b94a48}
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Manage Hotels</h1>
        <div>
            <a href="AdminDashboard.jsp" class="btn back">Back</a>
            <a href="AddHotel" class="btn add">Add Hotel</a>
        </div>
    </div>

    <div class="table-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Location</th>
                <th>Price</th>
                <th>Rooms</th>
                <th>Actions</th>
            </tr>

            <% if (hotelList != null && !hotelList.isEmpty()) {
                for (Hotel h : hotelList) { %>
            <tr>
                <td><%= h.getHotelId() %></td>
                <td>
                    <img src="<%= h.getImageUrl() %>" width="100"
                         onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
                </td>
                <td><%= h.getHotelName() %></td>
                <td><%= h.getNearLocation() %></td>
                <td>₹ <%= h.getPricePerNight() %></td>
                <td><%= h.getRoomsAvailable() %></td>
                <td>
                    <a class="action-btn edit"
                       href="EditHotel?id=<%= h.getHotelId() %>">Edit</a>
                    <a class="action-btn delete"
                       href="DeleteHotel?id=<%= h.getHotelId() %>"
                       onclick="return confirm('Delete this hotel?')">Delete</a>
                </td>
            </tr>
            <% }} else { %>
            <tr><td colspan="7">No Hotels Found</td></tr>
            <% } %>
        </table>
    </div>

</div>

</body>
</html>
