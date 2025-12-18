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
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{ box-sizing:border-box; }

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#eef3ff;
    padding:30px;
}

/* ===== HEADER ===== */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.header h1{
    color:#0032d8;
    font-size:32px;
    font-weight:700;
}

.back-btn{
    padding:12px 22px;
    background:#6c757d;
    color:white;
    text-decoration:none;
    border-radius:10px;
    font-weight:600;
    transition:0.3s;
}
.back-btn:hover{
    background:#5a6268;
}

/* ===== ADD FORM ===== */
.add-form{
    background:white;
    padding:22px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,0.12);
    display:grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap:16px;
    margin-bottom:30px;
}

.add-form input,
.add-form select{
    padding:12px;
    border-radius:10px;
    border:1px solid #cdd6ff;
    font-size:14px;
    width:100%;
}

.add-form button{
    grid-column: span 2;
    padding:14px;
    background:#0032d8;
    color:white;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
}
.add-form button:hover{
    background:#0026aa;
}

/* ===== TABLE ===== */
.table-wrapper{
    background:white;
    padding:20px;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
}

table{
    width:100%;
    border-collapse:collapse;
    font-size:14px;
}

thead{
    background:#0032d8;
    color:white;
}

th, td{
    padding:14px;
    text-align:center;
}

tbody tr:nth-child(even){
    background:#f4f6ff;
}

tbody tr:hover{
    background:#e9edff;
}

img{
    width:120px;
    height:80px;
    border-radius:10px;
    object-fit:cover;
}

/* ===== ACTION BUTTONS ===== */
.action-btn{
    padding:8px 16px;
    border:none;
    border-radius:8px;
    color:white;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
}

.edit-btn{
    background:#0066ff;
}
.delete-btn{
    background:#ff3b3b;
}
.action-btn:hover{
    opacity:0.9;
}

/* ===== EDIT POPUP ===== */
#overlay{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.55);
    display:none;
}

#editBox{
    position:fixed;
    top:50%;
    left:50%;
    transform:translate(-50%, -50%);
    background:white;
    padding:28px;
    width:520px;
    border-radius:22px;
    box-shadow:0 12px 40px rgba(0,0,0,0.25);
    display:none;
}

#editBox h3{
    margin-bottom:15px;
    color:#0032d8;
}

#editBox input{
    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:10px;
    border:1px solid #ccc;
}

.edit-actions{
    display:flex;
    justify-content:flex-end;
    gap:12px;
    margin-top:15px;
}

.update-btn{
    background:#0032d8;
    color:white;
    padding:10px 20px;
    border:none;
    border-radius:10px;
    font-weight:600;
    cursor:pointer;
}

.cancel-btn{
    background:#6c757d;
    color:white;
    padding:10px 20px;
    border:none;
    border-radius:10px;
    font-weight:600;
    cursor:pointer;
}
</style>

<script>
function openEdit(id, model, seater, price, location, image){
    eid.value = id;
    emodel.value = model;
    eseater.value = seater;
    eprice.value = price;
    elocation.value = location;
    eimage.value = image;
    overlay.style.display = "block";
    editBox.style.display = "block";
}

function closeEdit(){
    overlay.style.display = "none";
    editBox.style.display = "none";
}
</script>

</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>Manage Cab Rentals</h1>
    <a href="AdminDashboard.jsp" class="back-btn">Back to Dashboard</a>
</div>

<!-- ADD CAB FORM -->
<form class="add-form" method="post" action="AdminManageCabs">
    <input name="model" placeholder="Model" required>

    <select name="seater">
        <option>4 Seater</option>
        <option>5 Seater</option>
        <option>7 Seater</option>
    </select>

    <input name="price" placeholder="Price / Day" required>
    <input name="location" placeholder="Location" required>
    <input name="imageUrl" placeholder="Image URL" required>

    <button name="action" value="add">Add Cab</button>
</form>

<!-- TABLE -->
<div class="table-wrapper">
<table>
<thead>
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
</thead>
<tbody>

<% for(Cab c : list){ %>
<tr>
    <td><%= c.getRentalId() %></td>
    <td><img src="<%= c.getImageUrl() %>"></td>
    <td><%= c.getModel() %></td>
    <td><%= c.getSeaterType() %></td>
    <td>₹ <%= c.getPricePerDay() %></td>
    <td><%= c.getAvailability() %></td>
    <td><%= c.getLocation() %></td>

    <td>
        <button type="button"
                class="action-btn edit-btn"
                onclick="openEdit(
                    '<%= c.getRentalId() %>',
                    '<%= c.getModel() %>',
                    '<%= c.getSeaterType() %>',
                    '<%= c.getPricePerDay() %>',
                    '<%= c.getLocation() %>',
                    '<%= c.getImageUrl() %>'
                )">Edit</button>
    </td>

    <td>
        <form method="post" action="AdminManageCabs">
            <input type="hidden" name="id" value="<%= c.getRentalId() %>">
            <button class="action-btn delete-btn"
                    name="action"
                    value="delete"
                    onclick="return confirm('Delete this cab?')">
                Delete
            </button>
        </form>
    </td>
</tr>
<% } %>

</tbody>
</table>
</div>

<!-- EDIT POPUP -->
<div id="overlay" onclick="closeEdit()"></div>

<div id="editBox">
    <h3>Edit Cab</h3>
    <form method="post" action="AdminManageCabs">
        <input type="hidden" id="eid" name="id">
        <input id="emodel" name="model" placeholder="Model">
        <input id="eseater" name="seater" placeholder="Seater">
        <input id="eprice" name="price" placeholder="Price / Day">
        <input id="elocation" name="location" placeholder="Location">
        <input id="eimage" name="imageUrl" placeholder="Image URL">

        <div class="edit-actions">
            <button class="update-btn" name="action" value="update">Update</button>
            <button type="button" class="cancel-btn" onclick="closeEdit()">Cancel</button>
        </div>
    </form>
</div>

</body>
</html>
