<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>TripEase | Travel Made Simple</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ================= ROOT THEME ================= */
:root{
    --mint:#3ba58b;
    --mint-dark:#2f8a74;
    --mint-light:#eaf7f4;
    --text:#1f3a3d;
    --muted:#6c757d;
    --white:#ffffff;
}

/* ================= BASE ================= */
*{box-sizing:border-box}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:var(--mint-light);
    color:var(--text);
}

/* ================= NAVBAR ================= */
header{
    position:sticky;
    top:0;
    background:white;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    z-index:100;
}

.navbar{
    max-width:1200px;
    margin:auto;
    padding:16px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    font-size:26px;
    font-weight:800;
    color:var(--mint);
}

.nav-links a{
    margin-left:22px;
    text-decoration:none;
    font-weight:600;
    color:var(--text);
}

.nav-links .btn{
    background:var(--mint);
    color:white;
    padding:8px 18px;
    border-radius:20px;
}

.nav-links .btn:hover{
    background:var(--mint-dark);
}

/* ================= HERO ================= */
.hero{
    height:80vh;
    position:relative;
}

.hero video{
    width:100%;
    height:100%;
    object-fit:cover;
}

.hero-overlay{
    position:absolute;
    inset:0;
    background:rgba(0,0,0,0.45);
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    color:white;
    padding:20px;
}

.hero-overlay h1{
    font-size:46px;
    margin:0;
}

.hero-overlay p{
    margin-top:10px;
    font-size:18px;
}

/* ================= SEARCH ================= */
.search-box{
    background:white;
    max-width:1000px;
    margin:-60px auto 60px;
    padding:24px;
    border-radius:18px;
    box-shadow:0 20px 50px rgba(0,0,0,0.15);
    display:flex;
    gap:12px;
    flex-wrap:wrap;
}

.search-box input{
    flex:1;
    padding:12px;
    border-radius:10px;
    border:1px solid #b7ded4;
}

.search-box button{
    background:var(--mint);
    border:none;
    padding:12px 28px;
    border-radius:12px;
    color:white;
    font-weight:700;
    cursor:pointer;
}

/* ================= SECTIONS ================= */
.section{
    max-width:1200px;
    margin:auto;
    padding:10px 20px 60px;
}

.section-title{
    font-size:28px;
    font-weight:800;
    margin-bottom:25px;
}

/* ================= GRID/CARDS ================= */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:22px;
}

.card{
    background:white;
    border-radius:18px;
    overflow:hidden;
    box-shadow:0 10px 26px rgba(0,0,0,0.12);
    transition:0.3s;
}

.card:hover{transform:translateY(-8px)}

.card img{
    width:100%;
    height:190px;
    object-fit:cover;
}

.card .card-body{
    padding:16px;
}

.card h3{margin:0}
.card p{
    margin-top:6px;
    color:var(--muted);
    font-size:14px;
}

/* ================= ADS ================= */
.ads{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:22px;
}

.ads img{
    width:100%;
    border-radius:18px;
    box-shadow:0 8px 26px rgba(0,0,0,0.15);
}

/* ================= FOOTER ================= */
footer{
    background:white;
    text-align:center;
    padding:28px;
    color:#777;
    font-size:14px;
}
</style>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<header>
    <div class="navbar">
        <div class="logo">✈ TripEase</div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="Register.jsp">Register</a>
            <a class="btn" href="Login.jsp">Login</a>
        </div>
    </div>
</header>

<!-- ================= HERO ================= -->
<section class="hero">
    <video autoplay muted loop>
        <source src="https://cdn.coverr.co/videos/coverr-waves-crashing-on-the-beach-8968/1080p.mp4" type="video/mp4">
    </video>
    <div class="hero-overlay">
        <div>
            <h1>Calm Journeys Begin Here</h1>
            <p>Discover destinations, relax & travel beautifully</p>
        </div>
    </div>
</section>

<!-- ================= SEARCH ================= -->
<div class="search-box">
    <input type="text" placeholder="Where do you want to go?">
    <input type="date">
    <button>Explore</button>
</div>

<!-- ================= OFFERS ================= -->
<section class="section">
    <div class="section-title">Special Travel Offers</div>
    <div class="ads">
        <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470">
        <img src="https://images.unsplash.com/photo-1491553895911-0055eca6402d">
        <img src="https://images.unsplash.com/photo-1526772662000-3f88f10405ff">
    </div>
</section>

<!-- ================= DESTINATIONS ================= -->
<section class="section">
    <div class="section-title">Popular Destinations</div>
    <div class="grid">
        <div class="card">
            <img src="https://images.unsplash.com/photo-1512453979798-5ea266f8880c">
            <div class="card-body"><h3>Goa</h3><p>Sun, beaches & nightlife</p></div>
        </div>
        <div class="card">
            <img src="https://images.unsplash.com/photo-1580656063820-306dfc0d7c4d">
            <div class="card-body"><h3>Mysore</h3><p>Royal heritage & culture</p></div>
        </div>
        <div class="card">
            <img src="https://images.unsplash.com/photo-1564501049412-61c2a3083791">
            <div class="card-body"><h3>Bengaluru</h3><p>Urban energy & cafes</p></div>
        </div>
        <div class="card">
            <img src="https://images.unsplash.com/photo-1532413992370-8b8c1e52b33c">
            <div class="card-body"><h3>Chennai</h3><p>Culture & coastlines</p></div>
        </div>
    </div>
</section>

<!-- ================= EXPERIENCE ================= -->
<section class="section">
    <div class="section-title">Travel Feelings</div>
    <div class="grid">
        <div class="card">
            <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee">
            <div class="card-body"><h3>Adventure</h3><p>Unforgettable moments</p></div>
        </div>
        <div class="card">
            <img src="https://images.unsplash.com/photo-1505761671935-60b3a7427bad">
            <div class="card-body"><h3>Relaxation</h3><p>Peaceful escapes</p></div>
        </div>
        <div class="card">
            <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e">
            <div class="card-body"><h3>Nature</h3><p>Fresh air & calm views</p></div>
        </div>
    </div>
</section>

<!-- ================= FOOTER ================= -->
<footer>
    © 2025 TripEase · Travel Beautifully
</footer>

</body>
</html>
