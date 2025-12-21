package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    /* ================= BOOK FLIGHT WITH DATE ================= */
    @Override
    public boolean bookFlight(int userId, int flightId, int seats, Date travelDate) {

        Connection con = null;

        try {
            con = DBConnection.getConnector();
            con.setAutoCommit(false);

            // 1️⃣ Check available seats
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT seats_available FROM flight WHERE flight_id=? FOR UPDATE"
            );
            ps1.setInt(1, flightId);

            ResultSet rs = ps1.executeQuery();
            if (!rs.next()) {
                con.rollback();
                return false;
            }

            int availableSeats = rs.getInt("seats_available");
            if (availableSeats < seats) {
                con.rollback();
                return false;
            }

            // 2️⃣ Insert booking
            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO flight_booking (user_id, flight_id, num_seats, travel_date, status) " +
                "VALUES (?, ?, ?, ?, 'CONFIRMED')"
            );
            ps2.setInt(1, userId);
            ps2.setInt(2, flightId);
            ps2.setInt(3, seats);
            ps2.setDate(4, travelDate);
            ps2.executeUpdate();

            // 3️⃣ Update seat count
            PreparedStatement ps3 = con.prepareStatement(
                "UPDATE flight SET seats_available = seats_available - ? WHERE flight_id=?"
            );
            ps3.setInt(1, seats);
            ps3.setInt(2, flightId);
            ps3.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
        return false;
    }

    /* ================= OVERLOADED BOOK FLIGHT ================= */
    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        return bookFlight(
            userId,
            flightId,
            seats,
            new Date(System.currentTimeMillis())
        );
    }

    /* ================= GET FLIGHT BY ID ================= */
    @Override
    public Flight getFlightById(int flightId) {

        Flight f = null;

        String sql = "SELECT airline, source, destination, price FROM flight WHERE flight_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flightId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                f = new Flight();
                f.setFlightId(flightId);
                f.setAirline(rs.getString("airline"));
                f.setSource(rs.getString("source"));
                f.setDestination(rs.getString("destination"));
                f.setPrice(rs.getDouble("price"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    /* ================= GET USER BOOKINGS ================= */
    @Override
    public List<Flight> getMyFlightBookings(int userId) {

        List<Flight> list = new ArrayList<>();

        String sql =
            "SELECT fb.booking_id, fb.status, f.flight_id, f.airline, " +
            "f.source, f.destination, f.price " +
            "FROM flight_booking fb " +
            "JOIN flight f ON fb.flight_id = f.flight_id " +
            "WHERE fb.user_id = ?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Flight f = new Flight();
                f.setBookingId(rs.getInt("booking_id"));
                f.setFlightId(rs.getInt("flight_id"));
                f.setAirline(rs.getString("airline"));
                f.setSource(rs.getString("source"));
                f.setDestination(rs.getString("destination"));
                f.setPrice(rs.getDouble("price"));
                f.setStatus(rs.getString("status"));
                list.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ================= CANCEL BOOKING ================= */
    public void cancelBooking(int bookingId) {

        String sql = "UPDATE flight_booking SET status='CANCELLED' WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
