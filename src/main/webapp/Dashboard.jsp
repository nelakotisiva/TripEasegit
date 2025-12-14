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

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
:root{
    --bg:#eef6ff;
    --card:#ffffff;
    --primary:#007aff;
    --primary-dark:#0059c1;
    --teal:#1f3a3d;
    --muted:#6c757d;
}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:var(--bg);
}

/* NAVBAR */
nav{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:14px 30px;
    background:linear-gradient(90deg,#005bea,#00c6fb);
    color:#fff;
    box-shadow:0 4px 18px rgba(0,0,0,0.22);
}

.logo{font-size:22px;font-weight:700}

.nav-links a{
    color:white;
    text-decoration:none;
    margin:0 12px;
    font-weight:600;
}

.logout-btn{
    background:#ff2b2b;
    padding:8px 14px;
    border-radius:8px;
    text-decoration:none;
    color:white;
    font-weight:600;
}

/* HERO */
.hero{
    background:url('https://i.imgur.com/g4kZkF4.jpeg') center/cover no-repeat,
    linear-gradient(135deg,#002f8f,#0086ff);
    background-blend-mode:overlay;
    text-align:center;
    padding:70px 20px 150px;
    color:white;
}

.hero h1{font-size:34px;margin:0}
.hero p{margin-top:10px;font-size:15px}

/* SEARCH CARD */
.search-card{
    width:90%;
    max-width:1100px;
    margin:-90px auto 30px;
    background:white;
    padding:18px;
    border-radius:18px;
    box-shadow:0 20px 45px rgba(0,0,0,0.22);
}

/* GRID */
.section-title{
    width:90%;
    max-width:1100px;
    margin:20px auto 12px;
    font-size:22px;
    font-weight:700;
    color:var(--teal);
}

.grid{
    width:90%;
    max-width:1100px;
    margin:auto;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:22px;
    margin-bottom:60px;
}

.card{
    background:white;
    border-radius:16px;
    overflow:hidden;
    cursor:pointer;
    box-shadow:0 10px 26px rgba(0,0,0,0.14);
    transition:.3s;
}

.card:hover{transform:translateY(-8px)}

.media{
    height:170px;
    background-size:cover;
    background-position:center;
}

.body{
    padding:14px;
    text-align:center;
}

.body h3{
    margin:0;
    font-size:18px;
    color:var(--teal);
}

.body p{
    margin-top:6px;
    color:var(--muted);
    font-size:14px;
}

/* PACKAGE BADGE */
.badge{
    background:#ff5722;
    color:white;
    font-size:11px;
    padding:4px 10px;
    border-radius:20px;
    display:inline-block;
    margin-bottom:8px;
}
</style>

</head>
<body>

<!-- NAVBAR -->
<nav>
    <div class="logo">✈ TripEase</div>

    <div class="nav-links">
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="HotelListServlet">Hotels</a>
        <a href="SearchFlight">Flights</a>
        <a href="VehicleListServlet">Cabs</a>
        <a href="nearbyRestaurants">Restaurants</a>
        <a href="ToursServlet">Tours & Packages</a>
        <a href="PlacesServlet">Famous Places</a>
    </div>

    <a class="logout-btn" href="LogoutServlet">Logout</a>
</nav>

<!-- HERO -->
<section class="hero">
    <h1>Your Journey Starts Here</h1>
    <p>Explore hotels, flights, cabs, restaurants & exciting tour packages</p>
</section>

<!-- EXPLORE -->
<div class="section-title">Explore Services</div>

<div class="grid">

    <div class="card" onclick="location.href='HotelListServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/U8e7gbL.jpeg')"></div>
        <div class="body"><h3>Hotels</h3><p>Luxury & budget stays</p></div>
    </div>

    <div class="card" onclick="location.href='SearchFlight'">
        <div class="media" style="background-image:url('https://i.imgur.com/biCj8V8.jpeg')"></div>
        <div class="body"><h3>Flights</h3><p>Best airfares</p></div>
    </div>

    <div class="card" onclick="location.href='VehicleListServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/zHbwGDW.jpeg')"></div>
        <div class="body"><h3>Cabs</h3><p>Affordable rides</p></div>
    </div>

    <div class="card" onclick="location.href='nearbyRestaurants'">
        <div class="media" style="background-image:url('https://i.imgur.com/9KxN1DA.jpeg')"></div>
        <div class="body"><h3>Restaurants</h3><p>Top spots to eat</p></div>
    </div>

</div>

<!-- TOURS & PACKAGES -->
<div class="section-title">Popular Tours & Packages</div>

<div class="grid">

    <div class="card">
        <div class="media" style="background-image:url('https://i.imgur.com/XYFQ8Xj.jpeg')"></div>
        <div class="body">
            <span class="badge">Best Seller</span>
            <h3>Goa Beach Package</h3>
            <p>3 Nights · 4 Days · Starting ₹9,999</p>
        </div>
    </div>

    <div class="card">
        <div class="media" style="background-image:url('https://i.imgur.com/v6ZkYp5.jpeg')"></div>
        <div class="body">
            <span class="badge">Honeymoon</span>
            <h3>Manali & Shimla</h3>
            <p>5 Nights · 6 Days · Starting ₹18,500</p>
        </div>
    </div>

    <div class="card">
        <div class="media" style="background-image:url('https://i.imgur.com/R3jylUn.jpeg')"></div>
        <div class="body">
            <span class="badge">Adventure</span>
            <h3>Kerala Backwaters</h3>
            <p>4 Nights · 5 Days · Starting ₹15,999</p>
        </div>
    </div>

</div>

</body>
</html>
