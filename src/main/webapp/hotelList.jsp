<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Hotels</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:linear-gradient(180deg,#e8f5f3,#ffffff);
    color:#1f3a3d;
}

/* HEADER */
.header{
    height:230px;
    background:
        linear-gradient(rgba(59,165,139,.85),rgba(59,165,139,.85)),
        url("https://images.unsplash.com/photo-1566073771259-6a8506099945");
    background-size:cover;
    background-position:center;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    color:white;
}

.header h1{
    font-size:36px;
    margin:0;
    font-weight:800;
}

/* SEARCH */
.search-box{
    margin-top:20px;
    background:white;
    padding:14px;
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,.15);
    display:flex;
    gap:10px;
}

.search-box input{
    padding:12px;
    width:260px;
    border-radius:12px;
    border:1px solid #cfe6df;
    font-size:14px;
}

.search-box button{
    padding:12px 20px;
    background:linear-gradient(90deg,#3ba58b,#06b7ff);
    border:none;
    color:white;
    font-weight:700;
    border-radius:12px;
    cursor:pointer;
}

/* GRID */
.container{
    width:92%;
    max-width:1200px;
    margin:-40px auto 50px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:24px;
    margin-top:30px;
}

/* CARD */
.card{
    background:white;
    border-radius:18px;
    overflow:hidden;
    box-shadow:0 14px 35px rgba(0,0,0,.12);
    transition:.3s;
}
.card:hover{ transform:translateY(-8px); }

.card img{
    width:100%;
    height:200px;
    object-fit:cover;
}

.card-body{
    padding:18px;
    text-align:center;
}

.card-title{
    font-size:20px;
    font-weight:700;
}

.price{
    color:#3ba58b;
    font-weight:800;
    margin-top:8px;
}

.book-btn{
    margin-top:14px;
    display:inline-block;
    background:linear-gradient(90deg,#3ba58b,#06b7ff);
    color:white;
    padding:10px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:700;
}

/* INFO */
.info{
    text-align:center;
    font-size:20px;
    margin-top:40px;
    color:#4c7f78;
    font-weight:600;
}

/* MODAL */
.modal-overlay{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.6);
    display:flex;
    align-items:center;
    justify-content:center;
    z-index:9999;
}

.modal{
    background:white;
    padding:30px;
    border-radius:20px;
    width:90%;
    max-width:380px;
    text-align:center;
}

.modal h2{ color:#2e8e77; }

.modal button{
    padding:10px 18px;
    border:none;
    border-radius:12px;
    font-weight:700;
    cursor:pointer;
    color:white;
}

.back-btn{background:#6c757d;}
.my-btn{background:#3ba58b;}
</style>
</head>

<body>

<!-- HEADER + SEARCH -->
<div class="header">
    <h1>🏨 Find Your Perfect Stay</h1>

    <form action="HotelListServlet" method="get" class="search-box">
        <input type="text" name="location"
               placeholder="Search hotels by city"
               value="<%= request.getAttribute("searched") == null ? "" : request.getAttribute("searched") %>">
        <button>Search</button>
    </form>
</div>

<div class="container">

<%
List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
String searched = (String) request.getAttribute("searched");

/* NO SEARCH YET */
if (searched == null || searched.isEmpty()) {
%>
    <div class="info">🔍 Search hotels by city to continue</div>
<%
}
/* SEARCH BUT NO RESULTS */
else if (hotels == null || hotels.isEmpty()) {
%>
    <div class="info">❌ No hotels found in "<%= searched %>"</div>
<%
}
/* SHOW RESULTS */
else {
%>
<div class="grid">
<%
for (Hotel h : hotels) {
    String img = (h.getImageUrl()!=null && !h.getImageUrl().isEmpty())
            ? h.getImageUrl()
            : "https://source.unsplash.com/800x600/?hotel";
%>
<div class="card">
    <img src="<%= img %>">
    <div class="card-body">
        <div class="card-title"><%= h.getHotelName() %></div>
        <div>📍 <%= h.getNearLocation() %></div>
        <div class="price">₹ <%= h.getPricePerNight() %> / night</div>
        <a href="BookHotel?id=<%= h.getHotelId() %>" class="book-btn">Book Now</a>
    </div>
</div>
<% } %>
</div>
<% } %>

</div>

<!-- ✅ SUCCESS POPUP -->
<%
String bookingSuccess = (String) session.getAttribute("bookingSuccess");
if (bookingSuccess != null) {
%>
<div class="modal-overlay">
    <div class="modal">
        <h2>🎉 Booking Confirmed</h2>
        <p><%= bookingSuccess %></p>

        <div style="display:flex;gap:12px;justify-content:center;margin-top:20px">
            <a href="HotelListServlet"><button class="back-btn">Back</button></a>
           
        </div>
    </div>
</div>
<script>document.body.style.overflow="hidden";</script>
<%
session.removeAttribute("bookingSuccess");
}
%>

</body>
</html>
