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
    int totalHotels        = session.getAttribute("totalHotels") != null ? (int)session.getAttribute("totalHotels") : 0;
    int totalRestaurants   = session.getAttribute("totalRestaurants") != null ? (int)session.getAttribute("totalRestaurants") : 0;
    int totalCabs          = session.getAttribute("totalCabs") != null ? (int)session.getAttribute("totalCabs") : 0;
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
    background: linear-gradient(to bottom right, #e8f0ff, #cdd9ff);
    overflow-x: hidden;
}

/* SIDEBAR */
.sidebar {
    width: 250px;
    height: 100vh;
    background: rgba(1, 59, 255, 0.95);
    color: white;
    position: fixed;
    padding: 32px 22px;
    box-shadow: 6px 0 20px rgba(0,0,0,0.2);
    border-radius: 0 20px 20px 0;
    backdrop-filter: blur(10px);
}

.sidebar h2 {
    font-size: 28px;
    margin-bottom: 35px;
    font-weight: 700;
    text-align: center;
}

.sidebar a {
    display: block;
    text-decoration: none;
    padding: 14px;
    margin: 12px 0;
    border-radius: 12px;
    color: #fff;
    background: rgba(255,255,255,0.08);
    transition: 0.35s ease;
    font-weight: 500;
    letter-spacing: 0.3px;
}

.sidebar a:hover, .sidebar .active {
    background: rgba(255,255,255,0.25);
    transform: translateX(8px);
}

/* MAIN CONTENT */
.main {
    margin-left: 280px;
    padding: 30px;
}

.welcome {
    font-size: 30px;
    font-weight: 700;
    color: #0032d8;
    margin-bottom: 30px;
    animation: fadeIn 0.8s ease-in-out;
}

/* CARDS */
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
}

.card {
    background: rgba(255,255,255,0.5);
    padding: 28px;
    border-radius: 22px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.10);
    backdrop-filter: blur(12px);
    text-align: left;
    position: relative;
    overflow: hidden;
    transition: 0.35s ease;
}

.card:hover {
    transform: translateY(-10px) scale(1.03);
    box-shadow: 0 18px 32px rgba(0, 0, 0, 0.25);
}

.emoji {
    font-size: 44px;
    position: absolute;
    top: 20px;
    right: 20px;
    opacity: 0.20;
    transition: 0.25s;
}

.card:hover .emoji {
    opacity: 0.45;
    transform: scale(1.15);
}

.card-title {
    font-size: 16px;
    font-weight: 600;
    color: #0032d8;
    margin-bottom: 10px;
}

.card-value {
    font-size: 32px;
    font-weight: 700;
    color: #111;
}

/* CHART BOX */
.chart-box {
    margin-top: 45px;
    background: white;
    padding: 30px;
    border-radius: 25px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    animation: slideUp 0.7s ease-in-out;
}

/* ANIMATIONS */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}
@keyframes slideUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

@media (max-width: 850px) {
    .sidebar {
        width: 220px;
    }
    .main {
        margin-left: 240px;
    }
}
@media (max-width: 650px) {
    .sidebar {
        position: static;
        width: 100%;
        height: auto;
        display: flex;
        gap: 10px;
        border-radius: 0;
    }
    .main {
        margin-left: 0;
        padding: 20px;
    }
}
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>⚙ Admin</h2>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="ManageUsers">👤 Manage Users</a>
    <a href="ManageBookings">📦 Manage Bookings</a>
    <a href="ManageHotels">🏨 Manage Hotels</a>
    <a href="ManageRestaurants">🍽 Manage Restaurants</a>
<a href="AdminManageCabs">🚕 Manage Cab Rentals</a>
    <a href="adminRestaurant?action=list">🍽 Manage Restaurants</a>
    <a href="ManageCabs">🚕 Manage Cab Rentals</a>
    <a href="AdminLogoutServlet" style="background:#ff2e2e;margin-top:20px;">🚪 Logout</a>
</div>


<!-- MAIN CONTENT -->
<div class="main">
    <div class="welcome">Welcome back, Admin 👋</div>

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

    </div>

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
        labels: ["Users","Bookings","Hotels","Restaurants","Cabs"],
        datasets: [{
            label: "Counts",
            data: [
                <%= totalUsers %>,
                <%= totalBookings %>,
                <%= totalHotels %>,
                <%= totalRestaurants %>,
                <%= totalCabs %>
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
