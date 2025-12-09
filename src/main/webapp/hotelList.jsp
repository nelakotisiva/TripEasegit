<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hotel Finder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- FONT -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* ========== SOFT MINT THEME ========== */
        :root{
            --mint-light:#e8f5f3;
            --mint:#3ba58b;
            --mint-dark:#2e8e77;
            --text:#1f3a3d;
            --card:#ffffff;
        }

        body {
            font-family:'Poppins', sans-serif;
            margin:0;
            background:linear-gradient(180deg,var(--mint-light),#f7fffd);
            color:var(--text);
        }

        /* ========== HEADER / HERO ========== */
        .header {
            height:220px;
            background:
              linear-gradient(rgba(59,165,139,.85),rgba(59,165,139,.85)),
              url("https://images.unsplash.com/photo-1566073771259-6a8506099945");
            background-size:cover;
            background-position:center;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:32px;
            font-weight:800;
            color:white;
            text-shadow:0 6px 18px rgba(0,0,0,0.5);
        }

        /* ========== SEARCH ========== */
        .search-area {
            text-align:center;
            margin:-40px auto 30px;
        }

        .search-area form{
            display:inline-flex;
            gap:12px;
            padding:16px;
            background:rgba(255,255,255,0.95);
            border-radius:18px;
            box-shadow:0 20px 45px rgba(0,0,0,0.12);
        }

        .search-input {
            width:320px;
            padding:12px 14px;
            border-radius:12px;
            border:1px solid #cfe6df;
            font-size:14px;
        }

        .search-input:focus{
            outline:none;
            border-color:var(--mint);
        }

        .search-btn {
            padding:12px 22px;
            background:linear-gradient(135deg,var(--mint),#06b7ff);
            border:none;
            border-radius:12px;
            color:white;
            cursor:pointer;
            font-weight:700;
        }

        .search-btn:hover{ opacity:.95; }

        /* ========== GRID ========== */
        .hotel-grid {
            width:92%;
            max-width:1200px;
            margin:auto;
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(280px,1fr));
            gap:24px;
        }

        /* ========== HOTEL CARD ========== */
        .hotel-card {
            background:var(--card);
            border-radius:18px;
            overflow:hidden;
            box-shadow:0 12px 32px rgba(34,60,60,0.12);
            transition:.3s ease;
        }

        .hotel-card:hover {
            transform:translateY(-8px);
            box-shadow:0 20px 45px rgba(34,60,60,0.18);
        }

        .hotel-img {
            width:100%;
            height:200px;
            object-fit:cover;
        }

        .hotel-content {
            padding:18px;
            text-align:center;
        }

        .hotel-title {
            font-size:20px;
            font-weight:700;
            color:var(--mint-dark);
            margin-bottom:6px;
        }

        .hotel-content div{
            margin-top:4px;
            font-size:14px;
            color:#456b66;
        }

        .price-tag {
            color:var(--mint);
            font-weight:800;
            font-size:18px;
            margin-top:10px;
        }

        .book-btn {
            display:inline-block;
            margin-top:14px;
            background:linear-gradient(90deg,var(--mint),#06b7ff);
            color:#fff;
            padding:10px 18px;
            text-decoration:none;
            border-radius:14px;
            font-weight:700;
            transition:.25s;
        }

        .book-btn:hover {
            transform:scale(1.05);
            opacity:.95;
        }

        /* ========== NO RESULTS ========== */
        .no-results {
            text-align:center;
            padding:60px 20px;
            font-size:20px;
            color:#486e68;
            font-weight:600;
        }

        @media(max-width:520px){
            .search-input{ width:220px; }
            .header{ font-size:26px; }
        }
    </style>
</head>

<body>

<div class="header">🏨 Find Your Perfect Stay</div>

<%
String searched = (String) request.getAttribute("searched");
if (searched == null) searched = "";
%>

<div class="search-area">
    <form action="HotelListServlet" method="get">
        <input type="text" name="location" class="search-input"
               value="<%= searched %>"
               placeholder="Search hotels by city or area">
        <button class="search-btn">Search</button>
    </form>
</div>

<%
List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");

if (hotels == null || hotels.isEmpty()) {
%>

<div class="no-results">No hotels found. Try “Bangalore”</div>

<%
} else {
%>

<div class="hotel-grid">

<%
for (Hotel h : hotels) {

    String img =
        (h.getImageUrl() != null && !h.getImageUrl().isEmpty())
        ? h.getImageUrl()
        : "https://source.unsplash.com/800x600/?hotel,resort";
%>

    <div class="hotel-card">
        <img class="hotel-img" src="<%= img %>" alt="Hotel Image">

        <div class="hotel-content">
            <div class="hotel-title"><%= h.getHotelName() %></div>
            <div>📍 <%= h.getNearLocation() %></div>
            <div>⭐ <%= h.getRating() %> / 5</div>
            <div class="price-tag">₹ <%= h.getPricePerNight() %> / night</div>

            <a href="BookHotel?id=<%= h.getHotelId() %>" class="book-btn">
                Book Now
            </a>
        </div>
    </div>

<% } %>

</div>

<% } %>

</body>
</html>
