package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.RestaurantBooking;
import utilpackage.com.DBConnection;

public class RestaurantBookingDAOImpl implements RestaurantBookingDAO {

    @Override
    public boolean bookRestaurant(RestaurantBooking rb) {

        String sql =
            "INSERT INTO restaurant_booking " +
            "(user_id, restaurant_id, booking_date, num_people, status) " +
            "VALUES (?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, rb.getUserId());
            ps.setInt(2, rb.getRestaurantId());
            ps.setDate(3, new java.sql.Date(rb.getBookingDate1().getTime()));
            ps.setInt(4, rb.getNumPeople());
            ps.setString(5, rb.getStatus());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean bookRestaurantAndMainBooking(RestaurantBooking rb) {

        boolean ok = bookRestaurant(rb);
        if (!ok) return false;

        int destinationId = getDestinationIdByRestaurant(rb.getRestaurantId());

        saveServiceBooking(
                rb.getUserId(),
                destinationId,
                rb.getBookingDate1(),
                rb.getNumPeople()
        );
        return true;
    }

    private int getDestinationIdByRestaurant(int restaurantId) {

        String sql =
            "SELECT destination_id FROM restaurant WHERE restaurant_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<RestaurantBooking> getBookingsByUserId(int userId) {

        List<RestaurantBooking> list = new ArrayList<>();

        String sql =
            "SELECT * FROM restaurant_booking " +
            "WHERE user_id=? ORDER BY booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                RestaurantBooking rb = new RestaurantBooking();
                rb.setBookingId(rs.getInt("booking_id"));
                rb.setUserId(rs.getInt("user_id"));
                rb.setRestaurantId(rs.getInt("restaurant_id"));
                rb.setBookingDate1(rs.getTimestamp("booking_date"));
                rb.setNumPeople(rs.getInt("num_people"));
                rb.setStatus(rs.getString("status"));
                list.add(rb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean cancelBooking(int bookingId) {

        String sql1 =
            "UPDATE restaurant_booking SET status='Cancelled' WHERE booking_id=?";

        String sql2 =
            "UPDATE booking SET status='Cancelled' " +
            "WHERE booking_id=? AND service_type='RESTAURANT'";

        try (Connection con = DBConnection.getConnection()) {

            try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
                ps1.setInt(1, bookingId);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                ps2.setInt(1, bookingId);
                ps2.executeUpdate();
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔥 MAIN FIX IS HERE
    @Override
    public void saveServiceBooking(int userId,
                                   int destinationId,
                                   Timestamp bookingDate1,
                                   int numPeople) {

        String sql =
            "INSERT INTO booking " +
            "(user_id, destination_id, booking_date, status, num_of_people, service_type) " +
            "VALUES (?, ?, ?, 'Confirmed', ?, 'RESTAURANT')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, destinationId);
            ps.setDate(3, new java.sql.Date(bookingDate1.getTime()));
            ps.setInt(4, numPeople);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
