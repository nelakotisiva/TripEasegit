<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Flight" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Flights</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
:root{
  --primary:#2563eb;
  --secondary:#0ea5e9;
  --bg:#eef2ff;
  --glass:rgba(255,255,255,0.85);
  --text:#1e293b;
}

*{box-sizing:border-box}

body{
  margin:0;
  font-family:'Poppins',sans-serif;
  background:linear-gradient(180deg,var(--bg),#ffffff);
  color:var(--text);
}

/* ================= HERO ================= */
.hero{
  height:260px;
  background:
    linear-gradient(rgba(37,99,235,.85),rgba(37,99,235,.85)),
    url("https://images.unsplash.com/photo-1529070538774-1843cb3265df");
  background-size:cover;
  background-position:center;
  display:flex;
  align-items:center;
  justify-content:center;
  text-align:center;
  color:white;
}

.hero h1{
  font-size:38px;
  font-weight:800;
}
.hero p{
  opacity:.95;
}

/* ================= SEARCH ================= */
.search-wrap{
  max-width:1100px;
  margin:-45px auto 30px;
  padding:0 16px;
}

.search-box{
  background:var(--glass);
  backdrop-filter:blur(12px);
  border-radius:20px;
  padding:20px;
  box-shadow:0 25px 60px rgba(0,0,0,.18);
}

.search-box form{
  display:flex;
  gap:12px;
  flex-wrap:wrap;
}

.search-box input{
  padding:12px 14px;
  border-radius:12px;
  border:1px solid #dbeafe;
  font-size:14px;
  min-width:180px;
}

.search-box button{
  background:linear-gradient(135deg,var(--primary),var(--secondary));
  border:none;
  color:white;
  font-weight:700;
  padding:12px 24px;
  border-radius:14px;
  cursor:pointer;
}

/* ================= CONTAINER ================= */
.container{
  max-width:1150px;
  margin:auto;
  padding:0 16px 60px;
}

/* ================= GRID ================= */
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(330px,1fr));
  gap:22px;
}

/* ================= CARD ================= */
.card{
  background:white;
  border-radius:20px;
  padding:18px;
  display:flex;
  gap:16px;
  box-shadow:0 18px 45px rgba(0,0,0,.12);
  transition:.35s;
}
.card:hover{
  transform:translateY(-10px);
  box-shadow:0 30px 70px rgba(0,0,0,.18);
}

.logo{
  width:70px;
  height:70px;
  border-radius:16px;
  background:#eef2ff;
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:32px;
}

.info{flex:1}
.info h4{margin:0;font-size:16px}
.info p{margin:4px 0;font-size:13px;color:#475569}

.right{text-align:right}
.price{
  font-size:22px;
  font-weight:900;
  color:var(--primary);
}

.book-btn{
  margin-top:10px;
  padding:10px 18px;
  border:none;
  border-radius:14px;
  background:linear-gradient(135deg,var(--primary),var(--secondary));
  color:white;
  font-weight:700;
  cursor:pointer;
}

/* ================= EMPTY ================= */
.empty{
  grid-column:1/-1;
  text-align:center;
  padding:50px;
  font-weight:700;
  color:#64748b;
}

/* ================= MODAL ================= */
.modal-bg{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,.55);
  display:none;
  align-items:center;
  justify-content:center;
  z-index:2000;
}

.modal{
  background:white;
  width:92%;
  max-width:420px;
  padding:24px;
  border-radius:22px;
}

.modal h3{text-align:center}

.modal input{
  width:100%;
  padding:10px;
  margin-top:8px;
  border-radius:10px;
  border:1px solid #c7d2fe;
}

.actions{
  margin-top:18px;
  display:flex;
  justify-content:flex-end;
  gap:10px;
}

.cancel{background:#e5e7eb}
.confirm{background:var(--primary);color:white}

/* ================= SUCCESS MODAL ================= */
.success-bg{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,.55);
  display:flex;
  align-items:center;
  justify-content:center;
  z-index:3000;
}

.success{
  background:white;
  padding:28px;
  border-radius:24px;
  text-align:center;
  width:92%;
  max-width:380px;
}

.success h2{color:var(--primary)}
.success button{
  padding:10px 18px;
  border:none;
  border-radius:12px;
  font-weight:700;
  color:white;
}
.back{background:#64748b}
.my{background:var(--primary)}

@media(max-width:520px){
  .hero h1{font-size:28px}
}
</style>
</head>

<body>

<div class="hero">
  <div>
    <h1>✈ Find Your Perfect Flight</h1>
    <p>Compare • Book • Travel Easy</p>
  </div>
</div>

<div class="search-wrap">
<div class="search-box">
<form action="SearchFlight" method="get">
  <input name="source" placeholder="From" value="<%=request.getAttribute("source")==null?"":request.getAttribute("source")%>" required>
  <input name="destination" placeholder="To" value="<%=request.getAttribute("destination")==null?"":request.getAttribute("destination")%>" required>
  <input type="date" name="date" value="<%=request.getAttribute("date")==null?"":request.getAttribute("date")%>" required>
  <button>Search Flights</button>
</form>
</div>
</div>

<div class="container">
<div class="grid">

<%
List<Flight> flights=(List<Flight>)request.getAttribute("flights");
if(flights!=null && !flights.isEmpty()){
for(Flight f:flights){
%>

<div class="card">
  <div class="logo">✈</div>

  <div class="info">
    <h4><%=f.getAirline()%></h4>
    <p><b><%=f.getSource()%></b> → <b><%=f.getDestination()%></b></p>
    <p><%=f.getDepartureTime()%> • <%=f.getArrivalTime()%></p>
    <p>Seats left: <%=f.getSeatsAvailable()%></p>
  </div>

  <div class="right">
    <div class="price">₹<%=f.getPrice()%></div>
    <button class="book-btn" data-id="<%=f.getFlightId()%>" data-seats="<%=f.getSeatsAvailable()%>">Book</button>
  </div>
</div>

<% } } else { %>
<div class="empty">Search flights to see available options ✨</div>
<% } %>

</div>
</div>

<!-- BOOK MODAL -->
<div class="modal-bg" id="modal">
<div class="modal">
<h3>Confirm Flight Booking</h3>
<form action="BookFlight" method="post">
  <input type="hidden" name="flightId" id="fid">
  <label>Date</label>
  <input type="date" name="date" required>
  <label>Seats</label>
  <input type="number" name="seats" id="seats" min="1" required>
  <div class="actions">
    <button type="button" class="cancel" onclick="closeModal()">Cancel</button>
    <button class="confirm">Confirm</button>
  </div>
</form>
</div>
</div>

<!-- SUCCESS POPUP -->
<%
String msg=(String)session.getAttribute("msg");
if(msg!=null && msg.contains("successfully")){
%>
<div class="success-bg">
  <div class="success">
    <h2>🎉 Booking Confirmed</h2>
    <p><%=msg%></p>
    <div style="margin-top:20px;display:flex;gap:12px;justify-content:center">
      <a href="SearchFlight"><button class="back">Back</button></a>
      
    </div>
  </div>
</div>
<%
session.removeAttribute("msg");
}
%>

<script>
const modal=document.getElementById("modal");
const fid=document.getElementById("fid");
const seats=document.getElementById("seats");

document.querySelectorAll(".book-btn").forEach(b=>{
  b.onclick=()=>{
    fid.value=b.dataset.id;
    seats.max=b.dataset.seats;
    modal.style.display="flex";
  }
});
function closeModal(){ modal.style.display="none"; }
</script>

</body>
</html>
