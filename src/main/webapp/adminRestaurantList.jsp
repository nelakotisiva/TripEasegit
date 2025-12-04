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
<title>Manage Restaurants</title>
<style>
body{margin:0;font-family:Poppins;background:#e8f0ff;}
.sidebar{width:250px;height:100vh;position:fixed;background:#013bff;color:white;padding:30px;}
.sidebar a{padding:10px;display:block;color:white;text-decoration:none;margin-bottom:8px;border-radius:8px;}
.sidebar a:hover{background:#335dff;}
.main{margin-left:280px;padding:30px;}
h1{color:#0032d8;}
.add-btn{background:#013bff;color:white;padding:8px 14px;text-decoration:none;border-radius:6px;}
table{width:100%;border-collapse:collapse;background:white;}
th,td{border:1px solid #ccc;padding:10px;text-align:center;}
.action-btn{padding:6px 10px;border-radius:6px;color:white;text-decoration:none;font-size:13px;}
.edit-btn{background:#007bff;}
.delete-btn{background:#ff2e2e;}
</style>
</head>

<body>

<div class="sidebar">
    <h2>Admin</h2>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="ManageUsers">Manage Users</a>
    <a href="ManageBookings">Manage Bookings</a>
    <a href="ManageHotels">Manage Hotels</a>
    <a href="adminRestaurant?action=list">Manage Restaurants</a>
    <a href="ManageCabs">Manage Cabs</a>
    <a href="AdminLogoutServlet" style="background:red;">Logout</a>
</div>

<div class="main">
    <h1>Manage Restaurants</h1>
    <a class="add-btn" href="adminRestaurant?action=add">Add Restaurant</a>
    <br><br>

    <table>
        <tr>
            <th>ID</th>
            <th>Destination ID</th>
            <th>Name</th>
            <th>Type</th>
            <th>Rating</th>
            <th>Contact</th>
            <th>Avg Price</th>
            <th>Actions</th>
        </tr>

        <% if(list!=null){ for(Restaurant r : list){ %>
        <tr>
            <td><%=r.getRestaurantId()%></td>
            <td><%=r.getDestinationId()%></td>
            <td><%=r.getName()%></td>
            <td><%=r.getType()%></td>
            <td><%=r.getRating()%></td>
            <td><%=r.getContact()%></td>
            <td><%=r.getAvgPrice()%></td>

            <td>
                <a class="action-btn edit-btn"
                   href="adminRestaurant?action=edit&id=<%=r.getRestaurantId()%>">Edit</a>

                <a class="action-btn delete-btn"
                   href="adminRestaurant?action=delete&id=<%=r.getRestaurantId()%>"
                   onclick="return confirm('Confirm delete?');">Delete</a>
            </td>
        </tr>
        <% }} %>
    </table>
</div>
</body>
</html>
