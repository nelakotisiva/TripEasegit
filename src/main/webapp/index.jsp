<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TripEase | India's Premium Travel App</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --brand-blue: #00A3FF; 
            --app-bg: #F8FAFC;
            --card-bg: #FFFFFF;
            --text-main: #0F172A;
            --text-muted: #64748B;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--app-bg);
            color: var(--text-main);
        }

        header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid #E2E8F0;
        }

        .nav {
            max-width: 1200px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 20px;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            color: #0F172A;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logo-box {
            width: 34px;
            height: 34px;
            background: var(--brand-blue);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 700;
            font-size: 14px;
        }

        .login-btn {
            background: #0F172A;
            color: white !important;
            padding: 8px 18px;
            border-radius: 8px;
        }

        main {
            max-width: 1200px;
            margin: 90px auto 40px;
            padding: 0 20px;
        }

        .hero-banner {
            height: 220px;
            border-radius: 24px;
            overflow: hidden;
            position: relative;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            padding: 40px;
            background: linear-gradient(to right, rgba(255,255,255,0.8), rgba(255,255,255,0));
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .hero-bg-video {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 0;
        }

        .hero-banner h1 {
            position: relative;
            z-index: 1;
            font-size: 28px;
            font-weight: 800;
        }

        .section-header {
            margin-bottom: 20px;
        }

        .section-header h2 {
            font-size: 22px;
            font-weight: 800;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 60px;
        }

        .card {
            height: 300px;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            border: 1px solid #E2E8F0;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .card-info {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            color: white;
        }

        @media (max-width: 900px) {
            .grid {
                grid-template-columns: repeat(2,1fr);
            }
        }
    </style>
</head>

<body>

<header>
    <nav class="nav">
        <a href="index.jsp" class="logo">
            <div class="logo-box">✈</div>
            TripEase
        </a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="Register.jsp">Register</a>
            <a href="Login.jsp" class="login-btn">Login</a>
        </div>
    </nav>
</header>

<main>

    <div class="hero-banner">
        <video class="hero-bg-video" autoplay muted loop playsinline>
            <source src="assets/videos/Trip.mp4" type="video/mp4">
        </video>
        <h1>
            Explore Smarter.<br>
            <span style="color:var(--brand-blue)">Premium</span> stays.
        </h1>
    </div>

    <div class="section-header">
        <h2>Trending Destinations</h2>
    </div>

    <div class="grid">
        <!-- ORIGINAL 8 -->
        <div class="card"><img src="https://images.unsplash.com/photo-1537996194471-e657df975ab4"><div class="card-info"><h3>Bali Escape</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1547234935-80c7145ec969"><div class="card-info"><h3>Santorini</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1512453979798-5ea266f8880c"><div class="card-info"><h3>Dubai</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1523906834658-6e24ef2386f9"><div class="card-info"><h3>Venice</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e"><div class="card-info"><h3>Maldives</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1505761671935-60b3a7427bad"><div class="card-info"><h3>Paris</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1541417904950-b855846fe074"><div class="card-info"><h3>Switzerland</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1"><div class="card-info"><h3>Thailand</h3></div></div>

        <!-- EXTRA 4 (London image changed) -->
        <div class="card"><img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee"><div class="card-info"><h3>New York</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1488747279002-c8523379faaa"><div class="card-info"><h3>London</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf"><div class="card-info"><h3>Tokyo</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1502602898657-3e91760cbb34"><div class="card-info"><h3>Rome</h3></div></div>
    </div>

</main>

<jsp:include page="footer.jsp" />

</body>
</html>
