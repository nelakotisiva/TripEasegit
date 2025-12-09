<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Object adminObj = session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Hotel</title>
    <style>
        body{font-family:Arial;background:#eef3ff}
        .box{width:500px;margin:40px auto;background:#fff;padding:25px;border-radius:10px}
        label{font-weight:bold;display:block;margin-top:10px}
        input{width:100%;padding:8px;margin-top:5px}
        button{margin-top:20px;width:100%;padding:10px;background:#0047ff;color:#fff;border:none}
        img{margin-top:10px;width:100%;display:none}
    </style>
    <script>
        function previewImage(e){
            let img = document.getElementById("preview");
            img.src = e.value;
            img.style.display = "block";
        }
    </script>
</head>
<body>

<div class="box">
<h2>Add New Hotel</h2>

<form action="AddHotel" method="post">

<label>Destination ID</label>
<input type="number" name="destinationId" required>

<label>Hotel Name</label>
<input type="text" name="hotelName" required>

<label>Area / Location</label>
<input type="text" name="nearLocation" required>

<label>Price per night</label>
<input type="number" name="price" step="0.01" required>

<label>Rooms Available</label>
<input type="number" name="rooms" required>

<label>Rating</label>
<input type="number" name="rating" step="0.1" min="0" max="5">

<label>Contact</label>
<input type="text" name="contact">

<label>Hotel Image URL</label>
<input type="text" name="imageUrl" oninput="previewImage(this)" required>

<img id="preview">

<button type="submit">Add Hotel</button>
</form>
</div>

</body>
</html>
