<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Hotels</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== BODY ===== */
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:linear-gradient(180deg,#e8f5f3,#ffffff);
    color:#1f3a3d;
}

/* ===== HEADER (ONLY THIS HAS IMAGE) ===== */
.header{
    height:240px;
    background:
        linear-gradient(
            rgba(0,0,0,0.45),
            rgba(0,0,0,0.45)
        ),
        url("https://static.vecteezy.com/system/resources/previews/035/874/268/non_2x/online-holiday-travel-mobile-app-concept-suitable-for-wallpaper-banner-background-card-book-illustration-web-and-landing-page-concept-illustration-in-flat-style-vector.jpg");

    background-size:cover;
    background-position:center;

    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    color:white;

    border-bottom-left-radius:30px;
    border-bottom-right-radius:30px;
}

.header h1{
    font-size:36px;
    margin:0;
    font-weight:800;
    text-shadow:0 6px 20px rgba(0,0,0,.6);
}

/* ===== SEARCH ===== */
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

/* ===== CONTAINER ===== */
.container{
    width:92%;
    max-width:1200px;
    margin:-40px auto 50px;
}

/* ===== BACK BUTTONS ===== */
.back-wrap{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin:25px 0 10px;
}

.back-btn-page{
    display:inline-flex;
    align-items:center;
    gap:8px;
    background:linear-gradient(135deg,#3ba58b,#2f8a74);
    color:white;
    padding:10px 22px;
    border-radius:999px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    box-shadow:0 8px 20px rgba(59,165,139,.35);
    transition:.3s;
}

.back-btn-page:hover{
    transform:translateX(-4px);
    box-shadow:0 12px 28px rgba(59,165,139,.45);
}

/* ===== GRID ===== */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:24px;
    margin-top:30px;
}

/* ===== CARD ===== */
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

/* ===== INFO ===== */
.info{
    text-align:center;
    font-size:20px;
    margin-top:40px;
    color:#4c7f78;
    font-weight:600;
}
</style>
</head>

<body>

<!-- BOOKING SUCCESS -->
<%
String bookingSuccess = (String) session.getAttribute("bookingSuccess");
if (bookingSuccess != null) {
%>
<script>
    window.onload = function(){
        alert("<%= bookingSuccess %>");
    }
</script>
<%
session.removeAttribute("bookingSuccess");
}
%>

<!-- HEADER -->
<div class="header">
    <h1> Find Your Perfect Stay</h1>

    <form action="HotelListServlet" method="get" class="search-box">
        <input type="text" name="location"
               placeholder="Search hotels by city"
               value="<%= request.getAttribute("searched") == null ? "" : request.getAttribute("searched") %>">
        <button>Search</button>
    </form>
</div>

<div class="container">

<!-- BACK BUTTONS -->
<div class="back-wrap">
    <a href="Dashboard.jsp" class="back-btn-page">← Back to Dashboard</a>

    <%
    if (session.getAttribute("userObj") != null) {
    %>
    <a href="MyHotelBookings" class="back-btn-page">🏨 My Hotel Bookings</a>
    <%
    }
    %>
</div>

<%
List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
String searched = (String) request.getAttribute("searched");

if (searched == null || searched.isEmpty()) {
%>
    <div class="info">🔍 Search hotels by city to continue</div>
<%
}
else if (hotels == null || hotels.isEmpty()) {
%>
    <div class="info">❌ No hotels found in "<%= searched %>"</div>
<%
}
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

</body>
</html>
