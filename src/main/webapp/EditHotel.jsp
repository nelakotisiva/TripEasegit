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
<title>Edit Hotel | TripEase Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    padding:40px;
    color:#2f2a23;
}

/* CONTAINER */
.form-box{
    max-width:520px;
    margin:0 auto;
    background:#ffffff;
    padding:26px 28px;
    border-radius:18px;
    border:1px solid #d9d2c3;
}

/* HEADER */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:16px;
}

.header h2{
    margin:0;
    font-size:24px;
    font-weight:600;
}

.back-btn{
    padding:6px 14px;
    border-radius:8px;
    background:#6b6256;
    color:white;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}

/* IMAGE PREVIEW */
.preview-box{
    text-align:center;
    margin-bottom:18px;
}

.preview-box img{
    width:100%;
    max-width:360px;
    height:200px;
    object-fit:cover;
    border-radius:14px;
    border:1px solid #d9d2c3;
}

/* LABEL */
label{
    font-size:13px;
    font-weight:500;
    display:block;
    margin-top:14px;
}

/* INPUTS */
input{
    width:100%;
    padding:11px 12px;
    margin-top:6px;
    border-radius:10px;
    border:1px solid #d9d2c3;
    font-size:14px;
}

input:focus{
    outline:none;
    border-color:#8a9a5b;
}

/* BUTTON */
button{
    width:100%;
    padding:12px;
    margin-top:20px;
    background:#8a9a5b;
    color:white;
    border:none;
    border-radius:12px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
}

button:hover{
    background:#7b8b50;
}

/* TIP */
.tip{
    font-size:12px;
    color:#6b6256;
    margin-top:6px;
}
</style>
</head>

<body>

<div class="form-box">

    <!-- HEADER WITH BACK BUTTON -->
    <div class="header">
        <h2>Edit Hotel</h2>
        <a href="ManageHotels" class="back-btn">Back</a>
    </div>

    <!-- IMAGE PREVIEW -->
    <div class="preview-box">
        <img src="<%= hotel.getImageUrl() %>" alt="Hotel Image"
             onerror="this.src='https://via.placeholder.com/360x200?text=No+Image'">
    </div>

    <form action="EditHotel" method="post">

        <input type="hidden" name="hotelId" value="<%= hotel.getHotelId() %>">

        <label>Hotel Name</label>
        <input type="text" name="hotelName"
               value="<%= hotel.getHotelName() %>" required>

        <label>Location</label>
        <input type="text" name="nearLocation"
               value="<%= hotel.getNearLocation() %>" required>

        <label>Price Per Night</label>
        <input type="number" name="price"
               value="<%= hotel.getPricePerNight() %>" required>

        <label>Rooms Available</label>
        <input type="number" name="rooms"
               value="<%= hotel.getRoomsAvailable() %>" required>

        <label>Image URL</label>
        <input type="text" name="imageUrl"
               value="<%= hotel.getImageUrl() %>" required>

        <div class="tip">
            Tip: You can use an Unsplash URL like<br>
            https://source.unsplash.com/800x600/?hotel
        </div>

        <button type="submit">Update Hotel</button>

    </form>

</div>

</body>
</html>
