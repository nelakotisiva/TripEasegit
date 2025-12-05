package Daopackage.com;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;

import utilpackage.com.DBConnection;

public class BookingDAO {
	  public dtopackage.com.BookingDTO save(dtopackage.com.BookingDTO b) {
	        String sql = "INSERT INTO bookings(package_id, customer_name, email, phone, from_location, to_location, travellers, travel_date, return_date) VALUES (?,?,?,?,?,?,?,?,?)";

	        try (Connection con = DBConnection.getConnector();
	             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	            ps.setInt(1, b.getPackageId());
	            ps.setString(2, b.getCustomerName());
	            ps.setString(3, b.getEmail());
	            ps.setString(4, b.getPhone());
	            ps.setString(5, b.getFromLocation());
	            ps.setString(6, b.getToLocation());
	            ps.setInt(7, b.getTravellers());

	            // travel_date
	            if (b.getTravelDate() != null && !b.getTravelDate().trim().isEmpty()) {
	                ps.setDate(8, Date.valueOf(b.getTravelDate()));
	            } else {
	                ps.setNull(8, Types.DATE);
	            }

	            // return_date
	            if (b.getReturnDate() != null && !b.getReturnDate().trim().isEmpty()) {
	                ps.setDate(9, Date.valueOf(b.getReturnDate()));
	            } else {
	                ps.setNull(9, Types.DATE);
	            }

	            ps.executeUpdate();

	            try (ResultSet keys = ps.getGeneratedKeys()) {
	                if (keys.next()) {
	                    int id = keys.getInt(1);
	                    b.setId(id);

	                    // fetch booking_date from DB
	                    String q = "SELECT booking_date FROM bookings WHERE id = ?";
	                    try (PreparedStatement ps2 = con.prepareStatement(q)) {
	                        ps2.setInt(1, id);
	                        try (ResultSet rs = ps2.executeQuery()) {
	                            if (rs.next()) {
	                                Timestamp ts = rs.getTimestamp("booking_date");
	                                if (ts != null) {
	                                    b.setBookingDate(ts.toLocalDateTime());
	                                } else {
	                                    b.setBookingDate(LocalDateTime.now());
	                                }
	                            }
	                        }
	                    }
	                }
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return null;
	        }

	        return b;
	    }
}

