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

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Inter,sans-serif;
    background:#f5f2ec;
    padding:30px;
    color:#2f2a23;
}

/* CONTAINER */
.container{
    max-width:1200px;
    margin:auto;
}

/* HEADER */
.header{
    background:#ffffff;
    padding:22px 26px;
    border-radius:16px;
    border:1px solid #d9d2c3;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.header h1{
    margin:0;
    font-size:26px;
    font-weight:600;
}

/* BUTTON */
.back-btn{
    padding:10px 18px;
    border-radius:10px;
    background:#6b6256;
    color:white;
    text-decoration:none;
    font-weight:600;
}

/* ADD FORM */
.add-form{
    background:#ffffff;
    padding:22px;
    border-radius:16px;
    border:1px solid #d9d2c3;
    display:grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap:16px;
    margin-bottom:26px;
}

.add-form input,
.add-form select{
    padding:12px;
    border-radius:10px;
    border:1px solid #d9d2c3;
    font-size:14px;
    width:100%;
}

.add-form button{
    grid-column: span 2;
    padding:14px;
    background:#8a9a5b;
    color:white;
    border:none;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
}

/* TABLE */
.table-wrapper{
    background:#ffffff;
    padding:22px;
    border-radius:16px;
    border:1px solid #d9d2c3;
}

table{
    width:100%;
    border-collapse:collapse;
    font-size:14px;
}

th{
    background:#f1efe8;
    padding:14px;
    text-align:center;
    font-weight:600;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
}

tr:hover td{
    background:#faf9f6;
}

img{
    width:120px;
    height:80px;
    border-radius:10px;
    object-fit:cover;
    border:1px solid #d9d2c3;
}

/* ACTION BUTTONS */
.action-btn{
    padding:8px 16px;
    border:none;
    border-radius:8px;
    color:white;
    font-weight:600;
    cursor:pointer;
}

.edit-btn{ background:#8a9a5b; }
.delete-btn{ background:#b94a48; }

/* EDIT POPUP */
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
    border-radius:18px;
    border:1px solid #d9d2c3;
    display:none;
}

#editBox h3{
    margin-bottom:15px;
    font-size:20px;
}

#editBox input{
    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:10px;
    border:1px solid #d9d2c3;
}

.edit-actions{
    display:flex;
    justify-content:flex-end;
    gap:12px;
    margin-top:15px;
}

.update-btn{
    background:#8a9a5b;
    color:white;
    padding:10px 20px;
    border:none;
    border-radius:10px;
    font-weight:600;
    cursor:pointer;
}

.cancel-btn{
    background:#6b6256;
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

<div class="container">

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
                <td>
                    <img src="<%= c.getImageUrl() %>"
                         onerror="this.src='https://via.placeholder.com/120x80?text=No+Image'">
                </td>
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

        </table>
    </div>

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
