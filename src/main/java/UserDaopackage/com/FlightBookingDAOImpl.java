package UserDaopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    private static final String INSERT_BOOKING =
        "INSERT INTO flight_booking (user_id, flight_id, num_seats, travel_date) " +
        "VALUES (?, ?, ?, ?)";

    @Override
    public boolean bookFlight(int userId, int flightId, int seats, Date travelDate) {

        boolean result = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_BOOKING)) {

            ps.setInt(1, userId);
            ps.setInt(2, flightId);
            ps.setInt(3, seats);
            ps.setDate(4, travelDate);

            result = ps.executeUpdate() > 0;

            // 🔥 INSERT INTO MAIN BOOKING TABLE
            if (result) {
                saveMainBooking(userId, flightId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    private void saveMainBooking(int userId, int flightId) {

        String sql =
            "INSERT INTO booking " +
            "(user_id, destination_id, booking_date, status, service_type) " +
            "VALUES (?, ?, CURDATE(), 'Confirmed', 'FLIGHT')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, flightId); // using flightId as reference
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        return bookFlight(userId, flightId, seats, new Date(System.currentTimeMillis()));
    }

    @Override
    public List<Flight> getMyFlightBookings(int userId) {

        List<Flight> list = new ArrayList<>();

        String sql =
            "SELECT fb.booking_id, fb.status, fb.travel_date, f.* " +
            "FROM flight_booking fb " +
            "JOIN flight f ON fb.flight_id = f.flight_id " +
            "WHERE fb.user_id=? ORDER BY fb.booking_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Flight f = new Flight();
                f.setBookingId(rs.getInt("booking_id"));
                f.setStatus(rs.getString("status"));
                f.setBookingDate(rs.getDate("travel_date"));
                f.setFlightId(rs.getInt("flight_id"));
                f.setAirline(rs.getString("airline"));
                f.setSource(rs.getString("source"));
                f.setDestination(rs.getString("destination"));
                f.setPrice(rs.getDouble("price"));
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Flight getFlightById(int flightId) {

        Flight f = null;

        String sql = "SELECT * FROM flight WHERE flight_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flightId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                f = new Flight();
                f.setFlightId(rs.getInt("flight_id"));
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

    public void cancelBooking(int bookingId) {

        String sql1 =
            "UPDATE flight_booking SET status='Cancelled' WHERE booking_id=?";

        String sql2 =
            "UPDATE booking SET status='Cancelled' " +
            "WHERE booking_id=? AND service_type='FLIGHT'";

        try (Connection con = DBConnection.getConnection()) {

            try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
                ps1.setInt(1, bookingId);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                ps2.setInt(1, bookingId);
                ps2.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
