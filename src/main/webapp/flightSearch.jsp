<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Flight" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Flights</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

<style>
body{
  margin:0;
  font-family:'Poppins',sans-serif;
  background:#eef2ff;
}

/* ===== TOP CENTER ===== */
.top-bar{
  position:fixed;
  top:16px;
  width:100%;
  display:flex;
  justify-content:center;
  z-index:2000;
}
.top-actions{
  display:flex;
  gap:14px;
  background:rgba(0,0,0,.35);
  backdrop-filter:blur(8px);
  padding:10px 18px;
  border-radius:999px;
}
.top-btn{
  color:white;
  text-decoration:none;
  font-weight:600;
  padding:8px 18px;
  border-radius:999px;
  background:#0f172a;
}

/* ===== HERO ===== */
.hero{
  height:240px;
  background:linear-gradient(rgba(37,99,235,.85),rgba(37,99,235,.85)),
  url("https://images.unsplash.com/photo-1529070538774-1843cb3265df");
  background-size:cover;
  display:flex;
  align-items:center;
  justify-content:center;
  color:white;
}
.hero h1{font-size:36px;font-weight:800}

/* ===== SEARCH ===== */
.search-box{
  max-width:1000px;
  margin:-40px auto 30px;
  background:white;
  padding:20px;
  border-radius:20px;
  box-shadow:0 25px 60px rgba(0,0,0,.18);
}
.search-box form{
  display:flex;
  gap:12px;
  flex-wrap:wrap;
}
.search-box input{
  padding:12px;
  border-radius:12px;
  border:1px solid #c7d2fe;
}
.search-box button{
  background:#2563eb;
  color:white;
  border:none;
  padding:12px 24px;
  border-radius:14px;
  font-weight:700;
}

/* ===== CARDS ===== */
.container{max-width:1100px;margin:auto;padding:20px}
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
  gap:22px;
}
.card{
  background:white;
  border-radius:20px;
  padding:18px;
  display:flex;
  gap:16px;
  box-shadow:0 18px 45px rgba(0,0,0,.12);
}
.price{font-size:22px;font-weight:900;color:#2563eb}
.book-btn{
  padding:10px 18px;
  border:none;
  border-radius:14px;
  background:#2563eb;
  color:white;
  font-weight:700;
}

/* ===== MODAL ===== */
.modal-bg{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,.55);
  display:none;
  align-items:center;
  justify-content:center;
  z-index:5000;
}
.modal{
  background:white;
  padding:24px;
  border-radius:22px;
  width:92%;
  max-width:420px;
}
.modal input{
  width:100%;
  padding:10px;
  margin-top:8px;
}
.actions{
  margin-top:18px;
  display:flex;
  justify-content:flex-end;
  gap:10px;
}
</style>
</head>

<body>

<!-- TOP BUTTONS -->
<div class="top-bar">
  <div class="top-actions">
    <a href="Dashboard.jsp" class="top-btn">Dashboard</a>
    <a href="MyFlightBookings" class="top-btn">✈ My Flight Bookings</a>
  </div>
</div>

<div class="hero">
  <h1>✈ Find Your Perfect Flight</h1>
</div>

<div class="search-box">
<form action="SearchFlight" method="get">
  <input name="source" placeholder="From" required>
  <input name="destination" placeholder="To" required>
  <input type="date" name="date" id="searchDate" required>
  <button>Search Flights</button>
</form>
</div>

<div class="container">
<div class="grid">

<%
List<Flight> flights = (List<Flight>) request.getAttribute("flights");
if(flights != null && !flights.isEmpty()){
for(Flight f : flights){
%>

<div class="card">
  <div style="flex:1">
    <b><%=f.getAirline()%></b><br>
    <%=f.getSource()%> → <%=f.getDestination()%><br>
    Seats left: <%=f.getSeatsAvailable()%>
  </div>
  <div style="text-align:right">
    <div class="price">₹<%=f.getPrice()%></div>
    <button class="book-btn"
      data-id="<%=f.getFlightId()%>"
      data-seats="<%=f.getSeatsAvailable()%>">Book</button>
  </div>
</div>

<% } } %>

</div>
</div>

<!-- BOOK MODAL -->
<div class="modal-bg" id="modal">
<div class="modal">
<h3>Confirm Booking</h3>
<form action="BookFlight" method="post">
  <input type="hidden" name="flightId" id="fid">
  <input type="date" name="date" id="travelDate" required>
  <input type="number" name="seats" id="seats" min="1" required>
  <div class="actions">
    <button type="button" onclick="closeModal()">Cancel</button>
    <button>Confirm</button>
  </div>
</form>
</div>
</div>

<!-- SUCCESS POPUP -->
<%
String msg = (String) session.getAttribute("msg");
if(msg != null){
%>
<div class="modal-bg" style="display:flex;">
  <div class="modal">
    <h3>Booking Status</h3>
    <p><%=msg%></p>
    <div class="actions">
      <button onclick="location.href='MyFlightBookings'">My Flight Bookings</button>
      <button onclick="location.href='SearchFlight'">Close</button>
    </div>
  </div>
</div>
<%
session.removeAttribute("msg");
}
%>

<script>
document.addEventListener("DOMContentLoaded",function(){
  const modal=document.getElementById("modal");
  const fid=document.getElementById("fid");
  const seats=document.getElementById("seats");
  const today=new Date().toISOString().split("T")[0];
  document.getElementById("searchDate").min=today;
  document.getElementById("travelDate").min=today;

  document.querySelectorAll(".book-btn").forEach(b=>{
    b.onclick=()=>{
      fid.value=b.dataset.id;
      seats.max=b.dataset.seats;
      seats.value=1;
      modal.style.display="flex";
    }
  });
  window.closeModal=()=>modal.style.display="none";
});
</script>

</body>
</html>
