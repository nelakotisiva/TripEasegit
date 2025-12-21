package UserDaopackage.com;

import java.sql.Date;
import java.util.List;

import dtopackage.com.Flight;

public interface FlightBookingDAO {

    // Book flight with travel date
    boolean bookFlight(int userId, int flightId, int seats, Date travelDate);

    // Optional overloaded method (without travel date)
    boolean bookFlight(int userId, int flightId, int seats);

    // Get all bookings of a user
    List<Flight> getMyFlightBookings(int userId);

    // Get flight details by ID
    Flight getFlightById(int flightId);
}
