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
    <title>TripEase | Book Flights, Hotels, Cabs & Restaurants</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f3f6ff;
        }

        /* NAVBAR */
        nav {
            background: linear-gradient(90deg, #013bff, #06b7ff);
            padding: 14px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #fff;
            box-shadow: 0 4px 18px rgba(0,0,0,0.22);
        }
        .logo {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* USER NAV LINKS */
        .user-info {
            font-size: 16px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .user-info a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
        .user-info a:hover {
            text-decoration: underline;
        }

        /* HERO / BANNER */
        .hero {
            background: url('banner.jpg') center/cover no-repeat, linear-gradient(135deg,#021b79,#0575e6);
            background-blend-mode: overlay;
            color: #fff;
            text-align: center;
            padding: 50px 15px 90px;
        }
        .hero-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .hero-subtitle {
            font-size: 17px;
            font-weight: 400;
            opacity: 0.95;
        }

        /* SEARCH BOX */
        .search-box-wrapper {
            width: 85%;
            max-width: 1100px;
            margin: -60px auto 30px;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 14px 40px rgba(0,0,0,0.25);
            padding: 16px 18px 22px;
        }
        .search-tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            padding: 6px;
            border-radius: 30px;
            background: #f5f7ff;
            width: fit-content;
            margin: 0 auto 15px;
        }
        .tab {
            padding: 8px 18px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            border: 1px solid transparent;
            transition: 0.25s;
        }
        .tab.active {
            background: #013bff;
            color: #fff;
        }

        .search-form {
            display: none;
            flex-direction: column;
            gap: 15px;
        }
        .search-form.active {
            display: flex;
        }

        .form-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .field {
            flex: 1;
            min-width: 180px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .field input,
        .field select {
            padding: 9px 10px;
            border-radius: 8px;
            border: 1px solid #cfd4ff;
        }

        .btn-primary {
            background: linear-gradient(90deg,#ff4b2b,#ff416c);
            color: #fff;
            padding: 10px 22px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
        }

        /* DASHBOARD QUICK LINKS */
        .section-title {
            width: 90%;
            margin: 20px auto 15px;
            font-size: 20px;
            font-weight: 600;
            color: #222;
        }
        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 22px;
            width: 90%;
            margin: 12px auto 30px;
        }
        .card {
            background: #fff;
            padding: 22px;
            text-align: center;
            border-radius: 15px;
            cursor: pointer;
            border-top: 4px solid #013bff;
            box-shadow: 0px 3px 13px rgba(0,0,0,0.12);
            transition: .30s;
        }
        .card:hover {
            transform: translateY(-6px);
        }
        .icon {
            font-size: 38px;
            margin-bottom: 6px;
            color: #013bff;
        }

        /* LOGOUT */
        .logout-btn {
            text-align: center;
            margin: 25px 0 35px;
        }
        .logout-btn a {
            background: #ff2b2b;
            color: #fff;
            padding: 10px 22px;
            border-radius: 10px;
            text-decoration: none;
        }
    </style>

    <script>
        function showForm(tabKey) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.search-form').forEach(f => f.classList.remove('active'));
            document.getElementById('tab-' + tabKey).classList.add('active');
            document.getElementById(tabKey + 'Form').classList.add('active');
        }
        window.onload = () => showForm('flights');
    </script>
</head>

<body>

<nav>
    <div class="logo">✈️ TripEase</div>

    <div class="user-info">
        Hi, <%= userObj.getFull_name() %> 👋 |
        <a href="ProfileServlet" style="display:flex; align-items:center; gap:6px; text-decoration:none; color:#fff;">
            <span style="font-size:20px;">👤</span> Profile
        </a>
    </div>
</nav>


<div class="hero">
    <div class="hero-title">Book Flights, Hotels, Cabs & Dining in one place</div>
    <div class="hero-subtitle">Smart deals, smooth journeys — powered by TripEase</div>
</div>

<div class="search-box-wrapper">
    <!-- Tabs -->
    <div class="search-tabs">
        <div class="tab active" id="tab-flights" onclick="showForm('flights')">✈️ Flights</div>
        <div class="tab" id="tab-hotels" onclick="showForm('hotels')">🏨 Hotels</div>
        <div class="tab" id="tab-cabs" onclick="showForm('cabs')">🚕 Cabs</div>
        <div class="tab" id="tab-restaurants" onclick="showForm('restaurants')">🍽️ Restaurants</div>
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
    </div>
</div>

<div class="section-title">Quick Access</div>
<div class="dashboard-container">

    <div class="card" onclick="showForm('flights')"><div class="icon">✈️</div><div class="card-title">Book Flights</div></div>
    <div class="card" onclick="showForm('hotels')"><div class="icon">🏨</div><div class="card-title">Book Hotels</div></div>
    <div class="card" onclick="showForm('cabs')"><div class="icon">🚕</div><div class="card-title">Book Cabs</div></div>
    <div class="card" onclick="showForm('restaurants')"><div class="icon">🍽️</div><div class="card-title">Find Restaurants</div></div>
    <div class="card" onclick="window.location.href='MyBookingsServlet'"><div class="icon">📜</div><div class="card-title">My Bookings</div></div>
    <div class="card" onclick="window.location.href='PlacesServlet'"><div class="icon">📍</div><div class="card-title">Famous Places</div></div>
    <div class="card" onclick="window.location.href='PackageListServlet'"><div class="icon">🎒</div><div class="card-title">Tour Packages</div></div>

 


</div>

<div class="logout-btn">
    <a href="LogoutServlet">Logout</a>
</div>

</body>
</html>
