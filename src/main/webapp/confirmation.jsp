<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dtopackage.com.BookingDTO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
<%
    BookingDTO b = (BookingDTO) request.getAttribute("booking");

    if (b == null) {
%>
        <h2>Booking Failed</h2>
        <a href="tourpackage.jsp">Go Back</a>
<%
    } else {
%>
        <h1>Booking Confirmed</h1>

        <p><strong>Booking ID:</strong> <%= b.getId() %></p>
        <p><strong>From:</strong> <%= b.getFromLocation() %></p>
        <p><strong>To:</strong> <%= b.getToLocation() %></p>
        <p><strong>Travellers:</strong> <%= b.getTravellers() %></p>
        <p><strong>Travel Date:</strong>
            <%= b.getTravelDate() == null ? "-" : b.getTravelDate() %>
        </p>

        <a href="tourpackage.jsp" class="btn">Book another package</a>
         <a href="Dashboard.jsp" class="btn">Dashboard</a>
<%
    }
%>
</div>

</body>
</html>