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
    margin-bottom:20px;
}

.header h1{
    margin:0;
    font-size:26px;
    font-weight:600;
}

/* BUTTONS */
.btn{
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    color:white;
}

.btn-primary{ background:#8a9a5b; }
.btn-secondary{ background:#6b6256; }

.btn-primary:hover{ background:#7b8b50; }
.btn-secondary:hover{ background:#5c554b; }

/* ACTION BAR */
.action-bar{
    margin-bottom:18px;
}

/* TABLE */
.table-box{
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

/* IMAGE */
img.thumb{
    width:90px;
    height:65px;
    object-fit:cover;
    border-radius:8px;
    border:1px solid #d9d2c3;
}

/* ACTION BUTTONS */
.action-btn{
    padding:6px 12px;
    border-radius:8px;
    color:white;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
    margin:0 3px;
}

.edit-btn{ background:#8a9a5b; }
.delete-btn{ background:#b94a48; }

.action-btn:hover{
    opacity:0.9;
}
</style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <h1>Manage Restaurants</h1>
        <a href="AdminDashboard.jsp" class="btn btn-secondary">
            Back to Dashboard
        </a>
    </div>

    <!-- ACTION BAR -->
    <div class="action-bar">
        <a class="btn btn-primary" href="adminRestaurant?action=add">
            Add Restaurant
        </a>
    </div>

    <!-- TABLE -->
    <div class="table-box">
        <table>
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
                    <img class="thumb"
                         src="<%= r.getImageUrl() %>"
                         onerror="this.src='https://via.placeholder.com/90x65?text=No+Image'">
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

        </table>
    </div>

</div>

</body>
</html>
