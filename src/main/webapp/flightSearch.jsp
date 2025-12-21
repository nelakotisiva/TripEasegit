<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Flight" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
<title>TripEase | Flights</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

<style>
:root{
  --primary:#2563eb;
  --secondary:#0ea5e9;
  --bg:#eef2ff;
}

*{box-sizing:border-box}

body{
  margin:0;
  font-family:'Poppins',sans-serif;
  background:var(--bg);
}

/* NAV BUTTONS */
.back-dashboard{
  position:fixed;
  top:18px;
  left:18px;
  z-index:1000;
  background:#0f172a;
  color:white;
  padding:10px 18px;
  border-radius:20px;
  text-decoration:none;
  font-weight:600;
}
.my-flight-btn{
  position:fixed;
  top:18px;
  right:18px;
  z-index:1000;
  background:linear-gradient(135deg,var(--primary),var(--secondary));
  color:white;
  padding:10px 18px;
  border-radius:20px;
  text-decoration:none;
  font-weight:600;
}

/* HERO – FULL WIDTH FIX */
.hero{
  position:relative;
  height:240px;
  width:100%;
  background:url("https://c8.alamy.com/comp/2FRH78G/travel-world-vector-banner-design-travel-and-book-now-text-in-mobile-app-with-airplane-transportation-element-for-flight-online-booking-background-2FRH78G.jpg");
  background-size:cover;     /* ✅ FIX */
  background-repeat:no-repeat;
  background-position:center;
  display:flex;
  align-items:center;
  justify-content:center;
}
.hero::before{
  content:"";
  position:absolute;
  inset:0;
  background:rgba(0,0,0,0.35);
}
.hero h1{
  position:relative;
  z-index:1;
  color:white;
  font-size:34px;
  font-weight:800;
  text-shadow:0 6px 20px rgba(0,0,0,.6);
}

/* SEARCH */
.search-wrap{
  max-width:1100px;
  margin:20px auto 30px;
  padding:0 16px;
}
.search-box{
  background:white;
  border-radius:18px;
  padding:20px;
  box-shadow:0 20px 40px rgba(0,0,0,.15);
}
.search-box form{
  display:flex;
  gap:12px;
  flex-wrap:wrap;
}
.search-box input{
  padding:12px;
  border-radius:10px;
  border:1px solid #c7d2fe;
  min-width:180px;
}
.search-box button{
  background:linear-gradient(135deg,var(--primary),var(--secondary));
  color:white;
  border:none;
  padding:12px 24px;
  border-radius:12px;
  cursor:pointer;
  font-weight:700;
}

/* GRID */
.container{
  max-width:1150px;
  margin:auto;
  padding:0 16px 60px;
}
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
  gap:22px;
}

/* CARD */
.card{
  background:white;
  border-radius:18px;
  padding:18px;
  display:flex;
  gap:14px;
  box-shadow:0 16px 40px rgba(0,0,0,.12);
}
.logo{
  width:60px;
  height:60px;
  border-radius:14px;
  background:#eef2ff;
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:28px;
}
.info h4{margin:0}
.info p{margin:4px 0;font-size:13px;color:#475569}
.right{text-align:right}
.price{
  font-size:22px;
  font-weight:900;
  color:var(--primary);
}
.book-btn{
  margin-top:8px;
  padding:8px 16px;
  border:none;
  border-radius:12px;
  background:linear-gradient(135deg,var(--primary),var(--secondary));
  color:white;
  font-weight:700;
  cursor:pointer;
}

/* MODAL */
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
  border-radius:20px;
  width:90%;
  max-width:420px;
}
.modal input{
  width:100%;
  padding:10px;
  margin-top:8px;
  border-radius:8px;
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

/* SUCCESS */
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
  padding:26px;
  border-radius:22px;
  text-align:center;
  max-width:380px;
}
.success h2{color:var(--primary)}
.success button{
  padding:10px 18px;
  border:none;
  border-radius:10px;
  font-weight:700;
  color:white;
}
.back{background:#64748b}
.my{background:var(--primary)}
</style>
</head>

<body>

<a href="Dashboard.jsp" class="back-dashboard">← Dashboard</a>
<a href="MyFlightBookings" class="my-flight-btn">My Flight Bookings</a>

<div class="hero">
  <h1>✈ Find Your Perfect Flight</h1>
</div>

<div class="search-wrap">
  <div class="search-box">
    <form action="SearchFlight" method="get">
      <input name="source" placeholder="From"
        value="<%=request.getAttribute("source")==null?"":request.getAttribute("source")%>" required>

      <input name="destination" placeholder="To"
        value="<%=request.getAttribute("destination")==null?"":request.getAttribute("destination")%>" required>

      <input type="date" name="date"
        min="<%=LocalDate.now()%>"
        value="<%=request.getAttribute("date")==null?"":request.getAttribute("date")%>" required>

      <button>Search Flights</button>
    </form>
  </div>
</div>

<div class="container">
<div class="grid">

<%
List<Flight> flights = (List<Flight>) request.getAttribute("flights");
if(flights!=null && !flights.isEmpty()){
for(Flight f:flights){
%>

<div class="card">
  <div class="logo">✈</div>
  <div class="info">
    <h4><%=f.getAirline()%></h4>
    <p><%=f.getSource()%> → <%=f.getDestination()%></p>
    <p>Seats left: <%=f.getSeatsAvailable()%></p>
  </div>
  <div class="right">
    <div class="price">₹<%=f.getPrice()%></div>
    <button class="book-btn"
      data-id="<%=f.getFlightId()%>"
      data-seats="<%=f.getSeatsAvailable()%>">
      Book
    </button>
  </div>
</div>

<% } } else { %>
<div style="grid-column:1/-1;text-align:center;font-weight:700">
  Search flights to see available options ✨
</div>
<% } %>

</div>
</div>

<!-- BOOK MODAL -->
<div class="modal-bg" id="modal">
<div class="modal">
<h3>Confirm Booking</h3>
<form action="BookFlight" method="post">
  <input type="hidden" name="flightId" id="fid">
  <input type="date" name="date" min="<%=LocalDate.now()%>" required>
  <input type="number" name="seats" id="seats" min="1" required>

  <div class="actions">
    <button type="button" class="cancel" onclick="closeModal()">Cancel</button>
    <button class="confirm">Confirm</button>
  </div>
</form>
</div>
</div>

<%
String msg = (String)session.getAttribute("msg");
String dest = (String)request.getAttribute("destination");
if(msg!=null && msg.contains("successfully") && dest!=null){
String city = dest.split(" ")[0];
String encodedCity = URLEncoder.encode(city,"UTF-8");
%>

<div class="success-bg">
  <div class="success">
    <h2>🎉 Flight Booked!</h2>
    <p><%=msg%></p>
    <p><b>Book a cab at <%=city%>?</b></p>
    <div style="margin-top:18px;display:flex;gap:12px;justify-content:center">
      <a href="VehicleListServlet?location=<%=encodedCity%>">
        <button class="my">Yes, Book Cab</button>
      </a>
      <a href="Dashboard.jsp">
        <button class="back">No, Later</button>
      </a>
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
    seats.value=1;
    modal.style.display="flex";
  }
});
function closeModal(){modal.style.display="none";}
</script>

</body>
</html>
