<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dtopackage.com.User" %>
<%@ page import="dtopackage.com.UserBooking" %>

<%
User user = (User) session.getAttribute("userObj");
if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
}

List<UserBooking> bookings =
    (List<UserBooking>) request.getAttribute("allBookings");

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<title>My Bookings</title>
<style>
*{box-sizing:border-box}

body{
    background:#e8f5f3;                 /* SAME */
    font-family:Poppins,sans-serif;
    padding:30px;
}

.wrap{
    max-width:900px;
    margin:auto;
}

/* BACK BUTTON */
.back-btn{
    display:inline-block;
    background:#008cff;                 /* SAME */
    color:#fff;
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
    margin-bottom:22px;
}

/* CARD */
.card{
    background:#fff;                    /* SAME */
    border-radius:18px;
    padding:20px 22px;
    margin-bottom:18px;
    box-shadow:0 10px 28px rgba(0,0,0,.10);
    transition:transform .15s ease, box-shadow .15s ease;
}

.card:hover{
    transform:translateY(-2px);
    box-shadow:0 14px 36px rgba(0,0,0,.14);
}

.card h3{
    margin:0 0 8px;
    font-size:18px;
    font-weight:700;
}

.card p{
    margin:4px 0;
    font-size:14px;
    line-height:1.4;
}

/* PRICE */
.price{
    margin-top:8px;
    font-size:18px;
    font-weight:800;
    color:#28a745;                      /* SAME */
}

/* BUTTON */
.btn{
    margin-top:12px;
    background:#ff5252;                 /* SAME */
    color:#fff;
    border:none;
    padding:8px 20px;
    border-radius:20px;
    cursor:pointer;
    font-weight:700;
    font-size:13px;
}

.btn:hover{
    background:#e53935;                 /* SAME */
}

/* CANCELLED */
.cancelled{
    margin-top:10px;
    font-weight:700;
    color:red;                          /* SAME */
}
</style>


<script>
function confirmCancel(){
    return confirm("⚠ Are you sure you want to cancel this booking?");
}
</script>
</head>

<body>

<%
String msg = (String) session.getAttribute("cancelMsg");
if (msg != null) {
%>
<script>alert("<%= msg %>");</script>
<%
session.removeAttribute("cancelMsg");
}
%>

<div class="wrap">

<a href="Dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

<h2>My Bookings</h2>

<% for(UserBooking b : bookings){ %>

<div class="card">
    <h3><%= b.getIcon() %> <%= b.getBookingType() %></h3>
    <p><b><%= b.getTitle() %></b></p>
    <p><%= b.getSubtitle() %></p>
    <p>Booked On: <%= sdf.format(b.getBookingDate()) %></p>
    <div class="price">₹ <%= b.getAmount() %></div>

    <% if(!"Cancelled".equalsIgnoreCase(b.getStatus())){ %>
    <form action="CancelBookingServlet" method="post"
          onsubmit="return confirmCancel();">
        <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
        <input type="hidden" name="serviceType" value="<%= b.getServiceType() %>">
        <button class="btn">Cancel Booking</button>
    </form>
    <% } else { %>
        <div class="cancelled">❌ Cancelled</div>
    <% } %>
</div>

<% } %>

</div>
</body>
</html>
