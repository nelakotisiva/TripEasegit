<%@ page import="dtopackage.com.Restaurant" %>

<%
Restaurant r = (Restaurant) request.getAttribute("restaurant");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Restaurant | TripEase Admin</title>

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
.container{
    max-width:520px;
    margin:auto;
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
    margin-bottom:18px;
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

/* LABEL */
label{
    display:block;
    font-size:13px;
    font-weight:500;
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

/* PREVIEW IMAGE */
.preview{
    width:100%;
    height:200px;
    object-fit:cover;
    border-radius:12px;
    border:1px solid #d9d2c3;
    margin-top:14px;
}

/* BUTTON */
.btn{
    width:100%;
    padding:12px;
    margin-top:22px;
    background:#8a9a5b;
    color:white;
    border:none;
    border-radius:12px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
}

.btn:hover{
    background:#7b8b50;
}
</style>

<script>
function showPreview(){
    var url = document.getElementById("imageUrl").value;
    document.getElementById("previewImg").src = url;
}
</script>

</head>
<body>

<div class="container">

    <!-- HEADER WITH BACK BUTTON -->
    <div class="header">
        <h2>Edit Restaurant</h2>
        <a href="adminRestaurant?action=list" class="back-btn">Back</a>
    </div>

    <form action="adminRestaurant" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="restaurant_id"
               value="<%= r.getRestaurantId() %>">

        <label>Destination ID</label>
        <input type="number" name="destination_id"
               value="<%= r.getDestinationId() %>" required>

        <label>Restaurant Name</label>
        <input type="text" name="name"
               value="<%= r.getName() %>" required>

        <label>Type</label>
        <input type="text" name="type"
               value="<%= r.getType() %>" required>

        <label>Rating</label>
        <input type="number" step="0.1" name="rating"
               value="<%= r.getRating() %>" required>

        <label>Contact Number</label>
        <input type="number" name="contact"
               value="<%= r.getContact() %>" required>

        <label>Avg Price</label>
        <input type="number" step="0.01" name="avg_price"
               value="<%= r.getAvgPrice() %>" required>

        <label>Image URL</label>
        <input type="text" id="imageUrl" name="image_url"
               value="<%= r.getImageUrl() %>"
               onkeyup="showPreview()">

        <img id="previewImg" class="preview"
             src="<%= r.getImageUrl() %>"
             onerror="this.src='https://via.placeholder.com/520x200?text=No+Image'">

        <button class="btn">Update Restaurant</button>

    </form>

</div>

</body>
</html>
