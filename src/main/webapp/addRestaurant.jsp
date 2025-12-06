<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Add Restaurant</title>
<style>
body{background:#e8f0ff;font-family:Poppins;}
.box{width:400px;margin:auto;background:white;padding:20px;border-radius:10px;}
input, select{width:95%;margin:8px 0;padding:10px;border:1px solid #013bff;border-radius:8px;}
button{width:100%;padding:10px;background:#013bff;color:white;border:none;border-radius:8px;}
a{text-decoration:none;}
</style>
</head>
<body>
<div class="box">
<h2>Add Restaurant</h2>

<form action="adminRestaurant" method="post">
    <input type="hidden" name="action" value="add">

    <!-- Destination Dropdown -->
    <select name="destinationId" required>
        <option value="">-- Select Destination --</option>
        <c:forEach var="d" items="${destinations}">
            <option value="${d.destinationId}">
                ${d.name} (ID: ${d.destinationId})
            </option>
        </c:forEach>
    </select>

    <input name="name" placeholder="Name" required>
    <input name="type" placeholder="Type" required>
    <input name="rating" placeholder="Rating" type="number" step="0.1" min="1" max="5" required>
    <input name="contact" placeholder="Contact" required>
    <input name="avgPrice" placeholder="Avg Price" type="number" step="0.01" required>
    <input name="latitude" placeholder="Latitude" required>
    <input name="longitude" placeholder="Longitude" required>

    <button type="submit">Save</button><br><br>
    <a href="adminRestaurant?action=list">Back</a>
</form>

</div>
</body>
</html>
