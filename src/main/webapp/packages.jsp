<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,dtopackage.com.PackageDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Packages</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h1>Packages for <%= request.getAttribute("destination") %></h1>

    <%
        List<PackageDTO> list = (List<PackageDTO>) request.getAttribute("packages");
        if (list == null || list.isEmpty()) {
    %>
        <p>No packages found for this destination.</p>
    <%
        } else {
            for (PackageDTO p : list) {
    %>
    <div class="package-card">
        <h3><%= p.getTitle() %> – ₹<%= String.format("%.2f", p.getPrice()) %></h3>
        <p><%= p.getDescription() %></p>
        <p><strong>Days:</strong> <%= p.getDays() %></p>

        <form action="book" method="get" style="margin-top:8px;">
            <input type="hidden" name="packageId" value="<%= p.getId() %>">
            <button type="submit" class="btn-small">View / Book</button>
        </form>
    </div>
    <%
            }
        }
    %>

    <a href="tourpackage.jsp" class="small-link">Search again</a>
</div>

</body>
</html>
    