<%@ page import="java.util.*" %>
<%@ page import="dtopackage.com.Cab" %>

<%
    if(session.getAttribute("adminObj")==null){
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<Cab> list = (List<Cab>)request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | Manage Cab Rentals</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:Poppins;
    background:#eef3ff;
    padding:40px;
}

h1{
    color:#0032d8;
    margin-bottom:20px;
}

table{
    width:100%;
    background:white;
    border-radius:12px;
    box-shadow:0 8px 25px rgba(0,0,0,0.2);
    border-collapse:collapse;
}

th,td{
    padding:12px;
    text-align:center;
}

th{
    background:#0032d8;
    color:white;
}

img{
    width:120px;
    height:80px;
    border-radius:10px;
}

form{
    margin:20px 0;
    display:grid;
    grid-template-columns:repeat(6,1fr);
    gap:10px;
}

input,select,button{
    padding:10px;
    border-radius:6px;
    border:1px solid #ccc;
}

button{
    background:#0032d8;
    color:white;
    cursor:pointer;
}
</style>
</head>

<body>

<h1>🚕 Manage Cab Rentals</h1>

<form method="post" action="AdminManageCabs">
<input name="model" placeholder="Model" required>
<select name="seater">
<option>4 Seater</option>
<option>5 Seater</option>
<option>7 Seater</option>
</select>
<input name="price" placeholder="Price">
<input name="destination" placeholder="Destination ID">
<input name="image" placeholder="Image URL">
<button name="action" value="add">Add Cab</button>
</form>

<table>
<tr>
<th>ID</th>
<th>Image</th>
<th>Model</th>
<th>Seater</th>
<th>Price</th>
<th>Status</th>
<th>Location</th>
<th>Delete</th>
</tr>

<% for(Cab c:list){ %>
<tr>
<td><%= c.getRentalId() %></td>
<td><img src="<%= c.getImageUrl() %>"></td>
<td><%= c.getModel() %></td>
<td><%= c.getSeaterType() %></td>
<td>₹ <%= c.getPricePerDay() %></td>
<td><%= c.getAvailability() %></td>
<td><%= c.getLocation() %></td>
<td>
<form method="post" action="AdminManageCabs">
<input type="hidden" name="id" value="<%= c.getRentalId() %>">
<button name="action" value="delete">Delete</button>
</form>
</td>
</tr>
<% } %>

</table>

</body>
</html>
