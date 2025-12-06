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
/* THEME */
:root{
    --bg:#e8f5f3;
    --card:#ffffff;
    --mint:#3ba58b;
    --mint-dark:#2f8a74;
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
    background:linear-gradient(90deg,#013bff,#06b7ff);
    color:#fff;
    box-shadow:0 4px 18px rgba(0,0,0,0.22);
}
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
    background: url('https://i.imgur.com/g4kZkF4.jpeg') center/cover no-repeat,
    linear-gradient(135deg,#021b79,#0575e6);
    background-blend-mode: overlay;
    text-align:center;
    padding:65px 20px 140px;
    color:white;
}
.hero h1{font-size:32px;font-weight:700;margin:0;}
.hero p{margin-top:8px}

/* SEARCH CARD */
.search-card{
    width:90%;
    max-width:1100px;
    margin:-70px auto 20px;
    background:white;
    border-radius:16px;
    padding:16px;
    box-shadow:0 14px 40px rgba(0,0,0,0.20);
}
.tabs{
    display:flex;
    justify-content:center;
    gap:10px;
    padding:8px;
}
.tab{
    padding:8px 16px;
    border-radius:20px;
    font-weight:600;
    cursor:pointer;
    color:black;
}
.tab.active{background:var(--mint);color:white}

.search-form{display:none;flex-direction:column;gap:15px;margin-top:15px}
.search-form.active{display:flex}
.form-row{display:flex;gap:12px;flex-wrap:wrap}
.field{flex:1}
.field input{
    width:100%;padding:10px;border-radius:8px;border:1px solid #cfd4ff;background:#f8fbfa;
}
.btn-primary{
    background:linear-gradient(90deg,#ff4b2b,#ff416c);
    color:white;border:none;padding:10px 20px;border-radius:8px;font-weight:600;
    cursor:pointer;
}

/* GRID CARDS */
.section-title{
    width:90%;margin:auto;
    margin-bottom:10px;
    font-size:20px;
    font-weight:700;
    color:var(--teal);
}
.grid{
    width:90%;max-width:1100px;margin:auto;
    display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:20px;margin-bottom:40px;
}
.card{
    background:white;border-radius:14px;overflow:hidden;cursor:pointer;
    box-shadow:0 6px 22px rgba(0,0,0,0.1);
    transition:0.3s;
}
.card:hover{transform:translateY(-6px)}
.media{
    height:160px;background-size:cover;background-position:center;
    transition:0.4s;
}
.card:hover .media{transform:scale(1.07)}
.card .body{text-align:center;padding:14px}
.card h3{margin:0;font-size:18px;color:var(--teal)}
.card p{margin:6px 0 0;color:var(--muted)}
</style>

<script>
function showForm(tab){
    document.querySelectorAll(".tab").forEach(e=>e.classList.remove("active"));
    document.querySelectorAll(".search-form").forEach(e=>e.classList.remove("active"));
    
    document.getElementById("tab-"+tab).classList.add("active");
    document.getElementById(tab+"Form").classList.add("active");
}
</script>

</head>
<body>

<nav>
    <div class="logo">✈ TripEase</div>
    <div class="nav-links">
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="HotelListServlet">Hotels</a>
        <a href="VehicleListServlet">Cabs</a>
        <a href="RestaurantListServlet">Restaurants</a>
        <a href="MyBookingsServlet">Bookings</a>
    </div>
    <a class="logout-btn" href="LogoutServlet">Logout</a>
</nav>

<section class="hero">
    <h1>Welcome, <%= userObj.getFullname() %> 👋</h1>
    <p>Your Journey Starts Here</p>
</section>

<div class="search-card">

    <div class="tabs">
        <div class="tab active" id="tab-hotels" onclick="showForm('hotels')">🏨 Hotels</div>
        <div class="tab" id="tab-cabs" onclick="showForm('cabs')">🚕 Cabs</div>
        <div class="tab" id="tab-restaurants" onclick="showForm('restaurants')">🍽 Restaurants</div>
    </div>

    <!-- Hotels Search -->
    <form id="hotelsForm" class="search-form active" action="HotelListServlet">
        <div class="form-row">
            <div class="field"><input type="text" name="city" placeholder="City"></div>
        </div>
        <button class="btn-primary">Search Hotels</button>
    </form>

    <!-- Cabs Search -->
    <form id="cabsForm" class="search-form" action="VehicleListServlet">
        <div class="form-row">
            <div class="field"><input type="text" name="location" placeholder="Location" required></div>
        </div>
        <button class="btn-primary">Search Cabs</button>
    </form>

    <!-- Restaurants Search -->
    <form id="restaurantsForm" class="search-form" action="nearbyRestaurants">
        <div class="form-row">
            <div class="field"><input type="text" name="location" placeholder="Area / City"></div>
        </div>
        <button class="btn-primary">Find Restaurants</button>
    </form>
</div>

<div class="section-title">Explore</div>

<div class="grid">

    <div class="card" onclick="location.href='HotelListServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/U8e7gbL.jpeg')"></div>
        <div class="body"><h3>Hotels</h3><p>Comfortable stays</p></div>
    </div>

    <div class="card" onclick="location.href='VehicleListServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/zHbwGDW.jpeg')"></div>
        <div class="body"><h3>Cabs</h3><p>Affordable rides</p></div>
    </div>

    <div class="card" onclick="location.href='RestaurantListServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/9KxN1DA.jpeg')"></div>
        <div class="body"><h3>Restaurants</h3><p>Delicious destinations</p></div>
    </div>

    <div class="card" onclick="location.href='MyBookingsServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/wxYPD2j.jpeg')"></div>
        <div class="body"><h3>My Bookings</h3><p>Your past & upcoming trips</p></div>
    </div>

</div>

</body>
</html>
