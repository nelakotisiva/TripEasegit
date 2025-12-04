package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;

import utilpackage.com.DBConnection;

public class HotelBookingDAOImpl implements HotelBookingDAO {

    Connection con = DBConnection.getConnector();

    @Override
    public boolean saveBooking(int userId, int hotelId, String checkin, String checkout, int guests, double total) {

        String sql = "INSERT INTO hotel_booking (user_id, hotel_id, check_in, check_out, guests, total_amount) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try {

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, hotelId);
            ps.setString(3, checkin);
            ps.setString(4, checkout);
            ps.setInt(5, guests);
            ps.setDouble(6, total);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("BOOKING ERROR:");
            e.printStackTrace();
        }

        return false;
    }
}
