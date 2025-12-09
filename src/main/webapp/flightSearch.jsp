<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, dtopackage.com.Flight" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Find Flights</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
/* ========== SOFT MINT THEME ========== */
:root{
  --mint-light:#e8f5f3;
  --mint:#3ba58b;
  --mint-dark:#2e8e77;
  --mint-glass:rgba(255,255,255,0.9);
  --text:#1f3a3d;
}

*{margin:0;padding:0;box-sizing:border-box;}

body{
  font-family:'Poppins',sans-serif;
  background:linear-gradient(180deg,var(--mint-light),#f6fffc);
  color:var(--text);
}

/* ================= HERO ================= */
.hero{
  height:260px;
  width:100%;
  background:
    linear-gradient(rgba(31,58,61,0.45), rgba(31,58,61,0.45)),
    url("<%=request.getContextPath()%>/images/flight-bg.jpg");
  background-size:cover;
  background-position:center;
  display:flex;
  justify-content:center;
  align-items:center;
  text-align:center;
  color:white;
}

.hero h1{
  font-size:36px;
  font-weight:800;
  text-shadow:0 8px 20px rgba(0,0,0,0.6);
}

.hero p{
  margin-top:10px;
  font-size:15px;
  opacity:.95;
}

/* ================= CONTAINER ================= */
.container{
  max-width:1150px;
  margin:-60px auto 40px;
  padding:0 15px;
}

/* ================= SEARCH ================= */
.search-card{
  background:var(--mint-glass);
  backdrop-filter:blur(10px);
  padding:20px;
  border-radius:18px;
  box-shadow:0 18px 45px rgba(46,142,119,0.25);
  display:flex;
  justify-content:center;
}

.search-card form{
  display:flex;
  flex-wrap:wrap;
  gap:12px;
}

.search-card input,
.search-card button{
  padding:12px 14px;
  border-radius:14px;
  border:1px solid #cfe6df;
  font-size:14px;
}

.search-card input{
  min-width:170px;
  background:#fbfffe;
}

.search-card button{
  background:linear-gradient(135deg,var(--mint),#06b7ff);
  color:white;
  border:none;
  font-weight:700;
  cursor:pointer;
}

.search-card button:hover{
  opacity:.95;
}

/* ================= RESULTS HEADER ================= */
.results-header{
  margin:26px 0 14px;
  display:flex;
  justify-content:space-between;
  font-weight:700;
  color:#335e59;
}

/* ================= GRID ================= */
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
  gap:22px;
}

/* ================= CARD ================= */
.card{
  background:white;
  padding:18px;
  border-radius:20px;
  display:flex;
  gap:16px;
  box-shadow:0 12px 30px rgba(34,60,60,0.10);
  transition:.3s ease;
  border:1px solid rgba(59,165,139,0.08);
}

.card:hover{
  transform:translateY(-8px);
  box-shadow:0 22px 50px rgba(34,60,60,0.16);
}

/* airline logo */
.logo{
  width:70px;
  height:70px;
  border-radius:18px;
  background:#f2fbf8;
  background-size:60%;
  background-repeat:no-repeat;
  background-position:center;
  border:1px solid rgba(59,165,139,0.12);
}

/* info */
.info{flex:1;}

.info h4{
  font-size:16px;
  font-weight:700;
}

.info p{
  font-size:13px;
  margin-top:4px;
  color:#406e69;
}

/* right side */
.right{text-align:right;}

.price{
  font-size:21px;
  font-weight:900;
  color:var(--mint-dark);
}

.book-btn{
  margin-top:10px;
  padding:10px 18px;
  border-radius:14px;
  border:none;
  background:linear-gradient(135deg,var(--mint),#06b7ff);
  color:white;
  cursor:pointer;
  font-weight:700;
}

.book-btn:hover{ transform:scale(1.05); }

/* ================= EMPTY ================= */
.empty{
  grid-column:1/-1;
  text-align:center;
  padding:45px;
  font-weight:700;
  color:#4c7c75;
}

/* ================= SUCCESS ================= */
.success{
  background:#d8f7ec;
  padding:14px;
  border-left:6px solid var(--mint);
  border-radius:12px;
  margin-bottom:15px;
  font-weight:700;
}

/* ================= MODAL ================= */
.modal-bg{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,.45);
  display:none;
  align-items:center;
  justify-content:center;
  z-index:2000;
}

.modal{
  width:92%;
  max-width:460px;
  background:white;
  padding:22px;
  border-radius:20px;
  box-shadow:0 25px 60px rgba(0,0,0,.25);
}

.modal input{
  width:100%;
  padding:10px;
  margin-top:6px;
  border-radius:10px;
  border:1px solid #dfeeed;
}

.actions{
  margin-top:16px;
  display:flex;
  justify-content:flex-end;
  gap:10px;
}

.cancel{
  background:#eef6f4;
  padding:10px 14px;
  border:none;
  border-radius:10px;
}

.confirm{
  background:var(--mint);
  padding:10px 18px;
  border:none;
  border-radius:10px;
  color:white;
  font-weight:700;
}

@media(max-width:520px){
  .hero h1{font-size:28px;}
}
</style>
</head>

<body>

<div class="hero">
  <div>
    <h1>Find Your Perfect Flight</h1>
    <p>Compare prices & book instantly — TripEase</p>
  </div>
</div>

<div class="container">

<%
String msg=(String)session.getAttribute("msg");
if(msg!=null){
%>
<div class="success"><%=msg%></div>
<%
session.removeAttribute("msg");
}
%>

<div class="search-card">
<form action="SearchFlight" method="get">
<input name="source" placeholder="From" value="<%=request.getAttribute("source")==null?"":request.getAttribute("source")%>">
<input name="destination" placeholder="To" value="<%=request.getAttribute("destination")==null?"":request.getAttribute("destination")%>">
<input type="date" name="date" value="<%=request.getAttribute("date")==null?"":request.getAttribute("date")%>">
<button>Search Flights</button>
</form>
</div>

<div class="results-header">
<div>Available Flights</div>
<div>TripEase ✈</div>
</div>

<div class="grid">
<%
List<Flight> flights=(List<Flight>)request.getAttribute("flights");
if(flights!=null && !flights.isEmpty()){
for(Flight f:flights){
%>

<div class="card">
  <div class="logo" data-air="<%=f.getAirline()%>"></div>

  <div class="info">
    <h4><%=f.getAirline()%></h4>
    <p><b><%=f.getSource()%></b> → <b><%=f.getDestination()%></b></p>
    <p>Dep <%=f.getDepartureTime()%> • Arr <%=f.getArrivalTime()%></p>
    <p>Seats left <%=f.getSeatsAvailable()%></p>
  </div>

  <div class="right">
    <div class="price">₹<%=f.getPrice()%></div>
    <button class="book-btn" data-id="<%=f.getFlightId()%>" data-seats="<%=f.getSeatsAvailable()%>">Book</button>
  </div>
</div>

<% }}else{ %>
<div class="empty">No flights found 😔</div>
<% } %>
</div>
</div>

<!-- MODAL -->
<div class="modal-bg" id="modal">
<div class="modal">
<h3>Confirm Booking</h3>
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

<script>
const logos={
  "indigo":"https://upload.wikimedia.org/wikipedia/commons/9/9d/IndiGo_logo.svg",
  "air india":"https://upload.wikimedia.org/wikipedia/en/4/4e/Air_India_Logo.svg",
  "vistara":"https://1000logos.net/wp-content/uploads/2021/09/Vistara-logo.png",
  "default":"https://img.icons8.com/ios-filled/100/airplane-take-off.png"
};

document.querySelectorAll(".logo").forEach(l=>{
  let name=l.dataset.air.toLowerCase();
  let img=logos.default;
  for(let k in logos){ if(name.includes(k)) img=logos[k]; }
  l.style.backgroundImage=`url('${img}')`;
});

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
