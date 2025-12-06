package UserDaopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightDAOImpl implements FlightDAO {

    private final Connection con;

    public FlightDAOImpl() {
        con = DBConnection.getConnector();
        try {
            if (con != null) System.out.println("DEBUG: FlightDAOImpl connected to DB");
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<Flight> searchFlights(String source, String destination) {
        List<Flight> list = new ArrayList<>();
        // use TRIM + LOWER on DB side to avoid mismatch due to spaces/case
        String sql = "SELECT * FROM flight WHERE TRIM(LOWER(source)) = ? AND TRIM(LOWER(destination)) = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            String s = (source == null) ? "" : source.trim().toLowerCase();
            String d = (destination == null) ? "" : destination.trim().toLowerCase();

            System.out.println("DEBUG: SQL = " + sql + " params = " + s + ", " + d);

            ps.setString(1, s);
            ps.setString(2, d);

            try (ResultSet rs = ps.executeQuery()) {
                int rows = 0;
                while (rs.next()) {
                    rows++;
                    Flight f = mapRowToFlight(rs);
                    list.add(f);
                }
                System.out.println("DEBUG: rows returned by searchFlights = " + rows);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Flight getFlightById(int id) {
        Flight f = null;
        String sql = "SELECT * FROM flight WHERE flight_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) f = mapRowToFlight(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Flight> getAllFlights() {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM flight";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            int rows = 0;
            while (rs.next()) {
                rows++;
                list.add(mapRowToFlight(rs));
            }
            System.out.println("DEBUG: rows returned by getAllFlights = " + rows);
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
}
