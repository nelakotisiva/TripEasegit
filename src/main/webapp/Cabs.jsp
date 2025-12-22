<%@ page import="dtopackage.com.Cab" %>
<%@ page import="dtopackage.com.User" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
User user = (User) session.getAttribute("userObj");
if(user == null){
    response.sendRedirect("Login.jsp");
    return;
}

List<Cab> list = (List<Cab>) request.getAttribute("vehicles");
List<Integer> booked =
        request.getAttribute("bookedIds") == null
        ? new ArrayList<>()
        : (List<Integer>) request.getAttribute("bookedIds");

String location = request.getAttribute("location") == null
        ? request.getParameter("location")
        : request.getAttribute("location").toString();

String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Book Your Cab | TripEase</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{
    margin:0;
    background:linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
    padding:40px;
}

/* HEADER */
.header{
    background:#fff;
    padding:18px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    border-radius:14px;
}
.left-actions{
    display:flex;
    gap:12px;
    align-items:center;
}
.logo{
    font-size:24px;
    font-weight:700;
    color:#4a00e0;
}
.back-dashboard{
    background:#374151;
    color:white;
    padding:8px 14px;
    border-radius:8px;
    text-decoration:none;
    font-weight:600;
}
.back-dashboard:hover{
    background:#1f2937;
}

/* SEARCH */
.search-box{
    margin:30px auto;
    background:#fff;
    padding:20px;
    width:60%;
    border-radius:14px;
    display:flex;
    gap:12px;
}
.search-box input{flex:1;padding:12px;}
.search-box button{
    background:linear-gradient(90deg,#ff512f,#dd2476);
    color:#fff;border:none;padding:12px 22px;
}

/* GRID */
.cab-grid{
    margin-top:40px;
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
}
.cab-card{
    background:#fff;
    padding:20px;
    border-radius:16px;
}
.cab-img{
    width:100%;height:260px;
    object-fit:cover;border-radius:14px;
}
.price{font-size:20px;font-weight:700;color:#4a00e0;}
.book-form{
    margin-top:15px;
    display:flex;
    gap:8px;
}
.book-form input{width:80px;padding:8px;}
.book-form button{
    flex:1;background:#0072ff;
    color:#fff;border:none;border-radius:6px;
}
.booked{
    margin-top:10px;
    font-weight:600;
    color:#b30000;
}

/* POPUP */
.modal-bg{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.6);
    display:none;
    align-items:center;
    justify-content:center;
    z-index:9999;
}
.modal{
    background:#fff;
    padding:28px;
    width:380px;
    border-radius:20px;
    text-align:center;
}
.actions{
    margin-top:20px;
    display:flex;
    gap:12px;
    justify-content:center;
}
.yes-btn{
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:10px;
    font-weight:600;
}
.no-btn{
    background:#6b7280;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:10px;
    font-weight:600;
}
</style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="left-actions">
        <!-- ✅ BACK TO DASHBOARD (BEFORE BOOKING) -->
        <a href="Dashboard.jsp" class="back-dashboard"> Dashboard</a>
        <div class="logo">TripEase Cabs</div>
    </div>

    <a href="CabBookingServlet"
       style="text-decoration:none;background:#00c6ff;color:white;
              padding:10px 18px;border-radius:8px;font-weight:600;">
        My Bookings
    </a>
</div>

<!-- SEARCH -->
<form class="search-box" method="get" action="VehicleListServlet">
    <input type="text" name="location" placeholder="Enter Pickup Location"
           value="<%= location==null?"":location %>" required>
    <button>Search Cabs</button>
</form>

<!-- CAB LIST -->
<div class="cab-grid">
<%
if(list!=null && !list.isEmpty()){
for(Cab c:list){
    boolean isBooked = booked.contains(c.getRentalId());
%>

<div class="cab-card">
    <img src="<%= c.getImageUrl() %>" class="cab-img">
    <h3><%= c.getModel() %></h3>
    <p>Type: <%= c.getSeaterType() %></p>
    <p>Location: <%= c.getLocation() %></p>
    <div class="price">₹ <%= c.getPricePerDay() %> / Day</div>

    <% if(!isBooked){ %>
    <form class="book-form" method="post" action="VehicleListServlet">
        <input type="number" name="passengers" min="1" max="10" required>
        <input type="hidden" name="rentalId" value="<%= c.getRentalId() %>">
        <input type="hidden" name="location" value="<%= location %>">
        <button>Book Now</button>
    </form>
    <% } else { %>
        <div class="booked">Already Booked</div>
    <% } %>
</div>

<% }} else { %>
<h2 style="color:white;text-align:center;width:100%;">No Cabs Found</h2>
<% } %>
</div>

<!-- POPUP AFTER SUCCESS -->
<div class="modal-bg" id="cabHotelModal">
    <div class="modal">
        <h2>🚕 Cab Booked Successfully!</h2>
        <p>Do you want to book a hotel at <%= location %>?</p>

        <div class="actions">
            <a href="HotelListServlet?location=<%= URLEncoder.encode(location==null?"":location,"UTF-8") %>">
                <button class="yes-btn" type="button">Yes, Book Hotel</button>
            </a>
            <button class="no-btn" type="button"
                    onclick="document.getElementById('cabHotelModal').style.display='none'">
                No, Later
            </button>
        </div>
    </div>
</div>

<% if("success".equals(msg)){ %>
<script>
document.getElementById("cabHotelModal").style.display="flex";
</script>
<% } %>

</body>
</html>
