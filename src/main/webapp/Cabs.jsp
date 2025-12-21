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
    List<Integer> booked = (List<Integer>) request.getAttribute("bookedIds");

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
    box-shadow:0 8px 25px rgba(0,0,0,0.25);
}
.logo{
    font-size:24px;
    font-weight:700;
    color:#4a00e0;
}

/* SEARCH */
.search-box{
    margin:30px auto;
    background:#fff;
    padding:20px;
    width:60%;
    border-radius:14px;
    box-shadow:0 8px 25px rgba(0,0,0,0.2);
    display:flex;
    gap:12px;
}
.search-box input{
    flex:1;
    padding:12px;
    border-radius:8px;
    border:1px solid #ccc;
}
.search-box button{
    background:linear-gradient(90deg,#ff512f,#dd2476);
    color:#fff;
    border:none;
    padding:12px 22px;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
}

/* GRID */
.cab-grid{
    margin-top:40px;
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
}
@media(max-width:1100px){.cab-grid{grid-template-columns:repeat(2,1fr);}}
@media(max-width:700px){.cab-grid{grid-template-columns:1fr;}}

/* CARD */
.cab-card{
    background:#fff;
    padding:20px;
    border-radius:16px;
    box-shadow:0 12px 28px rgba(0,0,0,0.25);
}
.cab-img{
    width:100%;
    height:260px;
    object-fit:cover;
    border-radius:14px;
}
.price{
    font-size:20px;
    font-weight:700;
    color:#4a00e0;
}
.book-form{
    margin-top:15px;
    display:flex;
    gap:8px;
}
.book-form input{
    width:80px;
    padding:8px;
    border-radius:6px;
    border:1px solid #ccc;
}
.book-form button{
    flex:1;
    background:linear-gradient(90deg,#00c6ff,#0072ff);
    color:#fff;
    border:none;
    border-radius:6px;
    font-weight:600;
}
.booked{
    margin-top:10px;
    font-weight:600;
    color:#b30000;
}

/* ===== POPUP (CAB → HOTEL) ===== */
.modal-bg{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.6);
    display:none;
    align-items:center;
    justify-content:center;
    z-index:9999;
}
.modal{
    background:#fff;
    padding:26px;
    width:360px;
    border-radius:20px;
    text-align:center;
}
.modal h2{
    margin:0;
    color:#2563eb;
}
.modal p{
    margin:10px 0;
}
.actions{
    margin-top:18px;
    display:flex;
    gap:12px;
    justify-content:center;
}
.yes{
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 16px;
    border-radius:10px;
    font-weight:600;
}
.no{
    background:#6b7280;
    color:white;
    border:none;
    padding:10px 16px;
    border-radius:10px;
    font-weight:600;
}
</style>
</head>

<body>

<div class="header">
    <div class="logo">TripEase Cabs</div>
    <a href="CabBookingServlet"
       style="text-decoration:none;background:#00c6ff;color:white;
              padding:10px 18px;border-radius:8px;font-weight:600;">
        My Bookings
    </a>
</div>

<form class="search-box" method="get" action="VehicleListServlet">
    <input type="text" name="location" placeholder="Enter Pickup Location"
           value="<%= location==null?"":location %>" required>
    <button>Search Cabs</button>
</form>

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

<!-- ✅ CAB BOOKED → HOTEL POPUP -->
<div class="modal-bg" id="cabHotelModal">
    <div class="modal">
        <h2>🚕 Cab Booked!</h2>
        <p>Cab booked successfully!</p>
        <p><b>Do you want to book a hotel at <%= location %>?</b></p>

        <div class="actions">
            <a href="HotelListServlet?location=<%= URLEncoder.encode(location==null?"":location,"UTF-8") %>">
                <button class="yes" type="button">Yes, Book Hotel</button>
            </a>
            <a href="Dashboard.jsp">
                <button class="no" type="button">No, Later</button>
            </a>
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
