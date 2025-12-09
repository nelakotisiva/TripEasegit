<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dtopackage.com.Destination" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Famous Places - TripEase</title>

    <!-- Bootstrap 5 CDN -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/UserDashboard.jsp">
            TripEase
        </a>
        <span class="navbar-text text-white">
            Explore Famous Places
        </span>
    </div>
</nav>

<div class="container">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Famous Places</h2>
    </div>

    <!-- 🔍 Search Bar -->
    <form class="row g-2 mb-4" method="get" action="<%= request.getContextPath() %>/PlacesServlet">
        <div class="col-sm-6 col-md-4">
            <input type="text"
                   name="q"
                   class="form-control"
                   placeholder="Search by name or location"
                   value="<%= request.getAttribute("q") != null ? request.getAttribute("q") : "" %>">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
        <div class="col-auto">
            <a href="<%= request.getContextPath() %>/PlacesServlet" class="btn btn-outline-secondary">
                Clear
            </a>
        </div>
    </form>

    <%
        List<Destination> list = (List<Destination>) request.getAttribute("placesList");
        if (list != null && !list.isEmpty()) {
    %>

    <!-- 🧩 Destination Cards -->
    <div class="row">
        <%
            for (Destination d : list) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() + "/" + d.getImage_url() %>"
                     class="card-img-top"
                     alt="<%= d.getName() %>">

                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">
                        <%= d.getName() %>
                        <small class="text-muted"> • <%= d.getLocation() %></small>
                    </h5>

                    <p class="card-text flex-grow-1">
                        <%= d.getDescription() %>
                    </p>

                    <div class="mt-2 fw-semibold text-primary">
                        Price: ₹<%= d.getPrice() %>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>

    <%
        } else {
    %>
        <div class="alert alert-info">
            No places available for this search.
        </div>
    <%
        }
    %>
</div>

<!-- Bootstrap JS (optional but good for future components) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
