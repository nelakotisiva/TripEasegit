package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    private final Connection con;

    public FlightBookingDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        if (seats <= 0) return false;

        try {
            con.setAutoCommit(false);

            // Lock the row to prevent race conditions (MySQL InnoDB: SELECT ... FOR UPDATE)
            String selectSql = "SELECT seats_available FROM flight WHERE flight_id = ? FOR UPDATE";
            try (PreparedStatement ps1 = con.prepareStatement(selectSql)) {
                ps1.setInt(1, flightId);
                try (ResultSet rs = ps1.executeQuery()) {
                    if (!rs.next()) {
                        System.out.println("DEBUG: bookFlight - flight not found id=" + flightId);
                        con.rollback();
                        return false;
                    }
                    int available = rs.getInt(1);
                    System.out.println("DEBUG: bookFlight - available seats = " + available + " requested = " + seats);

                    if (available < seats) {
                        con.rollback();
                        return false;
                    }
                }
            }

            String insertBooking = "INSERT INTO flight_booking(user_id, flight_id, num_seats) VALUES(?,?,?)";
            try (PreparedStatement ps2 = con.prepareStatement(insertBooking)) {
                ps2.setInt(1, userId);
                ps2.setInt(2, flightId);
                ps2.setInt(3, seats);
                ps2.executeUpdate();
            }

            String updateFlight = "UPDATE flight SET seats_available = seats_available - ? WHERE flight_id = ?";
            try (PreparedStatement ps3 = con.prepareStatement(updateFlight)) {
                ps3.setInt(1, seats);
                ps3.setInt(2, flightId);
                int updated = ps3.executeUpdate();
                if (updated != 1) {
                    System.out.println("DEBUG: bookFlight - update affected " + updated + " rows");
                    con.rollback();
                    return false;
                }
            }

            con.commit();
            return true;

        } catch (Exception e) {
            try { con.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            try { con.setAutoCommit(true); } catch (Exception ex) { /* ignore */ }
        }
    }
}
