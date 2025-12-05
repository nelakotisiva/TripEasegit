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
}
.tab.active{background:var(--mint);color:white}

.search-form{display:none;flex-direction:column;gap:15px}
.form-row{display:flex;gap:12px;flex-wrap:wrap}
.field{flex:1}
.field input, select{
    width:100%;padding:10px;border-radius:8px;border:1px solid #cfd4ff;background:#f8fbfa;
}
.btn{
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

/* SUCCESS POP-UP */
.success-popup{
    position:fixed;
    top:50%; left:50%;
    transform:translate(-50%,-50%);
    background:white;
    border-radius:16px;
    padding:25px 30px;
    text-align:center;
    box-shadow:0 10px 40px rgba(0,0,0,0.25);
    display:none;
    animation:fadeIn 0.4s ease-out;
    z-index:9999;
}
.success-popup .icon{
    font-size:50px;
    color:var(--mint);
}
@keyframes fadeIn{
    from{opacity:0;transform:translate(-50%,-60%)}
    to{opacity:1;transform:translate(-50%,-50%)}
}

/* PAGE LOADING SPINNER */
#loader{
    position:fixed;
    top:0;left:0;width:100%;height:100%;
    background:rgba(255,255,255,0.8);
    display:flex;
    justify-content:center;
    align-items:center;
    z-index:99999;
}
.loader-circle{
    width:45px;height:45px;
    border:5px solid #cde6ff;
    border-top-color:#013bff;
    border-radius:50%;
    animation:spin 1s linear infinite;
}
@keyframes spin{to{transform:rotate(360deg)}}
</style>

<script>
/* LOADER */
window.onload = function(){
    document.getElementById('loader').style.display = "none";

    <% if ("success".equals(request.getParameter("msg"))) { %>
        showSuccessPopup();
    <% } %>
};

function showForm(tabKey){
    document.querySelectorAll('.tab').forEach(t=>t.classList.remove('active'));
    document.querySelectorAll('.search-form').forEach(f=>f.style.display='none');
    
    document.getElementById('tab-'+tabKey).classList.add('active');
    document.getElementById(tabKey+'Form').style.display='flex';
}

function showSuccessPopup(){
    let popup = document.getElementById("successBox");
    popup.style.display = "block";
    setTimeout(()=> popup.style.display="none", 3000);
}
</script>

</head>
<body>

<!-- PAGE LOADER -->
<div id="loader">
    <div class="loader-circle"></div>
</div>

<!-- POPUP -->
<div id="successBox" class="success-popup">
    <div class="icon">✔</div>
    <h3>Booking Confirmed!</h3>
</div>

<nav>
    <div class="logo">✈ TripEase</div>
    <div class="nav-links">
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="Hotels.jsp">Hotels</a>
        <a href="Flights.jsp">Flights</a>
        <a href="Cabs.jsp">Cabs</a>
        <a href="Restaurants.jsp">Restaurants</a>
    </div>
    <a class="logout-btn" href="LogoutServlet">Logout</a>
</nav>

<section class="hero">
    <h1>Your Journey Starts Here</h1>
    <p>Book hotels, flights, cabs & restaurants easily</p>
</section>

