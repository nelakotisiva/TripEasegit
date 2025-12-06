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
    public BookingDTO save(BookingDTO b) {
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

                    // fetch booking_date
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


    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, b.user_id, b.destination_id, d.name AS destination_name, "
                + "b.booking_date, b.travel_date, b.status, b.num_of_people "
                + "FROM booking b "
                + "JOIN destination d ON b.destination_id = d.destination_id "
                + "WHERE b.user_id = ? "
                + "ORDER BY b.travel_date DESC";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

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

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
}
