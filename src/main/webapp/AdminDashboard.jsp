<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    int totalUsers         = session.getAttribute("totalUsers") != null ? (int)session.getAttribute("totalUsers") : 0;
    int totalBookings      = session.getAttribute("totalBookings") != null ? (int)session.getAttribute("totalBookings") : 0;
    int totalDestinations  = session.getAttribute("totalDestinations") != null ? (int)session.getAttribute("totalDestinations") : 0;
    int totalPayments      = session.getAttribute("totalPayments") != null ? (int)session.getAttribute("totalPayments") : 0;

    int totalHotels        = session.getAttribute("totalHotels") != null ? (int)session.getAttribute("totalHotels") : 0;
    int totalRestaurants   = session.getAttribute("totalRestaurants") != null ? (int)session.getAttribute("totalRestaurants") : 0;
    int totalCabs          = session.getAttribute("totalCabs") != null ? (int)session.getAttribute("totalCabs") : 0;
    int totalReviews       = session.getAttribute("totalReviews") != null ? (int)session.getAttribute("totalReviews") : 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        background: #eef2ff;
    }

    /* SIDEBAR */
    .sidebar {
        width: 250px;
        height: 100vh;
        background: linear-gradient(180deg, #013bff, #0051ff);
        color: white;
        position: fixed;
        padding: 30px 20px;
        box-shadow: 0 0 20px rgba(0,0,0,0.2);
    }
    .sidebar h2 {
        font-size: 24px;
        margin-bottom: 25px;
        text-align: center;
    }
    .sidebar a {
        display: block;
        text-decoration: none;
        padding: 12px;
        margin: 10px 0;
        border-radius: 10px;
        color: white;
        background: rgba(255,255,255,0.08);
        transition: 0.3s;
        font-weight: 500;
    }
    .sidebar a:hover, .active {
        background: rgba(255,255,255,0.22);
    }

    /* CONTENT */
    .main {
        margin-left: 270px;
        padding: 25px;
    }

    .welcome {
        font-size: 26px;
        font-weight: 600;
        color: #013bff;
        margin-bottom: 25px;
    }

    /* CARDS GRID */
    .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
        gap: 22px;
    }

    .card {
        background: white;
        padding: 25px;
        border-radius: 18px;
        box-shadow: 0 6px 16px rgba(0,0,0,0.15);
        text-align: left;
        position: relative;
        overflow: hidden;
        transition: 0.25s;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 22px rgba(0,0,0,0.22);
    }

    .emoji {
        font-size: 40px;
        position: absolute;
        top: 18px;
        right: 18px;
        opacity: 0.25;
    }

    .card-title {
        font-size: 15px;
        font-weight: 600;
        color: #013bff;
        margin-bottom: 8px;
    }

    .card-value {
        font-size: 28px;
        font-weight: 700;
        color: #222;
    }

    /* CHART BOX */
    .chart-box {
        margin-top: 35px;
        background: white;
        padding: 25px;
        border-radius: 18px;
        box-shadow: 0 6px 16px rgba(0,0,0,0.15);
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>⚙ Admin</h2>
    <a class="active">Dashboard</a>
    <a href="ManageUsers">👤 Manage Users</a>
    <a href="ManageDestinations">📍 Manage Destinations</a>
    <a href="ManageBookings">📦 Manage Bookings</a>
    <a href="ManagePayments">💳 Manage Payments</a>
    <a href="ManageHotels">🏨 Manage Hotels</a>
    <a href="ManageRestaurants">🍽 Manage Restaurants</a>
    <a href="ManageCabs">🚕 Manage Cab Rentals</a>
    <a href="ManageReviews">⭐ Manage Reviews</a>
    <a href="AdminLogoutServlet" style="background:#ff2e2e;margin-top:20px;">🚪 Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">
    <div class="welcome">Welcome back, Admin 👋</div>

    <!-- DASHBOARD CARDS -->
    <div class="cards">

        <div class="card">
            <div class="emoji">👤</div>
            <div class="card-title">Total Users</div>
            <div class="card-value"><%= totalUsers %></div>
        </div>

        <div class="card">
            <div class="emoji">📦</div>
            <div class="card-title">Total Bookings</div>
            <div class="card-value"><%= totalBookings %></div>
        </div>

        <div class="card">
            <div class="emoji">📍</div>
            <div class="card-title">Total Destinations</div>
            <div class="card-value"><%= totalDestinations %></div>
        </div>

        <div class="card">
            <div class="emoji">💰</div>
            <div class="card-title">Total Payments</div>
            <div class="card-value">₹ <%= totalPayments %></div>
        </div>

        <div class="card">
            <div class="emoji">🏨</div>
            <div class="card-title">Total Hotels</div>
            <div class="card-value"><%= totalHotels %></div>
        </div>

        <div class="card">
            <div class="emoji">🍽</div>
            <div class="card-title">Total Restaurants</div>
            <div class="card-value"><%= totalRestaurants %></div>
        </div>

        <div class="card">
            <div class="emoji">🚕</div>
            <div class="card-title">Total Cab Rentals</div>
            <div class="card-value"><%= totalCabs %></div>
        </div>

        <div class="card">
            <div class="emoji">⭐</div>
            <div class="card-title">Total Reviews</div>
            <div class="card-value"><%= totalReviews %></div>
        </div>

    </div>

    <!-- CHART -->
    <div class="chart-box">
        <h3 style="margin-bottom:15px;">📊 System Overview</h3>
        <canvas id="overviewChart"></canvas>
    </div>

</div>

<script>
const ctx = document.getElementById("overviewChart");

new Chart(ctx, {
    type: "bar",
    data: {
        labels: ["Users","Bookings","Destinations","Payments","Hotels","Restaurants","Cabs","Reviews"],
        datasets: [{
            label: "Counts",
            data: [
                <%= totalUsers %>,
                <%= totalBookings %>,
                <%= totalDestinations %>,
                <%= totalPayments %>,
                <%= totalHotels %>,
                <%= totalRestaurants %>,
                <%= totalCabs %>,
                <%= totalReviews %>
            ],
            backgroundColor: "rgba(1,59,255,0.2)",
            borderColor: "rgba(1,59,255,0.8)",
            borderWidth: 2
        }]
    },
    options: {
        responsive: true,
        scales: { y: { beginAtZero: true } }
    }
});
</script>

</body>
</html>
