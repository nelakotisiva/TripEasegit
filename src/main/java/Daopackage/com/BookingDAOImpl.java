package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Booking;
import utilpackage.com.DBConnection;

public class BookingDAOImpl implements BookingDAO {

    private Connection conn;

    public BookingDAOImpl() {
        conn = DBConnection.getConnector(); // use your existing DB connection
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.user_id, b.destination_id, d.name AS destination_name, "
                   + "b.booking_date, b.travel_date, b.status, b.num_of_people "
                   + "FROM booking b "
                   + "JOIN destination d ON b.destination_id = d.destination_id "
                   + "WHERE b.user_id = ? "
                   + "ORDER BY b.travel_date DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setDestinationId(rs.getInt("destination_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setTravelDate(rs.getDate("travel_date"));
                booking.setStatus(rs.getString("status"));
                booking.setNumOfPeople(rs.getInt("num_of_people"));
                // Optionally: later add destinationName in DTO

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
}
