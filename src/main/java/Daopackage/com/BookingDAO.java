package Daopackage.com;

import java.util.List;
import dtopackage.com.Booking;
import dtopackage.com.BookingDTO;

public interface BookingDAO {

    // Save booking for Holiday Packages (BookingDTO)
    BookingDTO save(BookingDTO booking);

    // Fetch bookings for a user (Trip bookings)
    List<Booking> getBookingsByUserId(int userId);
}