<div class="search-card">
    <div class="tabs">
        <div class="tab active" id="tab-flights" onclick="showForm('flights')">✈️ Flights</div>
        <div class="tab" id="tab-hotels" onclick="showForm('hotels')">🏨 Hotels</div>
        <div class="tab" id="tab-cabs" onclick="showForm('cabs')">🚕 Cabs</div>
        <div class="tab" id="tab-restaurants" onclick="showForm('restaurants')">🍽 Restaurants</div>
    </div>

    <!-- Forms -->
    <div class="search-forms">
        <form id="flightsForm" class="search-form active" method="get" action="SearchFlight">
            <div class="form-row">
                <div class="field"><input type="text" name="fromCity" placeholder="From" required></div>
                <div class="field"><input type="text" name="toCity" placeholder="To" required></div>
                <div class="field"><input type="date" name="departureDate" required></div>
            </div>
            <div class="search-btn-row">
                <button type="submit" class="btn-primary">Search Flights</button>
            </div>
        </form>

        <form id="hotelsForm" class="search-form" method="get" action="HotelListServlet">
            <div class="form-row">
                <div class="field"><input type="text" name="city" placeholder="City"></div>
            </div>
            <button type="submit" class="btn-primary">Search Hotels</button>
        </form>

        <form id="cabsForm" class="search-form" method="get" action="VehicleListServlet">
            <div class="form-row">
                <div class="field"><input type="text" name="pickup" placeholder="Pickup"></div>
            </div>
            <button type="submit" class="btn-primary">Search Cabs</button>
        </form>

        <form id="restaurantsForm" class="search-form" method="get" action="nearbyRestaurants">
            <div class="form-row">
                <div class="field"><input type="text" name="location" placeholder="Location"></div>
            </div>
            <button type="submit" class="btn-primary">Search Restaurants</button>
        </form>
        <div>
       <button type="button" onclick="window.location.href='tourpackage.jsp'">
    Tour packages
</button>
</div>
    </div>
    <!-- FLIGHTS -->
    <form id="flightsForm" class="search-form" style="display:flex">
        <div class="form-row">
            <div class="field"><input type="text" placeholder="From"></div>
            <div class="field"><input type="text" placeholder="To"></div>
            <div class="field"><input type="date"></div>
        </div>
        <div style="text-align:center"><button class="btn">Search Flights</button></div>
    </form>

    <!-- HOTELS -->
    <form id="hotelsForm" class="search-form" method="get" action="HotelListServlet">
        <div class="form-row">
            <div class="field"><input type="text" name="location" placeholder="City"></div>
        </div>
        <div style="text-align:center"><button class="btn">Search Hotels</button></div>
    </form>

    <!-- CABS -->
    <form id="cabsForm" class="search-form" method="get" action="VehicleListServlet">
        <div class="form-row">
            <div class="field"><input type="text" name="pickup" placeholder="Pickup"></div>
            <div class="field"><input type="text" name="drop" placeholder="Drop"></div>
        </div>
        <div style="text-align:center"><button class="btn">Search Cabs</button></div>
    </form>

    <!-- RESTAURANTS -->
    <form id="restaurantsForm" class="search-form" method="get" action="nearbyRestaurants">
        <div class="form-row">
            <div class="field"><input type="text" name="location" placeholder="Area / City"></div>
        </div>
        <div style="text-align:center"><button class="btn">Find Restaurants</button></div>
    </form>
</div>

<div class="section-title">Explore</div>

<div class="grid">

    <div class="card" onclick="location.href='Hotels.jsp'">
        <div class="media" style="background-image:url('https://i.imgur.com/U8e7gbL.jpeg')"></div>
        <div class="body"><h3>Hotels</h3><p>Find stays from budget to luxury</p></div>
    </div>

    <div class="card" onclick="location.href='Flights.jsp'">
        <div class="media" style="background-image:url('https://i.imgur.com/biCj8V8.jpeg')"></div>
        <div class="body"><h3>Flights</h3><p>Search & compare best airfares</p></div>
    </div>

    <div class="card" onclick="location.href='Cabs.jsp'">
        <div class="media" style="background-image:url('https://i.imgur.com/zHbwGDW.jpeg')"></div>
        <div class="body"><h3>Cabs</h3><p>Affordable rides anywhere</p></div>
    </div>

    <div class="card" onclick="location.href='Restaurants.jsp'">
        <div class="media" style="background-image:url('https://i.imgur.com/9KxN1DA.jpeg')"></div>
        <div class="body"><h3>Restaurants</h3><p>Discover trending places to eat</p></div>
    </div>

    <div class="card" onclick="location.href='MyBookingsServlet'">
        <div class="media" style="background-image:url('https://i.imgur.com/wxYPD2j.jpeg')"></div>
        <div class="body"><h3>My Bookings</h3><p>View all your reservations</p></div>
    </div>

</div>

</body>
</html>
