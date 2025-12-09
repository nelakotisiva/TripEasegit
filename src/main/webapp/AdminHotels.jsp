<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>
<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    if (hotels == null) hotels = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Hotels</title>
    <style>
        body{font-family:Poppins, sans-serif;background:#f3f6ff;padding:20px}
        table{width:100%;border-collapse:collapse;background:#fff;border-radius:10px;overflow:hidden}
        th,td{padding:12px;border-bottom:1px solid #eee;text-align:left}
        th{background:#0047ff;color:#fff}
        img{border-radius:8px}
        .actions a{margin-right:8px;padding:6px 10px;border-radius:6px;text-decoration:none;color:#fff}
        .edit{background:#28a745}
        .del{background:#dc3545}
    </style>
</head>
<body>
    <h2>🏨 Manage Hotels</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Name</th>
            <th>Area</th>
            <th>Price</th>
            <th>Rooms</th>
            <th>Actions</th>
        </tr>
        <% for (Hotel h : hotels) { 
            String img = (h.getImageUrl() != null && !h.getImageUrl().isEmpty()) ? h.getImageUrl()
                        : "https://source.unsplash.com/800x600/?hotel";
        %>
        <tr>
            <td><%= h.getHotelId() %></td>
            <td><img src="<%= img %>" width="120" height="90" alt="img"></td>
            <td><%= h.getHotelName() %></td>
            <td><%= h.getNearLocation() %></td>
            <td>₹ <%= h.getPricePerNight() %></td>
            <td><%= h.getRoomsAvailable() %></td>
            <td class="actions">
                <a class="edit" href="EditHotel?id=<%=h.getHotelId()%>">Edit</a>
                <a class="del" href="DeleteHotel?id=<%=h.getHotelId()%>" onclick="return confirm('Delete this hotel?')">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
