<%@ page language="java" contentType="text/html; charset=UTF-8"
				    pageEncoding="UTF-8"%>
				<%@ page import="dtopackage.com.PackageDTO" %>
				<!DOCTYPE html>
				<html>
				<head>
				    <meta charset="UTF-8">
				    <title>Package Details</title>
				    <link rel="stylesheet" href="css/style.css">
				</head>
				<body>

				<div class="container">
				<%
				    PackageDTO p = (PackageDTO) request.getAttribute("package");
				    if (p == null) {
				%>
				    <p>Package not found. <a href="tourpackage.jsp">Back to Home</a></p>
				<%
				    } else {
				%>

				    <h1><%= p.getTitle() %></h1>
				    <p><strong>Destination:</strong> <%= p.getDestination() %></p>
				    <p><strong>Days:</strong> <%= p.getDays() %></p>
				    <p><strong>Price:</strong> ₹<%= String.format("%.2f", p.getPrice()) %></p>
				    <p><%= p.getDescription() %></p>
				    <p><em><%= p.getDetails() %></em></p>

				    <hr>
				    <h2>Book This Package</h2>

				    <form action="book" method="post" class="form-box">

				        <input type="hidden" name="packageId" value="<%= p.getId() %>">

				        <label>Your Name</label>
				        <input type="text" name="customerName" required>

				        <label>Email</label>
				        <input type="email" name="email">

				        <label>Phone</label>
				        <input type="text" name="phone">

				        <label>From</label>
				        <input type="text" name="from" required>

				        <label>To</label>
				        <input type="text" name="to" value="<%= p.getDestination() %>" readonly>

				        <label>Travellers</label>
				        <input type="number" name="travellers" value="1" min="1">

				        <label>Travel Date</label>
				        <input type="date" name="travelDate" required>

				        <label>Return Date</label>
				        <input type="date" name="returnDate">

				        <button type="submit" class="btn">Confirm Booking</button>
				    </form>

				    <a href="packages?to=<%= p.getDestination() %>" class="small-link">Back to packages</a>

				<%
				    }
				%>
				</div>
				<script>
    // Get today's date in YYYY-MM-DD format
    const today = new Date().toISOString().split("T")[0];

    // Set minimum date for travel and return dates
    document.querySelector('input[name="travelDate"]').setAttribute("min", today);
    document.querySelector('input[name="returnDate"]').setAttribute("min", today);
</script>
				

				</body>
				</html>