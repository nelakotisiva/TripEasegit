<%@ page import="dtopackage.com.Cab" %>
<%@ page import="dtopackage.com.User" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("userObj");
    if(user == null){
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Cab> list = (List<Cab>) request.getAttribute("vehicles");
    List<Integer> booked = (List<Integer>) request.getAttribute("bookedIds");
    String location = request.getAttribute("location") + "";
%>

<!DOCTYPE html>
<html>
<head>
<title>Book Your Cab | TripEase</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    margin:0;
    background:linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
    padding:40px;
}

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

.user{
    font-size:16px;
    font-weight:500;
}

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

.cab-grid{
    margin-top:40px;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:25px;
}

.cab-card{
    background:#fff;
    padding:20px;
    border-radius:16px;
    box-shadow:0 12px 28px rgba(0,0,0,0.25);
    transition:0.3s;
    position:relative;
}

.cab-card:hover{
    transform:translateY(-8px);
}

.cab-img{
    width:100%;
    height:270px;
    object-fit:cover;
    border-radius:14px;
    margin-bottom:12px;
}

.cab-title{
    font-size:20px;
    font-weight:600;
    margin-bottom:6px;
}

.cab-info{
    font-size:14px;
    color:#555;
    margin:3px 0;
}

.price{
    font-size:20px;
    font-weight:700;
    margin:10px 0;
    color:#4a00e0;
}

.status{
    font-size:13px;
    padding:5px 12px;
    border-radius:20px;
    display:inline-block;
    margin-bottom:10px;
}

.available{background:#d4ffd4;color:#0a7d0a;}
.booked{background:#ffd6d6;color:#b30000;}

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
    cursor:pointer;
}

.disabled{
    text-align:center;
    font-weight:600;
    color:#b30000;
}

.msg{
    margin-top:25px;
    text-align:center;
    font-weight:700;
    font-size:17px;
    color:#fff;
}
</style>
</head>

<body>

<div class="header">
    <div class="logo">🚕 TripEase Cabs</div>
    <div class="user">Welcome, <%= user.getFull_name() %></div>
</div>

<form class="search-box" method="get" action="VehicleListServlet">
    <input type="text" name="location" placeholder="Enter Pickup Location" value="<%= location.equals("null")?"":location %>" required>
    <button>Search Cabs</button>
</form>

<div class="cab-grid">

<% if(list!=null && !list.isEmpty()){
   for(Cab c : list){
       boolean isBooked = booked.contains(c.getRentalId());
%>

<div class="cab-card">

    <!-- ✅ CAB IMAGE ADDED -->
    <img src="<%= c.getImageUrl() %>" class="cab-img">

    <div class="cab-title"><%= c.getModel() %></div>

    <div class="cab-info">Type: <%= c.getSeaterType() %></div>
    <div class="cab-info">Location: <%= c.getLocation() %></div>

    <div class="price">₹ <%= c.getPricePerDay() %> / Day</div>

    <span class="status <%= isBooked?"booked":"available" %>">
        <%= isBooked?"BOOKED":"AVAILABLE" %>
    </span>

    <% if(!isBooked){ %>
    <form class="book-form" method="post" action="VehicleListServlet">
        <input type="number" name="passengers" min="1" max="10" required>
        <input type="hidden" name="rentalId" value="<%=c.getRentalId()%>">
        <input type="hidden" name="location" value="<%= location %>">
        <button>Book Now</button>
    </form>
    <% } else { %>
        <div class="disabled">Not Available</div>
    <% } %>

</div>

<% } } else { %>
    <h2 style="color:white;text-align:center;width:100%;">No Cabs Found</h2>
<% } %>

</div>

<div class="msg">
    <%= request.getAttribute("message")==null?"":request.getAttribute("message") %>
</div>

</body>
</html>
