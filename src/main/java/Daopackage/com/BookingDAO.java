package Daopackage.com;

import java.util.List;
import dtopackage.com.Booking;

public interface BookingDAO {
    // Fetch all bookings of a specific user
    List<Booking> getBookingsByUserId(int userId);
}
