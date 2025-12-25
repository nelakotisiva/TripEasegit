package Daopackage.com;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import dtopackage.com.Booking;
import dtopackage.com.BookingDTO;

public interface BookingDAO {

    // Save booking for holiday packages
    BookingDTO save(BookingDTO booking);

    // Fetch bookings for a specific user
    List<Booking> getBookingsByUserId(int userId);

    // Admin: fetch all bookings
    List<Booking> getAllBookings();

    Booking getBookingById(int bookingId);

    boolean updateBooking(int bookingId, String status, int numPeople);

    boolean deleteBooking(int bookingId);

    // âœ… ONE service booking method ONLY
    boolean saveServiceBooking(int userId,
                               int destinationId,
                               Date travelDate,
                               int numOfPeople);

}