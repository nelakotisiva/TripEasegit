package UserDaopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    // ================= FETCH FLIGHT BOOKINGS =================
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

    // ================= BOOK FLIGHT (WITHOUT DATE) =================
    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {

        String sql =
            "INSERT INTO flight_booking " +
            "(user_id, flight_id, seats, booking_date, status) " +
            "VALUES (?, ?, ?, NOW(), 'Active')";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, flightId);
            ps.setInt(3, seats);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= BOOK FLIGHT (WITH TRAVEL DATE) =================
    @Override
    public boolean bookFlight(int userId, int flightId, int seats, java.sql.Date travelDate) {

        String sql =
            "INSERT INTO flight_booking " +
            "(user_id, flight_id, seats, travel_date, booking_date, status) " +
            "VALUES (?, ?, ?, ?, NOW(), 'Active')";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, flightId);
            ps.setInt(3, seats);
            ps.setDate(4, travelDate);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= CANCEL FLIGHT =================
    @Override
    public void cancelBooking(int bookingId) {

        String sql = "UPDATE flight_booking SET status='Cancelled' WHERE booking_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
