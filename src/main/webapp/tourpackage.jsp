<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tour Search</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h1>Find Your Perfect Tour Package</h1>
    <p>Select your travel details below</p>

    <form action="Search" method="get" class="form-box">

        <label>From:</label>
        <select name="from" required>
            <option value="">-- Select Starting Place --</option>
            <option>Bengaluru</option>
            <option>Hyderabad</option>
            <option>Mumbai</option>
            <option>Delhi</option>
            <option>Chennai</option>
            <option>Pune</option>
            <option>Kolkata</option>
            <option>Jaipur</option>
            <option>Ahmedabad</option>
            <option>Visakhapatnam</option>
            <option>Goa</option>
            <option>Mysore</option>
            <option>Ooty</option>
            <option>Kodaikanal</option>
            <option>Kerala</option>
            <option>Manali</option>
            <option>Shimla</option>
            <option>Agra</option>
        </select>

        <label>To (Destination):</label>
        <select name="to" required>
            <option value="">-- Select Destination --</option>
            <option>Goa</option>
            <option>Mysore</option>
            <option>Bengaluru</option>
            <option>Ooty</option>
            <option>Kodaikanal</option>
            <option>Kerala</option>
            <option>Manali</option>
            <option>Shimla</option>
            <option>Delhi</option>
            <option>Agra</option>
            <option>Chennai</option>
            <option>Pune</option>
            <option>Jaipur</option>
            <option>Mumbai</option>
            <option>Hyderabad</option>
            <option>Kolkata</option>
        </select>

        <button type="submit" class="btn">Search Packages</button>
    </form>
</div>

</body>
</html>
    