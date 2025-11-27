package UserDaopackage.com;

import java.util.List;
import dtopackage.com.Flight;

public interface FlightDAO {
    List<Flight> searchFlights(String source, String destination);
    Flight getFlightById(int id);
    List<Flight> getAllFlights();
}
