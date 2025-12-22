package UserDaopackage.com;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    private static final String INSERT_BOOKING =
        "INSERT INTO flight_booking (user_id, flight_id, num_seats, travel_date) VALUES (?, ?, ?, ?)";

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

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        return bookFlight(userId, flightId, seats, new Date(System.currentTimeMillis()));
    }

    @Override
    public List<Flight> getMyFlightBookings(int userId) {
        List<Flight> list = new ArrayList<>();

        String sql =
            "SELECT f.* FROM flight_booking fb " +
            "JOIN flight f ON fb.flight_id = f.flight_id " +
            "WHERE fb.user_id = ? ORDER BY fb.booking_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Flight f = new Flight();
                f.setFlightId(rs.getInt("flight_id"));
                f.setAirline(rs.getString("airline"));   // 🔥 FIXED
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
                f.setAirline(rs.getString("airline"));   // 🔥 FIXED
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

        String sql = "DELETE FROM flight_booking WHERE booking_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
