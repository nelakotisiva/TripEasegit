package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.RestaurantBooking;
import utilpackage.com.DBConnection;

public class RestaurantBookingDAOImpl implements RestaurantBookingDAO {

    // ------------------------------------------------
    // INSERT INTO restaurant_booking
    // ------------------------------------------------
    @Override
    public boolean bookRestaurant(RestaurantBooking rb) {

        String sql = "INSERT INTO restaurant_booking " +
                     "(user_id, restaurant_id, booking_date, num_people, status) " +
                     "VALUES (?,?,?,?,?)";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, rb.getUserId());
            ps.setInt(2, rb.getRestaurantId());

            // 🔥 EXACT TIME (NO TIMEZONE CONVERSION)
            ps.setObject(3, rb.getBookingDate1());

            ps.setInt(4, rb.getNumPeople());
            ps.setString(5, rb.getStatus());

            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ------------------------------------------------
    // INSERT INTO restaurant_booking + booking
    // ------------------------------------------------
    @Override
    public boolean bookRestaurantAndMainBooking(RestaurantBooking rb) {

        try {
            // 1️⃣ Insert into restaurant_booking
            boolean ok = bookRestaurant(rb);
            if (!ok) return false;

            // 2️⃣ Get destination_id
            int destinationId = getDestinationIdByRestaurant(rb.getRestaurantId());

            // 3️⃣ Insert into MAIN booking table
            BookingDAO bookingDAO = new BookingDAOImpl();
            bookingDAO.saveServiceBooking(
                    rb.getUserId(),
                    destinationId,
                    rb.getBookingDate1(),   // 🔥 Timestamp preserved
                    rb.getNumPeople()
            );

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ------------------------------------------------
    // HELPER METHOD
    // ------------------------------------------------
    private int getDestinationIdByRestaurant(int restaurantId) {

        String sql = "SELECT destination_id FROM restaurant WHERE restaurant_id = ?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
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
