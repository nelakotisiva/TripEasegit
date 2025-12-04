<%@ page import="dtopackage.com.Restaurant" %>
<%
Restaurant r = (Restaurant) request.getAttribute("restaurant");
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Restaurant</title>
<style>
body{background:#e8f0ff;font-family:Poppins;}
.box{width:400px;margin:auto;background:white;padding:20px;border-radius:10px;}
input{width:95%;margin:8px 0;padding:10px;border:1px solid #013bff;border-radius:8px;}
button{width:100%;padding:10px;background:#013bff;color:white;border:none;border-radius:8px;}
</style>
</head>
<body>
<div class="box">
<h2>Edit Restaurant</h2>

<form action="adminRestaurant" method="post">
<input type="hidden" name="action" value="update">
<input name="id" value="<%=r.getRestaurantId()%>" >
<input name="destinationId" value="<%=r.getDestinationId()%>" required>
<input name="name" value="<%=r.getName()%>" required>
<input name="type" value="<%=r.getType()%>" required>
<input name="rating" value="<%=r.getRating()%>" required>
<input name="contact" value="<%=r.getContact()%>" required>
<input name="avgPrice" value="<%=r.getAvgPrice()%>" required>
<input name="latitude" value="<%=r.getLatitude()%>" required>
<input name="longitude" value="<%=r.getLongitude()%>" required>
<button type="submit">Update</button><br><br>
<a href="adminRestaurant?action=list">Back</a>
</form>

</div>
</body>
</html>
