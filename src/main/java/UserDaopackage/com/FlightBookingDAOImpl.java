package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    Connection con;

    public FlightBookingDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        try {
            con.setAutoCommit(false);

            // lock row to avoid race condition
            PreparedStatement ps1 = con.prepareStatement("SELECT seats_available FROM flight WHERE flight_id=? FOR UPDATE");
            ps1.setInt(1, flightId);
            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) { con.rollback(); return false; }
            int available = rs.getInt(1);
            if (available < seats) { con.rollback(); return false; }

            PreparedStatement ps2 = con.prepareStatement("INSERT INTO flight_booking(user_id, flight_id, num_seats) VALUES(?,?,?)");
            ps2.setInt(1, userId);
            ps2.setInt(2, flightId);
            ps2.setInt(3, seats);
            ps2.executeUpdate();

            PreparedStatement ps3 = con.prepareStatement("UPDATE flight SET seats_available = seats_available - ? WHERE flight_id=?");
            ps3.setInt(1, seats);
            ps3.setInt(2, flightId);
            ps3.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            try { con.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return false;
        }
    }
}
