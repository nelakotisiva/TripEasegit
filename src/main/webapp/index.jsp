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
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--app-bg); color: var(--text-main); }

        header {
            position: fixed; top: 0; width: 100%; z-index: 1000;
            background: rgba(255,255,255,0.9); backdrop-filter: blur(15px);
            border-bottom: 1px solid #E2E8F0;
        }
        .nav {
            max-width: 1200px; margin: 0 auto;
            display: flex; justify-content: space-between; align-items: center;
            padding: 12px 20px;
        }
        .logo {
            font-size: 22px; font-weight: 800; color: #0F172A;
            text-decoration: none; display: flex; gap: 8px; align-items: center;
        }
        .logo-box {
            width: 34px; height: 34px; background: var(--brand-blue);
            border-radius: 8px; display: flex; align-items: center; justify-content: center;
            color: #fff;
        }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a {
            text-decoration: none; color: var(--text-muted);
            font-weight: 700; font-size: 14px;
        }
        .login-btn {
            background: #0F172A; color: #fff !important;
            padding: 8px 18px; border-radius: 8px;
        }

        main { max-width: 1200px; margin: 90px auto 40px; padding: 0 20px; }

        .hero-banner {
            height: 220px; border-radius: 24px; overflow: hidden;
            position: relative; margin-bottom: 40px;
            display: flex; align-items: center; padding: 40px;
            background: linear-gradient(to right, rgba(255,255,255,0.8), rgba(255,255,255,0));
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .hero-bg-video {
            position: absolute; inset: 0;
            width: 100%; height: 100%;
            object-fit: cover; z-index: 0;
        }
        .hero-banner h1 {
            position: relative; z-index: 1;
            font-size: 28px; font-weight: 800;
        }

        .section-header {
            display: flex; justify-content: space-between;
            align-items: center; margin-bottom: 20px;
        }
        .section-header h2 { font-size: 22px; font-weight: 800; }

        .grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px; margin-bottom: 60px;
        }
        .card {
            height: 300px; border-radius: 20px;
            overflow: hidden; position: relative;
            border: 1px solid #E2E8F0;
            transition: 0.3s;
        }
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .card img { width: 100%; height: 100%; object-fit: cover; }
        .card-info {
            position: absolute; bottom: 0;
            width: 100%; padding: 20px;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            color: #fff;
        }

        .footer-grid {
            max-width: 1200px;
            margin: 0 auto 40px;
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 40px;
        }
        .footer-col h4 {
            color: var(--brand-blue);
            margin-bottom: 20px;
            font-size: 14px;
        }
        .footer-col a, .footer-col p {
            color: #94A3B8;
            font-size: 14px;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
        }

        @media (max-width: 900px) {
            .grid { grid-template-columns: repeat(2,1fr); }
            .footer-grid { grid-template-columns: repeat(2,1fr); }
        }
    </style>
</head>

<body>

<header>
    <nav class="nav">
        <a href="index.jsp" class="logo">
            <div class="logo-box">✈</div> TripEase
        </a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="Register.jsp">Register</a>
            <a href="Login.jsp" class="login-btn">Login</a>
        </div>
    </nav>
</header>

<main>

    <!-- HERO -->
    <div class="hero-banner">
        <video class="hero-bg-video" autoplay muted loop playsinline>
            <source src="assets/videos/Trip.mp4" type="video/mp4">
        </video>
        <h1>
            Explore Smarter.<br>
            <span style="color:var(--brand-blue)">Premium</span> stays.
        </h1>
    </div>

    <!-- TRENDING -->
    <div class="section-header">
        <h2>Trending Destinations</h2>
    </div>

    <div class="grid">
        <div class="card"><img src="https://images.unsplash.com/photo-1537996194471-e657df975ab4"><div class="card-info"><h3>Bali Escape</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1547234935-80c7145ec969"><div class="card-info"><h3>Santorini</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1512453979798-5ea266f8880c"><div class="card-info"><h3>Dubai</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1523906834658-6e24ef2386f9"><div class="card-info"><h3>Venice</h3></div></div>
    </div>

    <!-- WHY CHOOSE -->
    <div class="section-header">
        <h2>Why Choose TripEase</h2>
    </div>

    <div class="grid" style="grid-template-columns:repeat(3,1fr)">
        <div class="card"><img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470"><div class="card-info"><h3>Handpicked Destinations</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1500534623283-312aade485b7"><div class="card-info"><h3>Luxury Stays</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1526772662000-3f88f10405ff"><div class="card-info"><h3>24/7 Support</h3></div></div>
    </div>

    <!-- POPULAR EXPERIENCES -->
    <div class="section-header">
        <h2>Popular Experiences</h2>
    </div>

    <div class="grid" style="grid-template-columns:repeat(3,1fr)">
        <div class="card"><img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e"><div class="card-info"><h3>Beach Holidays</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1469474968028-56623f02e42e"><div class="card-info"><h3>Mountain Adventures</h3></div></div>
        <div class="card"><img src="https://images.unsplash.com/photo-1505761671935-60b3a7427bad"><div class="card-info"><h3>City Tours</h3></div></div>
    </div>

</main>

<footer style="background:#000; padding:80px 20px 40px;">
    <div class="footer-grid">
        <div class="footer-col">
            <h4>About</h4>
            <a href="#">Our Vision</a>
            <a href="#">Careers</a>
            <a href="#">Press & Media</a>
        </div>
        <div class="footer-col">
            <h4>Information</h4>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms & Conditions</a>
            <a href="#">Refund Policy</a>
        </div>
        <div class="footer-col">
            <h4>Support</h4>
            <a href="#">Help Center</a>
            <a href="#">Cancellation</a>
            <a href="#">Safety Guidelines</a>
        </div>
        <div class="footer-col">
            <h4>Contact</h4>
            <p>Email: tripeaseproject@gmail.com</p>
            <p>Phone: +91 1800 44 5555</p>
            <p>Bengaluru, India</p>
        </div>
    </div>
          <jsp:include page="footer.jsp" />

   
</footer>

</body>
</html>

</body>
</html>
