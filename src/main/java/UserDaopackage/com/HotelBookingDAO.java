package UserDaopackage.com;

import java.util.List;
import dtopackage.com.Bookingg;

public interface HotelBookingDAO {

    boolean saveBooking(int userId, int hotelId,
                        String checkin, String checkout,
                        int guests, double total);

    List<Bookingg> getBookingsByUser(int userId);
}