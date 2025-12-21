package UserDaopackage.com;

import java.sql.Date;
import java.util.List;

import dtopackage.com.Flight;
import dtopackage.com.FlightBooking;

public interface FlightBookingDAO {

	boolean bookFlight(int userId, int flightId, int seats, Date travelDate);

	List<Flight> getMyFlightBookings(int userId);

	boolean bookFlight(int userId, int flightId, int seats);

	
    

}
