package UserDaopackage.com;

import java.sql.Date;
import java.util.List;

import dtopackage.com.Flight;

public interface FlightBookingDAO {

    boolean bookFlight(int userId, int flightId, int seats, Date travelDate);

    List<Flight> getMyFlightBookings(int userId);

    Flight getFlightById(int flightId);   // ✅ NEW METHOD

    boolean bookFlight(int userId, int flightId, int seats);
}
