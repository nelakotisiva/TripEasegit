<%@ page import="dtopackage.com.Booking" %>

<%
    Booking booking = (Booking) request.getAttribute("booking");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Booking</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: Poppins, sans-serif;
    background: #e8f0ff;
}

.container {
    width: 450px;
    margin: 60px auto;
    background: #fff;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #0032d8;
}

label {
    font-weight: 600;
}

input, select {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 18px;
}

button {
    width: 100%;
    padding: 12px;
    border: none;
    background: #0066ff;
    color: #fff;
    border-radius: 10px;
    font-size: 15px;
    cursor: pointer;
}

button:hover {
    opacity: 0.9;
}
</style>

</head>
<body>

<div class="container">
    <h2>Edit Booking</h2>

    <form action="EditBooking" method="post">

        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

        <label>Status</label>
        <select name="status">
            <option <%= booking.getStatus().equals("PENDING") ? "selected" : "" %>>PENDING</option>
            <option <%= booking.getStatus().equals("CONFIRMED") ? "selected" : "" %>>CONFIRMED</option>
            <option <%= booking.getStatus().equals("CANCELLED") ? "selected" : "" %>>CANCELLED</option>
        </select>

        <label>No. of People</label>
        <input type="number" name="numPeople" value="<%= booking.getNumOfPeople() %>" required>

        <button type="submit">Update Booking</button>

    </form>
</div>

</body>
</html>
