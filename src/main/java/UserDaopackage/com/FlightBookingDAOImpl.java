package UserDaopackage.com;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    // ================= FETCH FLIGHT BOOKINGS =================
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
                f.setBookingId(rs.getInt("booking_id"));   // ✅ IMPORTANT
                f.setFlightId(rs.getInt("flight_id"));
                f.setAirline(rs.getString("airline"));
                f.setSource(rs.getString("source"));
                f.setDestination(rs.getString("destination"));
                f.setPrice(rs.getDouble("price"));
                f.setStatus(rs.getString("status"));       // ✅ FIX

                list.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= CANCEL FLIGHT =================
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

	@Override
	public boolean bookFlight(int userId, int flightId, int seats) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean bookFlight(int userId, int flightId, int seats, Date travelDate) {
		// TODO Auto-generated method stub
		return false;
	}
}
