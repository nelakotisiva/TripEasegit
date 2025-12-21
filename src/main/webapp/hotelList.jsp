<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Hotel" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Hotels</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:linear-gradient(180deg,#e8f5f3,#ffffff);
    color:#1f3a3d;
}

/* DASHBOARD BUTTON */
.dashboard-btn{
    position:fixed;
    top:18px;
    left:18px;
    z-index:10000;
    background:linear-gradient(135deg,#3ba58b,#2f8a74);
    color:white;
    padding:10px 20px;
    border-radius:999px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    box-shadow:0 8px 20px rgba(59,165,139,.35);
    transition:.3s;
}
.dashboard-btn:hover{
    transform:translateX(-4px);
}

/* HEADER */
.header{
    height:230px;
    background:
        linear-gradient(rgba(59,165,139,.85),rgba(59,165,139,.85)),
        url("https://images.unsplash.com/photo-1566073771259-6a8506099945");
    background-size:cover;
    background-position:center;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    color:white;
}
.header h1{
    font-size:36px;
    font-weight:800;
}

/* SEARCH */
.search-box{
    margin-top:20px;
    background:white;
    padding:14px;
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,.15);
    display:flex;
    gap:10px;
}
.search-box input{
    padding:12px;
    width:260px;
    border-radius:12px;
    border:1px solid #cfe6df;
}
.search-box button{
    padding:12px 20px;
    background:linear-gradient(90deg,#3ba58b,#06b7ff);
    border:none;
    color:white;
    font-weight:700;
    border-radius:12px;
}

/* GRID */
.container{
    width:92%;
    max-width:1200px;
    margin:-40px auto 50px;
}
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:24px;
    margin-top:30px;
}
.card{
    background:white;
    border-radius:18px;
    overflow:hidden;
    box-shadow:0 14px 35px rgba(0,0,0,.12);
}
.card img{
    width:100%;
    height:200px;
    object-fit:cover;
}
.card-body{
    padding:18px;
    text-align:center;
}
.card-title{
    font-size:20px;
    font-weight:700;
}
.price{
    color:#3ba58b;
    font-weight:800;
    margin-top:8px;
}
.book-btn{
    margin-top:14px;
    display:inline-block;
    background:linear-gradient(90deg,#3ba58b,#06b7ff);
    color:white;
    padding:10px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:700;
}

/* MODAL */
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
    background:white;
    padding:28px;
    width:380px;
    border-radius:22px;
    text-align:center;
}
.modal h2{
    color:#3ba58b;
    margin:0;
}
.actions{
    margin-top:18px;
    display:flex;
    gap:12px;
    justify-content:center;
}
.yes{
    background:#3ba58b;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:12px;
    font-weight:700;
}
.no{
    background:#64748b;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:12px;
    font-weight:700;
}
</style>
</head>

<body>

<a href="Dashboard.jsp" class="dashboard-btn">← Dashboard</a>

<%
String msg = request.getParameter("msg");
String city = request.getParameter("city");
%>

<div class="header">
    <h1>🏨 Find Your Perfect Stay</h1>
    <form action="HotelListServlet" method="get" class="search-box">
        <input type="text" name="location"
               value="<%= city == null ? "" : city %>"
               placeholder="Search hotels by city">
        <button>Search</button>
    </form>
</div>

<div class="container">
<div class="grid">

<%
List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
if(hotels != null && !hotels.isEmpty()){
    for(Hotel h : hotels){
%>
<div class="card">
    <img src="<%= h.getImageUrl()==null
        ? "https://source.unsplash.com/800x600/?hotel"
        : h.getImageUrl() %>">
    <div class="card-body">
        <div class="card-title"><%= h.getHotelName() %></div>
        <div>📍 <%= h.getNearLocation() %></div>
        <div class="price">₹ <%= h.getPricePerNight() %> / night</div>
        <a href="BookHotel?id=<%= h.getHotelId() %>" class="book-btn">
            Book Now
        </a>
    </div>
</div>
<%
    }
} else {
%>
<div style="grid-column:1/-1;text-align:center;font-weight:600;">
    🔍 Search hotels to continue
</div>
<%
}
%>

</div>
</div>

<!-- HOTEL → RESTAURANT POPUP -->
<div class="modal-bg" id="hotelModal">
    <div class="modal">
        <h2>🎉 Hotel Booked!</h2>
        <p>Hotel booked successfully.</p>
        <p><b>Do you want to book a restaurant at <%= city %>?</b></p>

        <div class="actions">
            <a href="nearbyRestaurants">
                <button class="yes">Yes, Book Restaurant</button>
            </a>
            <a href="Dashboard.jsp">
                <button class="no">No, Later</button>
            </a>
        </div>
    </div>
</div>

<% if("success".equals(msg)){ %>
<script>
document.getElementById("hotelModal").style.display="flex";
</script>
<% } %>

</body>
</html>
