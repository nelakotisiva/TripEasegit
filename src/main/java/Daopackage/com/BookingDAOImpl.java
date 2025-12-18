package Daopackage.com;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Booking;
import dtopackage.com.BookingDTO;
import utilpackage.com.DBConnection;

public class BookingDAOImpl implements BookingDAO {
	
	@Override
	public Booking getBookingById(int bookingId) {
	    Booking booking = null;

	    String sql = "SELECT * FROM booking WHERE booking_id = ?";
	    try (Connection con = DBConnection.getConnector();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, bookingId);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            booking = new Booking();
	            booking.setBookingId(rs.getInt("booking_id"));
	            booking.setUserId(rs.getInt("user_id"));
	            booking.setDestinationId(rs.getInt("destination_id"));
	            booking.setBookingDate(rs.getDate("booking_date"));
	            booking.setTravelDate(rs.getDate("travel_date"));
	            booking.setStatus(rs.getString("status"));
	            booking.setNumOfPeople(rs.getInt("num_of_people"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return booking;
	}


	
	
	@Override
	public boolean saveServiceBooking(int userId,
	                                  int destinationId,
	                                  Date travelDate,
	                                  int numOfPeople) {

	    String sql = "INSERT INTO booking " +
	                 "(user_id, destination_id, booking_date, travel_date, status, num_of_people) " +
	                 "VALUES (?, ?, CURDATE(), ?, 'Confirmed', ?)";

	    try (Connection con = DBConnection.getConnector();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);
	        ps.setInt(2, destinationId);
	        ps.setDate(3, travelDate);
	        ps.setInt(4, numOfPeople);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	
	

	@Override
	public boolean updateBooking(int bookingId, String status, int numPeople) {
	    String sql = "UPDATE booking SET status=?, num_of_people=? WHERE booking_id=?";

	    try (Connection con = DBConnection.getConnector();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, status);
	        ps.setInt(2, numPeople);
	        ps.setInt(3, bookingId);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}



	@Override
	public boolean deleteBooking(int bookingId) {
	    String sql = "DELETE FROM booking WHERE booking_id=?";

	    try (Connection con = DBConnection.getConnector();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, bookingId);
	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}


    @Override
    public BookingDTO save(BookingDTO b) {
        // ... your existing save() code (unchanged)
        // (keep exactly what you already have)
    	return null;
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {
		return null;
        // ... your existing user-specific method (unchanged)
    }

    // 🔹 NEW: Admin – fetch ALL bookings
    @Override
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, b.user_id, b.destination_id, "
                + "b.booking_date, b.travel_date, b.status, b.num_of_people "
                + "FROM booking b "
                + "ORDER BY b.travel_date DESC";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

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

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
    
    @Override
    public boolean saveServiceBooking(int userId,
                                      int destinationId,
                                      java.sql.Timestamp bookingDate,
                                      int people) {

        String sql = "INSERT INTO booking " +
                     "(user_id, destination_id, booking_date, num_of_people, status) " +
                     "VALUES (?, ?, ?, ?, 'Confirmed')";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, destinationId);

            // 🔥 EXACT TIME
            ps.setObject(3, bookingDate);

            ps.setInt(4, people);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}
