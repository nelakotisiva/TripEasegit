<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Add Restaurant</title>

<style>
body{margin:0;font-family:Poppins;background:#e8f0ff;}
.container{width:500px;margin:40px auto;background:white;padding:25px;border-radius:10px;box-shadow:0 0 10px #ccc;}
h2{color:#013bff;text-align:center;}
input,select{width:100%;padding:10px;margin:8px 0;border:1px solid #ccc;border-radius:6px;}
.btn{background:#013bff;color:white;padding:10px 15px;border:none;border-radius:6px;cursor:pointer;width:100%;}
.preview{width:100%;height:200px;border:1px solid #ddd;border-radius:6px;object-fit:cover;display:none;margin-top:10px;}
</style>

<script>
function showPreview() {
    let url = document.getElementById("imageUrl").value;
    let img = document.getElementById("previewImg");
    if(url.trim().length > 0){
        img.src = url;
        img.style.display = "block";
    }
}
</script>

</head>
<body>

<div class="container">
    <h2>Add Restaurant</h2>

    <form action="adminRestaurant" method="post">
        <input type="hidden" name="action" value="insert">

        <label>Destination ID</label>
        <input type="number" name="destination_id" required>

        <label>Restaurant Name</label>
        <input type="text" name="name" required>

        <label>Type</label>
        <input type="text" name="type" required>

        <label>Rating</label>
        <input type="number" step="0.1" name="rating" required>

        <label>Contact Number</label>
        <input type="number" name="contact" required>

        <label>Avg Price</label>
        <input type="number" step="0.01" name="avg_price" required>

        <label>Image URL</label>
        <input type="text" id="imageUrl" name="image_url" onkeyup="showPreview()">

        <img id="previewImg" class="preview">

        <button class="btn">Add Restaurant</button>
    </form>
</div>

</body>
</html>
