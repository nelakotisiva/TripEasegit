package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

import utilpackage.com.DBConnection;

public class FlightBookingDAOImpl implements FlightBookingDAO {

    Connection con;

    public FlightBookingDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public boolean bookFlight(int userId, int flightId, int seats, Date travelDate) {
        try {
            con.setAutoCommit(false);

            // Step 1: Lock flight record
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT seats_available FROM flight WHERE flight_id=? FOR UPDATE"
            );
            ps1.setInt(1, flightId);

            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) {
                con.rollback();
                return false;
            }

            int available = rs.getInt("seats_available");

            // Step 2: Validate seats
            if (available < seats) {
                con.rollback();
                return false;
            }

            // Step 3: Insert booking row
            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO flight_booking (user_id, flight_id, num_seats, travel_date) " +
                "VALUES (?, ?, ?, ?)"
            );
            ps2.setInt(1, userId);
            ps2.setInt(2, flightId);
            ps2.setInt(3, seats);
            ps2.setDate(4, travelDate);
            ps2.executeUpdate();

            // Step 4: Update seat availability
            PreparedStatement ps3 = con.prepareStatement(
                "UPDATE flight SET seats_available = seats_available - ? WHERE flight_id=?"
            );
            ps3.setInt(1, seats);
            ps3.setInt(2, flightId);
            ps3.executeUpdate();

            // Step 5: Commit transaction
            con.commit();
            return true;

        } catch (Exception e) {
            try { con.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return false;
        }
    }

    // Unused old method
    @Override
    public boolean bookFlight(int userId, int flightId, int seats) {
        return false;
    }
}
