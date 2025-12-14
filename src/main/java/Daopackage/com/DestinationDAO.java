package Daopackage.com;

import java.util.List;
import dtopackage.com.Destination;

public interface DestinationDAO {

    List<Destination> getAllDestinations();

    List<Destination> searchDestinations(String keyword);
}
