<%@ page import="dtopackage.com.Hotel" %>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    Hotel hotel = (Hotel) request.getAttribute("hotel");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Hotel</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500&display=swap" rel="stylesheet">

<style>
body { font-family:'Poppins',sans-serif; background:#eef3ff; padding:40px; }
.form-box { max-width:480px; margin-left:300px; background:white; padding:25px;
            border-radius:20px; box-shadow:0 8px 25px rgba(0,0,0,0.15); }
input { width:100%; padding:10px; margin-top:8px; border-radius:10px; border:1px solid #ccc; }
button { padding:12px; width:100%; background:#0032d8; color:white; font-weight:600;
         border:none; border-radius:10px; margin-top:12px; }

.preview-box { text-align:center; margin-bottom:15px; }
.preview-box img { width:300px; height:180px; border-radius:15px; box-shadow:0 6px 20px rgba(0,0,0,0.2); }
</style>

</head>

<body>

<div class="form-box">
<h2>Edit Hotel</h2>

<div class="preview-box">
    <img src="<%= hotel.getImageUrl() %>" alt="Hotel Image">
</div>

<form action="EditHotel" method="post">

    <input type="hidden" name="hotelId" value="<%= hotel.getHotelId() %>">

    Hotel Name:
    <input type="text" name="hotelName" value="<%= hotel.getHotelName() %>" required>

    Location:
    <input type="text" name="nearLocation" value="<%= hotel.getNearLocation() %>" required>

    Price Per Night:
    <input type="number" name="price" value="<%= hotel.getPricePerNight() %>" required>

    Rooms Available:
    <input type="number" name="rooms" value="<%= hotel.getRoomsAvailable() %>" required>

    Image URL:
    <input type="text" name="imageUrl" value="<%= hotel.getImageUrl() %>" required>

    <small>Tip: You can paste an Unsplash URL like:<br>
    https://source.unsplash.com/800x600/?hotel</small>

    <button type="submit">Update Hotel</button>

</form>
</div>

</body>
</html>
