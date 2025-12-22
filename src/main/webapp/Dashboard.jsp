<%@page import="dtopackage.com.User"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User userObj = (User) session.getAttribute("userObj");
    if (userObj == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --primary:#008cff;
    --accent:#f77728;
    --bg:#f4f6f8;
    --card:#ffffff;
    --text:#1f2933;
    --muted:#6b7280;
}

*{box-sizing:border-box}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:var(--bg);
    color:var(--text);
}

/* NAVBAR */
nav{
    background:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:14px 40px;
    box-shadow:0 4px 18px rgba(0,0,0,.08);
    position:sticky;
    top:0;
    z-index:100;
}

.logo{
    font-size:22px;
    font-weight:700;
    color:var(--primary);
}

.nav-links{
    display:flex;
    align-items:center;
}

.nav-links a{
    margin:0 12px;
    text-decoration:none;
    font-weight:500;
    color:#333;
}

.nav-links a:hover{color:var(--primary)}

.logout-btn{
    background:var(--accent);
    color:white;
    padding:8px 16px;
    border-radius:8px;
    text-decoration:none;
    font-weight:600;
}

/* PROFILE ICON */
.profile-icon{
    font-size:20px;
    color:#333;
    margin-left:14px;
    position:relative;
}

.profile-icon:hover{color:var(--primary)}

.profile-icon::after{
    content:"";
    position:absolute;
    top:-2px;
    right:-2px;
    width:8px;
    height:8px;
    background:#22c55e;
    border-radius:50%;
}

/* HERO */
.hero{
    position:relative;
    height:70vh;
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    color:white;
}

.hero video{
    position:absolute;
    inset:0;
    width:100%;
    height:100%;
    object-fit:cover;
    z-index:-2;
}

.hero::after{
    content:"";
    position:absolute;
    inset:0;
    background:rgba(0,0,0,0.55);
    z-index:-1;
}

.hero-content h1{
    font-size:38px;
}

.hero-content p{
    font-size:16px;
}

/* SECTION */
.section-title{
    max-width:1100px;
    margin:40px auto 20px;
    font-size:22px;
    font-weight:700;
}

/* GRID */
.grid{
    max-width:1100px;
    margin:auto;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
    gap:22px;
    padding-bottom:60px;
}

/* CARD */
.card{
    background:var(--card);
    border-radius:16px;
    overflow:hidden;
    box-shadow:0 8px 20px rgba(0,0,0,.1);
    cursor:pointer;
    transition:.3s;
}

.card:hover{
    transform:translateY(-8px);
    box-shadow:0 14px 35px rgba(0,0,0,.18);
}

.card img{
    width:100%;
    height:160px;
    object-fit:cover;
}

.card-body{
    padding:16px;
    text-align:center;
}

.card-body h3{
    margin:0;
    font-size:18px;
}

.card-body p{
    margin-top:6px;
    font-size:14px;
    color:var(--muted);
}

.badge{
    display:inline-block;
    background:var(--accent);
    color:white;
    padding:4px 10px;
    border-radius:20px;
    font-size:11px;
    margin-bottom:8px;
}
</style>
</head>

<body>

<nav>
    <div class="logo">✈ TripEase</div>

    <div class="nav-links">
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="HotelListServlet">Hotels</a>
        <a href="SearchFlight">Flights</a>
        <a href="VehicleListServlet">Cabs</a>
        <a href="nearbyRestaurants">Restaurants</a>
        <a href="tourpackage.jsp">Tours</a>
       
        <a href="MyBookingsServlet">My Bookings</a>

        <a href="ProfileServlet" class="profile-icon" title="My Profile">
            <i class="fa-solid fa-user-circle"></i>
        </a>
    </div>

    <a class="logout-btn" href="LogoutServlet">Logout</a>
</nav>

<section class="hero">
    <video autoplay muted loop playsinline>
        <source src="assets/videos/travel.mp4" type="video/mp4">
    </video>
    <div class="hero-content">
        <h1>Your Journey Starts Here</h1>
        <p>Book hotels, flights, cabs & unforgettable experiences</p>
    </div>
</section>

<div class="section-title">Explore Services</div>
<div class="grid">
    <div class="card" onclick="location.href='HotelListServlet'">
        <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945">
        <div class="card-body"><h3>Hotels</h3><p>Luxury & budget stays</p></div>
    </div>

    <div class="card" onclick="location.href='SearchFlight'">
        <img src="https://images.unsplash.com/photo-1529070538774-1843cb3265df">
        <div class="card-body"><h3>Flights</h3><p>Best airfare deals</p></div>
    </div>

    <div class="card" onclick="location.href='VehicleListServlet'">
        <img src="https://images.unsplash.com/photo-1542362567-b07e54358753">
        <div class="card-body"><h3>Cabs</h3><p>Affordable rides</p></div>
    </div>

    <div class="card" onclick="location.href='nearbyRestaurants'">
        <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9">
        <div class="card-body"><h3>Restaurants</h3><p>Top places to eat</p></div>
    </div>
</div>

<div class="section-title">Popular Tours & Packages</div>
<div class="grid">
    <div class="card">
        <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e">
        <div class="card-body">
            <span class="badge">Best Seller</span>
            <h3>Goa Beach Getaway</h3>
            <p>3N / 4D · From ₹9,999</p>
        </div>
    </div>

    <div class="card">
        <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470">
        <div class="card-body">
            <span class="badge">Honeymoon</span>
            <h3>Manali & Shimla</h3>
            <p>5N / 6D · From ₹18,500</p>
        </div>
    </div>

    <div class="card">
        <img src="https://images.unsplash.com/photo-1518684079-3c830dcef090">
        <div class="card-body">
            <span class="badge">Adventure</span>
            <h3>Kerala Backwaters</h3>
            <p>4N / 5D · From ₹15,999</p>
        </div>
    </div>
</div>

<!-- ✅ FOOTER INCLUDE (your existing footer.jsp) -->
<jsp:include page="footer.jsp"/>

</body>
</html>
