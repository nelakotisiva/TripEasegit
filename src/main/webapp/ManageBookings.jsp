<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Booking" %>

<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Manage Bookings</title>

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

/* HEADER ROW (title + buttons) */
.header-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
}

.page-title {
    font-size: 30px;
    font-weight: 700;
    color: #0032d8;
    margin-bottom: 6px;
    animation: fadeIn 0.8s ease-in-out;
}

.page-subtitle {
    color: #555;
    margin-bottom: 10px;
    font-size: 14px;
}

/* TOP RIGHT BUTTONS */
.header-buttons a {
    display: inline-block;
    padding: 10px 22px;
    border-radius: 10px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    color: #fff;
    margin-left: 10px;
    box-shadow: 0 6px 14px rgba(0,0,0,0.12);
    transition: 0.3s ease;
}

.btn-back {
    background: #ff9800;
}

.btn-add {
    background: #0066ff;
}

.header-buttons a:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.18);
}

/* SEARCH BAR */
.search-bar {
    margin-top: 18px;
    margin-bottom: 20px;
}

.search-bar input {
    width: 260px;
    max-width: 100%;
    padding: 10px 14px;
    border-radius: 10px;
    border: 1px solid #c3cdfb;
    font-family: inherit;
    font-size: 14px;
    outline: none;
    background: #fdfdff;
}

/* TABLE WRAPPER */
.table-wrapper {
    background: rgba(255,255,255,0.95);
    padding: 24px;
    border-radius: 22px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
    overflow-x: auto;
}

/* TABLE */
table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}

thead {
    background: #013bff;
    color: #fff;
}

th, td {
    padding: 12px 10px;
    text-align: center;
    white-space: nowrap;
}

tbody tr:nth-child(even) {
    background: rgba(1,59,255,0.03);
}

tbody tr:hover {
    background: rgba(1,59,255,0.07);
}

/* STATUS LABELS (simple) */
.status {
    font-weight: 600;
}
.status.PENDING {
    color: #b88600;
}
.status.CONFIRMED {
    color: #1f7a36;
}
.status.CANCELLED {
    color: #a11725;
}

/* ACTION BUTTONS IN TABLE */
.action-btn {
    display: inline-block;
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    margin: 0 4px;
    color: #fff;
}

.action-edit {
    background: #007bff;
}

.action-delete {
    background: #ff3b30;
}

.action-btn:hover {
    opacity: 0.9;
}

/* ANIMATIONS */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
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
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>⚙ Admin</h2>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="ManageUsers">👤 Manage Users</a>
    <a href="ManageBookings" class="active">📦 Manage Bookings</a>
    <a href="ManageHotels">🏨 Manage Hotels</a>
    <a href="ManageRestaurants">🍽 Manage Restaurants</a>
    <a href="AdminManageCabs">🚕 Manage Cab Rentals</a>
    <a href="adminRestaurant?action=list">🍽 Manage Restaurants</a>
    <a href="ManageCabs">🚕 Manage Cab Rentals</a>
    <a href="AdminLogoutServlet" style="background:#ff2e2e;margin-top:20px;">🚪 Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">

    <!-- title + buttons -->
    <div class="header-row">
        <div>
            <div class="page-title">Manage Bookings 📦</div>
            <div class="page-subtitle">
                Overview of all user bookings in the system.
            </div>
        </div>
        <div class="header-buttons">
            <!-- back to dashboard -->
            <a href="AdminDashboard.jsp" class="btn-back">Back</a>
            <!-- add booking page (change href if you have different URL) -->
            
        </div>
    </div>

    <!-- search -->
    <form class="search-bar" action="ManageBookings" method="get">
        <input type="text" name="search" placeholder="Search by Booking ID or User ID" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    </form>

    <!-- table -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>User ID</th>
                    <th>Destination ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>Status</th>
                    <th>No. of People</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (bookings != null && !bookings.isEmpty()) {
                    for (Booking b : bookings) {
            %>
                <tr>
                    <td><%= b.getBookingId() %></td>
                    <td><%= b.getUserId() %></td>
                    <td><%= b.getDestinationId() %></td>
                    <td><%= b.getBookingDate() %></td>
                    <td><%= b.getTravelDate() %></td>
                    <td class="status <%= b.getStatus() %>"><%= b.getStatus() %></td>
                    <td><%= b.getNumOfPeople() %></td>
                    <td>
                        <!-- Edit & Delete actions (wire these URLs to your servlets) -->
                        <a href="EditBooking?bookingId=<%= b.getBookingId() %>" 
                           class="action-btn action-edit">Edit</a>

                        <a href="DeleteBooking?bookingId=<%= b.getBookingId() %>"
                           class="action-btn action-delete"
                           onclick="return confirm('Are you sure you want to delete this booking?');">
                           Delete
                        </a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="8">No bookings found.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
