package UserDaopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightDAOImpl implements FlightDAO {

    private final Connection con;

    public FlightDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public List<Flight> searchFlights(String source, String destination) {

        List<Flight> list = new ArrayList<>();

        String sql = "SELECT * FROM flight "
                   + "WHERE TRIM(LOWER(source)) = ? "
                   + "AND TRIM(LOWER(destination)) = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, source.trim().toLowerCase());
            ps.setString(2, destination.trim().toLowerCase());

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowToFlight(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private Flight mapRowToFlight(ResultSet rs) throws SQLException {
        Flight f = new Flight();
        f.setFlightId(rs.getInt("flight_id"));
        f.setAirline(rs.getString("airline"));
        f.setSource(rs.getString("source"));
        f.setDestination(rs.getString("destination"));
        f.setDepartureTime(rs.getString("departure_time"));
        f.setArrivalTime(rs.getString("arrival_time"));
        f.setDuration(rs.getString("duration"));
        f.setPrice(rs.getDouble("price"));
        f.setSeatsAvailable(rs.getInt("seats_available"));
        return f;
    }

    @Override
    public Flight getFlightById(int id) { return null; }

    @Override
    public List<Flight> getAllFlights() { return null; }
}
