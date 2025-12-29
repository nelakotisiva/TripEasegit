<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    int totalUsers       = session.getAttribute("totalUsers") != null ? (int)session.getAttribute("totalUsers") : 0;
    int totalBookings    = session.getAttribute("totalBookings") != null ? (int)session.getAttribute("totalBookings") : 0;
    int totalHotels      = session.getAttribute("totalHotels") != null ? (int)session.getAttribute("totalHotels") : 0;
    int totalRestaurants = session.getAttribute("totalRestaurants") != null ? (int)session.getAttribute("totalRestaurants") : 0;
    int totalCabs        = session.getAttribute("totalCabs") != null ? (int)session.getAttribute("totalCabs") : 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root{
    /* EARTHY PREMIUM PALETTE */
    --panel:#ffffff;
    --panel-soft:#ffffff;
    --text:#2f2a23;
    --muted:#5f574a;
    --accent:#8a9a5b;
    --border:#d9d2c3;
}

*{box-sizing:border-box}

body{
    margin:0;
    font-family:'Inter',sans-serif;
    background:
        linear-gradient(
            rgba(245,240,230,0.45),
            rgba(245,240,230,0.45)
        ),
        url("https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1900&q=80");
    background-size:cover;
    background-position:center;
    background-attachment:fixed;
    color:var(--text);
}

/* LAYOUT */
.layout{
    display:grid;
    grid-template-columns:240px 1fr;
    min-height:100vh;
}

/* SIDEBAR */
.sidebar{
    background:var(--panel);
    border-right:1px solid var(--border);
    padding:32px 22px;
}

.brand{
    font-size:22px;
    font-weight:700;
    margin-bottom:34px;
    color:var(--accent);
}

.nav a{
    display:block;
    padding:10px 14px;
    margin-bottom:8px;
    text-decoration:none;
    color:var(--muted);
    border-radius:10px;
    font-size:14px;
    transition:.25s ease;
}

.nav a:hover{
    background:rgba(138,154,91,0.15);
    color:var(--text);
}

.logout{
    margin-top:26px;
    color:#a94442 !important;
}

/* MAIN */
.main{
    padding:38px 44px;
}

/* HEADER (FIXED & VISIBLE) */
.header{
    background:var(--panel);
    border:1px solid var(--border);
    border-radius:16px;
    padding:22px 26px;
    margin-bottom:30px;
}

.header h1{
    font-size:26px;
    font-weight:700;
    color:var(--text);
}

.header p{
    font-size:14px;
    color:var(--muted);
    margin-top:6px;
}

/* KPI GRID */
.kpis{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:18px;
    margin-bottom:40px;
}

.kpi{
    background:var(--panel-soft);
    border-radius:18px;
    padding:22px;
    border:1px solid var(--border);
    transition:.3s ease;
}

.kpi:hover{
    transform:translateY(-4px);
    box-shadow:0 18px 30px rgba(120,110,90,0.18);
}

.kpi span{
    font-size:12px;
    color:var(--muted);
}

.kpi h2{
    margin-top:6px;
    font-size:26px;
    font-weight:600;
    color:var(--accent);
}

/* ANALYTICS */
.analytics{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:24px;
}

.panel{
    background:var(--panel);
    border-radius:20px;
    padding:26px;
    border:1px solid var(--border);
}

.panel h3{
    font-size:16px;
    font-weight:600;
    margin-bottom:16px;
    color:var(--accent);
}

/* INSIGHTS */
.insight{
    display:flex;
    justify-content:space-between;
    padding:12px 0;
    font-size:13px;
    border-bottom:1px solid var(--border);
}

.insight:last-child{border:none}
.insight span{color:var(--muted)}

/* RESPONSIVE */
@media(max-width:900px){
    .layout{grid-template-columns:1fr}
    .sidebar{display:none}
    .analytics{grid-template-columns:1fr}
}
</style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="brand">TripEase</div>
        <nav class="nav">
            <a href="AdminDashboard.jsp">Dashboard</a>
            <a href="ManageUsers">Users</a>
            <a href="AdminManageBookings">Bookings</a>
            <a href="ManageHotels">Hotels</a>
            <a href="AdminManageCabs">Cab Rentals</a>
            <a href="adminRestaurant?action=list">Restaurants</a>
            <a href="AdminLogoutServlet" class="logout">Logout</a>
        </nav>
    </aside>

    <!-- MAIN -->
    <main class="main">

        <!-- HEADER -->
        <div class="header">
            <h1>Admin Dashboard</h1>
            <p>Operational overview of the TripEase platform</p>
        </div>

        <!-- KPI -->
        <section class="kpis">
            <div class="kpi"><span>Total Users</span><h2><%=totalUsers%></h2></div>
            <div class="kpi"><span>Total Bookings</span><h2><%=totalBookings%></h2></div>
            <div class="kpi"><span>Total Hotels</span><h2><%=totalHotels%></h2></div>
            <div class="kpi"><span>Total Restaurants</span><h2><%=totalRestaurants%></h2></div>
            <div class="kpi"><span>Total Cab Rentals</span><h2><%=totalCabs%></h2></div>
        </section>

        <!-- ANALYTICS -->
        <section class="analytics">

            <div class="panel">
                <h3>Platform Usage</h3>
                <canvas id="chart"></canvas>
            </div>

            <div class="panel">
                <h3>System Health</h3>
                <div class="insight"><span>User Activity</span><strong>Normal</strong></div>
                <div class="insight"><span>Booking Load</span><strong>Stable</strong></div>
                <div class="insight"><span>Inventory Status</span><strong>Healthy</strong></div>
                <div class="insight"><span>Service Availability</span><strong>Operational</strong></div>
            </div>

        </section>

    </main>

</div>

<script>
new Chart(document.getElementById("chart"),{
    type:"bar",
    data:{
        labels:["Users","Bookings","Hotels","Restaurants","Cabs"],
        datasets:[{
            data:[
                <%=totalUsers%>,
                <%=totalBookings%>,
                <%=totalHotels%>,
                <%=totalRestaurants%>,
                <%=totalCabs%>
            ],
            backgroundColor:"#8a9a5b",
            borderRadius:6
        }]
    },
    options:{
        plugins:{legend:{display:false}},
        scales:{y:{beginAtZero:true}}
    }
});
</script>

</body>
</html>
