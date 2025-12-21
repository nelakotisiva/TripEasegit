package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.Bookingg;
import utilpackage.com.DBConnection;

public class HotelBookingDAOImpl implements HotelBookingDAO {

    private Connection con;

    public HotelBookingDAOImpl() {
        con = DBConnection.getConnector();
        if (con == null) {
            System.out.println("❌ DB connection failed in HotelBookingDAOImpl");
        } else {
            System.out.println("✅ DB connected");
        }
    }

    // =======================================================
    //               SAVE HOTEL BOOKING
    // =======================================================
    @Override
    public boolean saveBooking(int userId, int hotelId,
                               String checkin, String checkout,
                               int guests, double total) {

        String sql = "INSERT INTO hotel_booking " +
                     "(user_id, hotel_id, check_in, check_out, guests, total_amount) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, hotelId);
            ps.setString(3, checkin);
            ps.setString(4, checkout);
            ps.setInt(5, guests);
            ps.setDouble(6, total);

            int result = ps.executeUpdate();
            System.out.println("✔ Hotel booking inserted = " + result);

            // 🔥 ALSO INSERT INTO MAIN booking TABLE
            if (result > 0) {

                int destinationId = getDestinationIdByHotel(hotelId);

                BookingDAO bookingDAO = new BookingDAOImpl();
                bookingDAO.saveServiceBooking(
                        userId,
                        destinationId,
                        java.sql.Date.valueOf(checkin),
                        guests
                );

                return true;
            }

        } catch (Exception e) {
            System.out.println("❌ Error saving hotel booking");
            e.printStackTrace();
        }

        return false;
    }

    // =======================================================
    //          FETCH HOTEL BOOKINGS FOR USER
    // =======================================================
    @Override
    public List<Bookingg> getBookingsByUser(int userId) {

        List<Bookingg> list = new ArrayList<>();

        String sql =
            "SELECT hb.booking_id, hb.user_id, hb.hotel_id, hb.check_in, hb.check_out, " +
            "hb.guests, hb.total_amount, hb.booking_date, h.hotel_name, h.near_location " +
            "FROM hotel_booking hb " +
            "JOIN hotel h ON hb.hotel_id = h.hotel_id " +
            "WHERE hb.user_id = ? " +
            "ORDER BY hb.booking_date DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

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
                b.setHotelName(rs.getString("hotel_name"));
                b.setHotelLocation(rs.getString("near_location"));

                list.add(b);
            }

        } catch (Exception e) {
            System.out.println("❌ Error fetching hotel bookings");
            e.printStackTrace();
        }

        return list;
    }

    // =======================================================
    //          HELPER → HOTEL → DESTINATION
    // =======================================================
    private int getDestinationIdByHotel(int hotelId) {

        String sql = "SELECT destination_id FROM hotel WHERE hotel_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("destination_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}