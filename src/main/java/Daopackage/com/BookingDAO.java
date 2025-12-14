package Daopackage.com;

import java.sql.Date;
import java.util.List;
import dtopackage.com.Booking;
import dtopackage.com.BookingDTO;

public interface BookingDAO {

    // Save booking for Holiday Packages (BookingDTO)
    BookingDTO save(BookingDTO booking);

    // Fetch bookings for a user (Trip bookings)
    List<Booking> getBookingsByUserId(int userId);

    // 🔹 NEW: Fetch all bookings (for Admin Manage Bookings)
    List<Booking> getAllBookings();
    Booking getBookingById(int bookingId);
    boolean updateBooking(int bookingId, String status, int numPeople);
    boolean deleteBooking(int bookingId);

 // 🔹 NEW: Save simple service booking (Hotel / Cab / Restaurant / Place)
    boolean saveServiceBooking(int userId,
                               int destinationId,
                               Date travelDate,
                               int numOfPeople);

}
