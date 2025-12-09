package UserDaopackage.com;

import java.sql.Date;

public interface FlightBookingDAO {
    boolean bookFlight(int userId, int flightId, int seats);

	boolean bookFlight(int userId, int flightId, int seats, Date travelDate);
}
