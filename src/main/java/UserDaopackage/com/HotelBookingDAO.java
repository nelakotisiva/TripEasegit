package UserDaopackage.com;

public interface HotelBookingDAO {
    boolean saveBooking(int userId, int hotelId, String checkin, String checkout, int guests, double total);
}
