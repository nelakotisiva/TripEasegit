<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dtopackage.com.Flight" %>

<!DOCTYPE html>
<html>
<head>
    <title>Flight Finder</title>

<style>
    body { 
        background: #eef4ff; 
        font-family: Arial; 
        margin: 0;
        padding: 0;
    }

    .page-container {
        max-width: 950px;   /* Fits laptop screens */
        margin: 0 auto;
        padding: 10px;
    }

    .header { 
        background:#0d6efd; 
        color:white; 
        padding:15px; 
        font-size:26px; 
        text-align:center; 
    }

    .search-box { 
        width:100%; 
        text-align:center;
        margin:20px 0;
    }

    input { 
        padding:10px; 
        margin:5px; 
        width:200px; 
        border:2px solid #0d6efd; 
        border-radius:8px; 
    }

    button { 
        padding:10px 20px; 
        background:#0d6efd; 
        color:white; 
        border:none; 
        border-radius:8px; 
        cursor:pointer; 
    }

    button:hover { 
        background:#004ab9; 
    }

    .table-wrapper {
        width: 100%;
        overflow-x: auto;  /* Prevents overflow */
        margin-top: 20px;
    }

    table { 
        width:100%; 
        min-width: 800px; /* Prevents stretching */
        border-collapse:collapse; 
        background: white;
        border-radius: 10px;
        overflow: hidden;
    }

    th { 
        background:#0d6efd; 
        color:white; 
        padding:12px; 
        position: sticky;
        top: 0;
    }

    td { 
        padding:12px; 
        text-align:center; 
        border-bottom:1px solid #ccc; 
    }

    tbody tr:hover {
        background: #f0f7ff;
    }

    .msg {
        text-align:center; 
        margin-top:10px; 
        color:green; 
        font-weight:bold;
    }

    .error {
        text-align:center; 
        color:red; 
        margin-top:20px;
        font-weight:bold;
    }
</style>

</head>
<body>

<div class="header">✈️ Flight Finder</div>

<div class="page-container">

    <div class="search-box">
        <form action="SearchFlight" method="get">
            <input type="text" name="source" placeholder="From (City)" value="<%= request.getAttribute("source") == null ? "" : request.getAttribute("source") %>">
            <input type="text" name="destination" placeholder="To (City)" value="<%= request.getAttribute("destination") == null ? "" : request.getAttribute("destination") %>">
            <button type="submit">Search Flights</button>
        </form>
    </div>

    <% 
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
        <div class="msg"><%= msg %></div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <%
        List<Flight> flights = (List<Flight>) request.getAttribute("flights");
        String src = (String) request.getAttribute("source");
        String dest = (String) request.getAttribute("destination");

        boolean userSearched = (src != null && !src.trim().isEmpty() &&
                                dest != null && !dest.trim().isEmpty());
    %>

    <% if (flights != null && !flights.isEmpty()) { %>

    <div class="table-wrapper">
    <table>
        <tr>
            <th>Airline</th>
            <th>From</th>
            <th>To</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Duration</th>
            <th>Seats</th>
            <th>Price</th>
            <th>Action</th>
        </tr>

        <% for (Flight f : flights) { %>
        <tr>
            <td><%= f.getAirline() %></td>
            <td><%= f.getSource() %></td>
            <td><%= f.getDestination() %></td>
            <td><%= f.getDepartureTime() %></td>
            <td><%= f.getArrivalTime() %></td>
            <td><%= f.getDuration() %></td>
            <td><%= f.getSeatsAvailable() %></td>
            <td>₹<%= f.getPrice() %></td>

            <td>
                <% if (f.getSeatsAvailable() > 0) { %>
                    <form action="BookFlight" method="post" style="display:inline;">
                        <input type="hidden" name="flightId" value="<%= f.getFlightId() %>">
                        <input type="number" name="seats" value="1" min="1" max="<%= f.getSeatsAvailable() %>" style="width:60px;">
                        <button type="submit">Book</button>
                    </form>
                <% } else { %>
                    <span style="color:red;">Not Available</span>
                <% } %>
            </td>
        </tr>
        <% } %>

    </table>
    </div>

    <% } else if (userSearched) { %>
        <div class="error">No flights found.</div>
    <% } %>

</div>

</body>
</html>
