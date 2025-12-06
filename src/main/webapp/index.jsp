<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TripEase | Plan Your Perfect Stay</title>

<style>

    body {
        margin: 0;
        font-family: "Poppins", sans-serif;
        background: #f4f7f7;
        scroll-behavior: smooth;
    }

    /* ---------- NAVBAR ---------- */
    .navbar {
        background: #ffffff;
        padding: 14px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        position: sticky;
        top: 0;
        z-index: 10;
    }

    .logo {
        font-size: 26px;
        font-weight: 700;
        color: #3ba58b;
    }

    .nav-links a {
        margin-left: 25px;
        text-decoration: none;
        color: #333;
        font-weight: 600;
        font-size: 15px;
    }

    .nav-links a:hover {
        color: #3ba58b;
    }

    /* ---------- HERO SECTION ---------- */
    .hero {
        width: 100%;
        height: 380px;
        background: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e') no-repeat center center/cover;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .hero-overlay {
        background: rgba(0, 0, 0, 0.45);
        padding: 40px;
        border-radius: 12px;
        text-align: center;
    }

    .hero-title {
        font-size: 38px;
        color: white;
        font-weight: 700;
    }

    .hero-sub {
        font-size: 18px;
        color: #f2f2f2;
        margin-top: 10px;
    }

    /* ---------- SEARCH BOX ---------- */
    .search-area {
        width: 70%;
        margin: -25px auto 40px auto;
        background: white;
        padding: 20px;
        border-radius: 14px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        display: flex;
        justify-content: center;
    }

    .search-input {
        width: 60%;
        padding: 12px;
        border-radius: 10px;
        border: 1px solid #b8d4cf;
        font-size: 16px;
        outline: none;
    }

    .search-btn {
        padding: 12px 24px;
        margin-left: 10px;
        border-radius: 10px;
        border: none;
        background: #3ba58b;
        color: white;
        font-size: 16px;
        cursor: pointer;
        font-weight: bold;
    }

    .search-btn:hover {
        background: #2f8a74;
    }

    /* ---------- SECTION TITLE ---------- */
    .section-title {
        font-size: 26px;
        font-weight: 700;
        text-align: center;
        margin: 40px 0 20px;
        color: #1f3a3d;
    }

    /* ---------- IMAGE GRID ---------- */
    .grid {
        width: 90%;
        margin: auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
    }

    .card {
        height: 180px;
        border-radius: 14px;
        overflow: hidden;
        position: relative;
        cursor: pointer;
        box-shadow: 0 3px 15px rgba(0,0,0,0.1);
        transition: 0.3s;
    }

    .card:hover {
        transform: scale(1.04);
    }

    .card img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .card-label {
        position: absolute;
        bottom: 8px;
        left: 12px;
        color: white;
        font-weight: bold;
        font-size: 18px;
        text-shadow: 0 3px 6px rgba(0,0,0,0.4);
    }

    /* ---------- FOOTER ---------- */
    .footer {
        margin-top: 40px;
        background: #ffffff;
        padding: 18px;
        text-align: center;
        color: #555;
        font-size: 14px;
        box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
    }

</style>

</head>
<body>

<!-- ---------- NAVBAR ---------- -->
<div class="navbar">
    <div class="logo">TripEase</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="HotelListServlet">Hotels</a>
        <a href="#cabs">Cabs</a>
        <a href="#restaurants">Restaurants</a>
        <a href="Login.jsp">Login</a>
        <a href="Register.jsp">Register</a>
    </div>
</div>

<!-- ---------- HERO ---------- -->
<div class="hero">
    <div class="hero-overlay">
        <div class="hero-title">Plan Your Perfect Trip</div>
        <div class="hero-sub">Hotels • Cabs • Restaurants — Everything at one place</div>
    </div>
</div>

<!-- ---------- SEARCH BOX ---------- -->
<div class="search-area">
    <form action="HotelListServlet" method="get">
        <input type="text" class="search-input" name="location" placeholder="Search hotels, cabs, restaurants..." required>
        <button class="search-btn">Search</button>
    </form>
</div>

<!-- ---------- POPULAR DESTINATIONS ---------- -->
<div class="section-title">Popular Destinations</div>

<div class="grid">
    <div class="card"><img src="https://images.unsplash.com/photo-1512453979798-5ea266f8880c"><div class="card-label">Goa</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1532413992370-8b8c1e52b33c"><div class="card-label">Chennai</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1564501049412-61c2a3083791"><div class="card-label">Bengaluru</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1562771242-bd6bbf31cf8e"><div class="card-label">Mumbai</div></div>
</div>

<!-- ---------- FEATURED HOTELS ---------- -->
<div class="section-title">Featured Hotels</div>

<div class="grid">
    <div class="card"><img src="https://cf.bstatic.com/xdata/images/hotel/max1024x768/19399570.jpg"><div class="card-label">Taj Resort</div></div>
    <div class="card"><img src="https://cf.bstatic.com/xdata/images/hotel/max1024x768/157535773.jpg"><div class="card-label">Radisson Blu</div></div>
    <div class="card"><img src="https://cf.bstatic.com/xdata/images/hotel/max1024x768/318783361.jpg"><div class="card-label">Heritage Madurai</div></div>
</div>

<!-- ---------- FEATURED RESTAURANTS ---------- -->
<div class="section-title" id="restaurants">Popular Restaurants</div>

<div class="grid">
    <div class="card"><img src="https://images.unsplash.com/photo-1552566626-52f8b828add9"><div class="card-label">BBQ Nation</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1528605248644-14dd04022da1"><div class="card-label">Olive Bistro</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1555992336-03a23c7151dd"><div class="card-label">Paradise Biryani</div></div>
</div>

<!-- ---------- FEATURED CABS ---------- -->
<div class="section-title" id="cabs">Cab Services</div>

<div class="grid">
    <div class="card"><img src="https://images.unsplash.com/photo-1549923746-c502d488b3ea"><div class="card-label">Ola Cabs</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1500917293891-ef795e70e1f6"><div class="card-label">Uber</div></div>
    <div class="card"><img src="https://images.unsplash.com/photo-1542365887-1f6ab59f7e74"><div class="card-label">Local Taxi</div></div>
</div>

<!-- ---------- FOOTER ---------- -->
<div class="footer">
    © 2025 TripEase – Your All-in-One Travel Companion
</div>

</body>
</html>
