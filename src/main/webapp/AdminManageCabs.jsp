<%@ page import="java.util.*" %>
<%@ page import="dtopackage.com.Cab" %>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("Adminlogin.jsp");
        return;
    }

    List<Cab> list = (List<Cab>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | Manage Cab Rentals</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family: Poppins, sans-serif;
    background:#eef3ff;
    padding:40px;
}

/* Title */
h1{
    color:#0032d8;
    margin-bottom:25px;
    font-size:32px;
    font-weight:600;
}

/* ADD CAB FORM LAYOUT */
form{
    margin:20px 0;
    display:flex;
    gap:15px;
}

form input, form select{
    padding:12px;
    border-radius:8px;
    border:1px solid #ccc;
    width:180px;
    font-size:14px;
}

form button{
    padding:12px 20px;
    background:#0032d8;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
}

/* TABLE */
table{
    width:100%;
    background:white;
    border-radius:12px;
    margin-top:20px;
    border-collapse:separate;
    border-spacing:0 10px;     /* Row spacing */
}

/* Table Header Row */
th{
    padding:15px;
    background:#0032d8;
    color:white;
    font-size:15px;
    font-weight:600;
}

/* Table Body Row */
tr{
    background:white;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    border-radius:12px;
}

td{
    padding:18px;
    text-align:center;
    font-size:15px;
}

/* Image Styling */
img{
    width:120px;
    height:80px;
    border-radius:10px;
    object-fit:cover;
}

/* Edit + Delete Buttons */
.btn{
    padding:8px 16px;
    border-radius:8px;
    border:none;
    cursor:pointer;
    font-weight:600;
}

.edit-btn{
    background:#0032d8;
    color:white;
}

.delete-btn{
    background:#ff4747;
    color:white;
}

/* Center column */
.delete-cell{
    display:flex;
    justify-content:center;
}

/* BIGGER EDIT POPUP */
#editBox{
    width: 520px;
    background: #fff;
    padding: 30px;
    border-radius: 18px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    box-shadow: 0 10px 40px rgba(0,0,0,0.25);
    display: none;
    animation: popin .25s ease-out;
}

@keyframes popin {
    from { transform: translate(-50%, -40%) scale(0.9); opacity: 0; }
    to   { transform: translate(-50%, -50%) scale(1); opacity: 1; }
}


#editBox input{
    width:100%;
    margin:12px 0;
    padding:14px;
    border-radius:8px;
    border:1px solid #ccc;
    font-size:15px;
}

/* Overlay */
#overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.55);
    display: none;
    backdrop-filter: blur(3px);
}
</style>


<script>
function openEdit(id, model, seater, price, location, image){
    document.getElementById("eid").value = id;
    document.getElementById("emodel").value = model;
    document.getElementById("eseater").value = seater;
    document.getElementById("eprice").value = price;
    document.getElementById("elocation").value = location;
    document.getElementById("eimage").value = image;

    document.getElementById("overlay").style.display="block";
    document.getElementById("editBox").style.display="block";
}

function closeEdit(){
    document.getElementById("overlay").style.display="none";
    document.getElementById("editBox").style.display="none";
}
</script>

</head>
<body>

<h1>Manage Cab Rentals</h1>

<!-- ADD CAB FORM -->
<form method="post" action="AdminManageCabs">
    <input name="model" placeholder="Model" required>
    <select name="seater">
        <option>4 Seater</option>
        <option>5 Seater</option>
        <option>7 Seater</option>
    </select>
    <input name="price" placeholder="Price/Day" required>
    <input name="location" placeholder="Location" required>
    <input name="imageUrl" placeholder="Image URL" required>
    <button name="action" value="add">Add Cab</button>
</form>

<!-- CAB TABLE -->
<table>
<tr>
<th>ID</th>
<th>Image</th>
<th>Model</th>
<th>Seater</th>
<th>Price</th>
<th>Status</th>
<th>Location</th>
<th>Edit</th>
<th>Delete</th>
</tr>

<% for(Cab c : list){ %>
<tr>
<td><%= c.getRentalId() %></td>
<td><img src="<%= c.getImageUrl() %>"></td>
<td><%= c.getModel() %></td>
<td><%= c.getSeaterType() %></td>
<td><%= c.getPricePerDay() %></td>
<td><%= c.getAvailability() %></td>
<td><%= c.getLocation() %></td>

<!-- EDIT BUTTON -->
<td>
<button type="button"
 onclick="openEdit(
      '<%= c.getRentalId() %>',
      '<%= c.getModel() %>',
      '<%= c.getSeaterType() %>',
      '<%= c.getPricePerDay() %>',
      '<%= c.getLocation() %>',
      '<%= c.getImageUrl() %>'
 )">Edit</button>
</td>

<!-- DELETE -->
<td class="delete-cell">
    <form method="post" action="AdminManageCabs">
        <input type="hidden" name="id" value="<%= c.getRentalId() %>">
        <button name="action" value="delete">Delete</button>
    </form>
</td>

</tr>
<% } %>

</table>

<!-- EDIT POPUP -->
<div id="overlay" onclick="closeEdit()"></div>

<div id="editBox">
    <h3>Edit Cab Details</h3>

    <form method="post" action="AdminManageCabs">

        <input type="hidden" id="eid" name="id">

        <div class="edit-grid">

            <div>
                <label>Model</label>
                <input id="emodel" name="model">
            </div>

            <div>
                <label>Seater Type</label>
                <input id="eseater" name="seater">
            </div>

            <div>
                <label>Price Per Day</label>
                <input id="eprice" name="price">
            </div>

            <div>
                <label>Location</label>
                <input id="elocation" name="location">
            </div>

            <div>
                <label>Image URL</label>
                <input id="eimage" name="imageUrl">
            </div>

        </div>

        <div class="edit-buttons">
            <button class="update-btn" name="action" value="update">Update</button>
            <button type="button" class="cancel-btn" onclick="closeEdit()">Cancel</button>
        </div>

    </form>
</div>



</body>
</html>