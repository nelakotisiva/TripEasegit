<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Restaurant" %>

<%
if (session.getAttribute("adminObj") == null) {
    response.sendRedirect("Adminlogin.jsp");
    return;
}
List<Restaurant> list = (List<Restaurant>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin | Manage Restaurants</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{box-sizing:border-box;}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#e8f0ff;
    padding:30px;
}

/* ===== PAGE WRAPPER ===== */
.container{
    max-width:1200px;
    margin:auto;
}

/* ===== HEADER CARD ===== */
.header-card{
    background:white;
    padding:22px 26px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,0.12);
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.header-card h1{
    margin:0;
    color:#0032d8;
    font-size:30px;
    font-weight:700;
}

/* ===== BUTTONS ===== */
.btn{
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    transition:0.3s;
}

.btn-primary{
    background:#013bff;
    color:white;
}
.btn-primary:hover{
    background:#002ed1;
}

.btn-secondary{
    background:#6c757d;
    color:white;
}
.btn-secondary:hover{
    background:#5a6268;
}

/* ===== ACTION BAR ===== */
.action-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:18px;
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
    background:#013bff;
    color:white;
}

th,td{
    padding:14px;
    text-align:center;
}

tbody tr:nth-child(even){
    background:#f4f6ff;
}

tbody tr:hover{
    background:#e9edff;
}

/* ===== ACTION BUTTONS ===== */
.action-btn{
    padding:6px 12px;
    border-radius:8px;
    color:white;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
    margin:0 3px;
}

.edit-btn{background:#007bff;}
.delete-btn{background:#ff2e2e;}

.action-btn:hover{
    opacity:0.9;
}

/* ===== IMAGE ===== */
img.thumb{
    width:90px;
    height:65px;
    object-fit:cover;
    border-radius:8px;
}
</style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="header-card">
        <h1>Manage Restaurants</h1>
        <a href="AdminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- ACTION BAR -->
    <div class="action-bar">
        <a class="btn btn-primary" href="adminRestaurant?action=add">
            Add Restaurant
        </a>
    </div>

    <!-- TABLE -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Destination</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Rating</th>
                    <th>Contact</th>
                    <th>Avg Price</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>

            <% 
            if(list != null && !list.isEmpty()){ 
                for(Restaurant r : list){ 
            %>
                <tr>
                    <td><%= r.getRestaurantId() %></td>
                    <td><%= r.getDestinationId() %></td>
                    <td><%= r.getName() %></td>
                    <td><%= r.getType() %></td>
                    <td><%= r.getRating() %></td>
                    <td><%= r.getContact() %></td>
                    <td>₹ <%= r.getAvgPrice() %></td>
                    <td>
                        <img class="thumb" src="<%= r.getImageUrl() %>" alt="Restaurant">
                    </td>
                    <td>
                        <a class="action-btn edit-btn"
                           href="adminRestaurant?action=edit&id=<%= r.getRestaurantId() %>">
                           Edit
                        </a>

                        <a class="action-btn delete-btn"
                           href="adminRestaurant?action=delete&id=<%= r.getRestaurantId() %>"
                           onclick="return confirm('Confirm delete?');">
                           Delete
                        </a>
                    </td>
                </tr>
            <% 
                }
            } else { 
            %>
                <tr>
                    <td colspan="9">No restaurants found.</td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>
