package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Booking;
import dtopackage.com.BookingDTO;
import utilpackage.com.DBConnection;

public class BookingDAOImpl implements BookingDAO {

    /* ---------------- GET BOOKING BY ID ---------------- */
    @Override
    public Booking getBookingById(int bookingId) {

        Booking booking = null;
        String sql = "SELECT * FROM booking WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setDestinationId(rs.getInt("destination_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setTravelDate(rs.getDate("travel_date"));
                booking.setStatus(rs.getString("status"));
                booking.setNumOfPeople(rs.getInt("num_of_people"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }

    /* ---------------- SAVE SERVICE BOOKING ---------------- */
    @Override
    public boolean saveServiceBooking(int userId,
                                      int destinationId,
                                      Date travelDate,
                                      int numOfPeople) {

        String sql = "INSERT INTO booking " +
                     "(user_id, destination_id, booking_date, travel_date, status, num_of_people) " +
                     "VALUES (?, ?, CURDATE(), ?, 'Confirmed', ?)";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, destinationId);
            ps.setDate(3, travelDate);
            ps.setInt(4, numOfPeople);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ---------------- UPDATE BOOKING ---------------- */
    @Override
    public boolean updateBooking(int bookingId, String status, int numPeople) {

        String sql = "UPDATE booking SET status=?, num_of_people=? WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, numPeople);
            ps.setInt(3, bookingId);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ---------------- DELETE BOOKING ---------------- */
    @Override
    public boolean deleteBooking(int bookingId) {

        String sql = "DELETE FROM booking WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ---------------- SAVE HOLIDAY PACKAGE ---------------- */
    @Override
    public BookingDTO save(BookingDTO b) {
        // keep your existing logic if already implemented
        return b;
    }

    /* ---------------- USER BOOKINGS ---------------- */
    @Override
    public List<Booking> getBookingsByUserId(int userId) {

        List<Booking> list = new ArrayList<>();

        String sql = "SELECT * FROM booking WHERE user_id=? ORDER BY booking_date DESC";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setDestinationId(rs.getInt("destination_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setTravelDate(rs.getDate("travel_date"));
                booking.setStatus(rs.getString("status"));
                booking.setNumOfPeople(rs.getInt("num_of_people"));

                // ✅ THIS IS THE KEY LINE
                booking.setServiceType(rs.getString("service_type"));

                list.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list; // NEVER NULL
    }


    /* ---------------- ADMIN: ALL BOOKINGS ---------------- */
    @Override
    public List<Booking> getAllBookings() {

        List<Booking> list = new ArrayList<>();

        String sql = "SELECT * FROM booking ORDER BY travel_date DESC";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setDestinationId(rs.getInt("destination_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setTravelDate(rs.getDate("travel_date"));
                booking.setStatus(rs.getString("status"));
                booking.setNumOfPeople(rs.getInt("num_of_people"));

                list.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void saveServiceBooking(int userId,
                                   int destinationId,
                                   Timestamp bookingDate1,
                                   int numPeople) {

        String sql =
            "INSERT INTO booking " +
            "(user_id, destination_id, booking_date, status, num_of_people, service_type) " +
            "VALUES (?, ?, ?, 'Confirmed', ?, 'RESTAURANT')";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, destinationId);

            // 🔥 Preserve exact timestamp (no timezone conversion)
            ps.setObject(3, bookingDate1);

            ps.setInt(4, numPeople);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}