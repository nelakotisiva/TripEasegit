package UserDaopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Flight;
import utilpackage.com.DBConnection;

public class FlightDAOImpl implements FlightDAO {

    Connection con;

    public FlightDAOImpl() {
        con = DBConnection.getConnector();
        try {
            if (con != null) System.out.println("DEBUG: FlightDAOImpl connected to DB: " + con.getCatalog());
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<Flight> searchFlights(String source, String destination) {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM flight WHERE LOWER(source)=? AND LOWER(destination)=?";
        try {
            System.out.println("DEBUG: SQL = " + sql + " params = " + source.toLowerCase() + ", " + destination.toLowerCase());
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, source.toLowerCase());
            ps.setString(2, destination.toLowerCase());

            ResultSet rs = ps.executeQuery();
            int rows = 0;
            while (rs.next()) {
                rows++;
                Flight f = mapRowToFlight(rs);
                list.add(f);
            }
            System.out.println("DEBUG: rows returned by searchFlights = " + rows);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Flight getFlightById(int id) {
        Flight f = null;
        String sql = "SELECT * FROM flight WHERE flight_id=?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                f = mapRowToFlight(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // New helper to get all flights (used when no params supplied)
    public List<Flight> getAllFlights() {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM flight";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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

    // maps ResultSet row -> Flight object
    private Flight mapRowToFlight(ResultSet rs) throws SQLException {
        Flight f = new Flight();
        f.setFlightId(rs.getInt("flight_id"));
        // use column name exactly as DB (your DB now has "airline" lowercase)
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
