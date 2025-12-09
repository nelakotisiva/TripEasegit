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
    <style>
        body{font-family:Arial;background:#eef3ff;margin:0}
        h2{text-align:center;margin-top:20px}

        .top-bar{
            width:95%;
            margin:20px auto;
            text-align:right;
        }

        .add-btn{
            padding:10px 18px;
            background:#0047ff;
            color:white;
            text-decoration:none;
            border-radius:6px;
            font-weight:bold;
        }

        table{
            width:95%;
            margin:0 auto 30px;
            border-collapse:collapse;
            background:white;
        }

        th,td{
            border:1px solid #ddd;
            padding:10px;
            text-align:center;
        }

        th{
            background:#0047ff;
            color:white;
        }

        img{
            border-radius:6px;
        }

        .btn{
            padding:5px 10px;
            border-radius:5px;
            color:white;
            text-decoration:none;
            font-size:14px;
        }
        .edit{background:green}
        .delete{background:red}
    </style>
</head>
<body>

<h2>🏨 Manage Hotels</h2>

<!-- ✅ ADD HOTEL BUTTON -->
<div class="top-bar">
    <a class="add-btn" href="AddHotel">➕ Add Hotel</a>
</div>

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

<%
    if (hotelList != null && !hotelList.isEmpty()) {
        for (Hotel h : hotelList) {
%>
<tr>
    <td><%= h.getHotelId() %></td>

    <!-- ✅ IMAGE FIX (NO img ICON EVER) -->
    <td>
        <img src="<%= h.getImageUrl() %>"
             width="100"
             onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
    </td>

    <td><%= h.getHotelName() %></td>
    <td><%= h.getNearLocation() %></td>
    <td>₹ <%= h.getPricePerNight() %></td>
    <td><%= h.getRoomsAvailable() %></td>

    <td>
        <a class="btn edit" href="EditHotel?id=<%= h.getHotelId() %>">Edit</a>
        <a class="btn delete"
           href="DeleteHotel?id=<%= h.getHotelId() %>"
           onclick="return confirm('Delete this hotel?')">Delete</a>
    </td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="7">No Hotels Found</td>
</tr>
<%
    }
%>

</table>

</body>
</html>
