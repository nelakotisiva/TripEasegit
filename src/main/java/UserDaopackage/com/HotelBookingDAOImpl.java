package UserDaopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Bookingg;
import utilpackage.com.DBConnection;

public class HotelBookingDAOImpl implements HotelBookingDAO {

    // ================= FETCH HOTEL BOOKINGS =================
    @Override
    public List<Bookingg> getBookingsByUser(int userId) {

        List<Bookingg> list = new ArrayList<>();

        String sql =
            "SELECT hb.booking_id, hb.user_id, hb.hotel_id, hb.check_in, hb.check_out, " +
            "hb.guests, hb.total_amount, hb.booking_date, hb.status, " +
            "h.hotel_name, h.near_location " +
            "FROM hotel_booking hb " +
            "JOIN hotel h ON hb.hotel_id = h.hotel_id " +
            "WHERE hb.user_id = ? " +
            "ORDER BY hb.booking_date DESC";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookingg b = new Bookingg();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setHotelId(rs.getInt("hotel_id"));
                b.setCheckin(rs.getString("check_in"));
                b.setCheckout(rs.getString("check_out"));
                b.setGuests(rs.getInt("guests"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setHotelName(rs.getString("hotel_name"));
                b.setHotelLocation(rs.getString("near_location"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= SAVE HOTEL BOOKING =================
    @Override
    public boolean saveBooking(int userId, int hotelId, String checkin,
                               String checkout, int guests, double total) {

        String sql =
            "INSERT INTO hotel_booking " +
            "(user_id, hotel_id, check_in, check_out, guests, total_amount, booking_date, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, NOW(), 'Confirmed')";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, hotelId);
            ps.setString(3, checkin);
            ps.setString(4, checkout);
            ps.setInt(5, guests);
            ps.setDouble(6, total);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= CANCEL HOTEL =================
    @Override
    public void cancelBooking(int bookingId) {

        String sql = "UPDATE hotel_booking SET status='Cancelled' WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
