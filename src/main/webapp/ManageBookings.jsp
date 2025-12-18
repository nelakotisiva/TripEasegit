<%@ page contentType="text/html;charset=UTF-8" %>
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
<title>Admin | Manage Bookings</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{box-sizing:border-box;}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#eef3ff;
    padding:30px;
}

/* ===== PAGE CONTAINER ===== */
.container{
    max-width:1200px;
    margin:auto;
}

/* ===== HEADER CARD ===== */
.header-card{
    background:white;
    padding:22px 26px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,0.12);
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.header-card h1{
    margin:0;
    color:#0032d8;
    font-size:30px;
    font-weight:700;
}

/* ===== BUTTONS ===== */
.btn{
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    transition:0.3s;
}

.btn-secondary{
    background:#6c757d;
    color:white;
}
.btn-secondary:hover{
    background:#5a6268;
}

/* ===== SEARCH BAR ===== */
.search-bar{
    margin-bottom:18px;
}

.search-bar input{
    width:260px;
    padding:12px 14px;
    border-radius:10px;
    border:1px solid #c3cdfb;
    font-size:14px;
    outline:none;
}

/* ===== TABLE ===== */
.table-wrapper{
    background:white;
    padding:22px;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
}

table{
    width:100%;
    border-collapse:collapse;
    font-size:14px;
}

thead{
    background:#013bff;
    color:white;
}

th, td{
    padding:14px;
    text-align:center;
}

tbody tr:nth-child(even){
    background:#f4f6ff;
}

tbody tr:hover{
    background:#e9edff;
}

/* ===== STATUS ===== */
.status{
    font-weight:600;
}
.status.PENDING{color:#b88600;}
.status.CONFIRMED{color:#1f7a36;}
.status.CANCELLED{color:#a11725;}

/* ===== ACTION BUTTONS ===== */
.action-btn{
    padding:6px 14px;
    border-radius:8px;
    color:white;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
    margin:0 4px;
}
.edit{background:#007bff;}
.delete{background:#ff3b30;}

.action-btn:hover{
    opacity:0.9;
}
</style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="header-card">
        <h1>Manage Bookings</h1>
        <a href="AdminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- SEARCH -->
    <form class="search-bar" action="ManageBookings" method="get">
        <input type="text" name="search"
               placeholder="Search by Booking ID or User ID"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    </form>

    <!-- TABLE -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>User ID</th>
                    <th>Destination</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>Status</th>
                    <th>People</th>
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
                        <a href="EditBooking?bookingId=<%= b.getBookingId() %>"
                           class="action-btn edit">Edit</a>

                        <a href="DeleteBooking?bookingId=<%= b.getBookingId() %>"
                           class="action-btn delete"
                           onclick="return confirm('Delete this booking?')">
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
            <% } %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>
