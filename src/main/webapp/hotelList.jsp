<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>

<!DOCTYPE html>
<html>
<head>
<title>Hotel Finder</title>

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: #eef3ff;
        margin: 0;
        padding: 0;
    }

    .header {
        background: #0d6efd;
        padding: 22px;
        color: white;
        font-size: 28px;
        text-align: center;
        font-weight: bold;
        box-shadow: 0 3px 7px rgba(0,0,0,0.2);
    }

    .search-box-area {
        text-align: center;
        margin: 30px auto;
    }

    .search-input {
        width: 320px;
        padding: 12px;
        border-radius: 8px;
        border: 2px solid #0d6efd;
        outline: none;
        font-size: 16px;
    }

    .search-btn {
        padding: 12px 20px;
        background: #0d6efd;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin-left: 10px;
        font-size: 16px;
    }

    .search-btn:hover {
        background: #004ab9;
    }

    .message {
        text-align: center;
        font-size: 18px;
        margin-top: 15px;
    }

    .no-result {
        color: red;
        font-weight: bold;
    }

    /* Hotel Card Grid */
    .hotel-grid {
        width: 90%;
        margin: 25px auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        grid-gap: 20px;
    }

    /* Individual Hotel Card */
    .hotel-card {
        background: white;
        padding: 18px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        transition: transform 0.25s ease, box-shadow 0.25s ease;
    }

    .hotel-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 22px rgba(0,0,0,0.15);
    }

    .hotel-title {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 8px;
        color: #0d6efd;
    }

    .hotel-info {
        font-size: 15px;
        margin: 6px 0;
        color: #555;
    }

    .price-tag {
        font-size: 20px;
        font-weight: bold;
        color: #28a745;
        margin-top: 10px;
    }

    .availability {
        padding: 8px;
        margin-top: 10px;
        text-align: center;
        border-radius: 8px;
        font-weight: bold;
        font-size: 16px;
    }

    .available {
        background: #d4f8d4;
        color: #1e8f1e;
    }

    .not-available {
        background: #ffd6d6;
        color: #b92323;
    }
</style>

</head>
<body>

<div class="header">🏨 Hotel Finder</div>

<%
    String searched = (String) request.getAttribute("searched");
    if (searched == null) searched = "";
%>

<div class="search-box-area">
    <form action="HotelListServlet" method="get">
        <input type="text" name="location" class="search-input"
               placeholder="Search hotels near..."
               value="<%= searched %>">
        <button class="search-btn">Search</button>
    </form>
</div>

<%
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");

    if (hotels == null && searched.equals("")) {
%>
    <div class="message">🔍 Start searching for hotels near your location.</div>
<%
    }

    if (hotels != null && hotels.isEmpty()) {
%>
    <div class="message no-result">❌ No hotels found for "<%= searched %>"</div>
<%
    }

    if (hotels != null && !hotels.isEmpty()) {
%>

<div class="hotel-grid">

<%
        for (Hotel h : hotels) {
%>

    <div class="hotel-card">
        <div class="hotel-title"><%= h.getHotelName() %></div>

        <div class="hotel-info">📍 Near: <b><%= h.getNearLocation() %></b></div>
        <div class="hotel-info">⭐ Rating: <%= h.getRating() %> / 5</div>
        <div class="hotel-info">📞 Contact: <%= h.getContact() %></div>

        <div class="price-tag">₹ <%= h.getPricePerNight() %> / night</div>

        <div class="availability <%= h.getRoomsAvailable() > 0 ? "available" : "not-available" %>">
            <%= h.getRoomsAvailable() > 0 ? "Available" : "Not Available" %>
        </div>
       <a href="BookHotel?id=<%= h.getHotelId() %>" class="btn">Book Now</a>


        
    </div>

<%
        }
%>

</div>

<%
    }
%>

</body>
</html>
