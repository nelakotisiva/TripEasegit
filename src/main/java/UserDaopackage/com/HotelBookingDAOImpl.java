package UserDaopackage.com;

import java.sql.*;
import java.util.*;

import dtopackage.com.Bookingg;
import utilpackage.com.DBConnection;

public class HotelBookingDAOImpl implements HotelBookingDAO {

    /* ================= SAVE BOOKING ================= */
    @Override
    public boolean saveBooking(int userId, int hotelId,
            String checkin, String checkout,
            int guests, double total) {

Connection con = null;
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
ResultSet rs = null;

try {
con = DBConnection.getConnection();
con.setAutoCommit(false);

/* 1️⃣ INSERT INTO booking */
String bookingSql =
"INSERT INTO booking " +
"(user_id, service_type, booking_date, status) " +
"VALUES (?, 'HOTEL', NOW(), 'Confirmed')";

ps1 = con.prepareStatement(bookingSql, Statement.RETURN_GENERATED_KEYS);
ps1.setInt(1, userId);
ps1.executeUpdate();

rs = ps1.getGeneratedKeys();
if (!rs.next()) return false;

int bookingId = rs.getInt(1);

/* 2️⃣ INSERT INTO hotel_booking */
String hotelSql =
"INSERT INTO hotel_booking " +
"(booking_id, user_id, hotel_id, check_in, check_out, guests, total_amount, status) " +
"VALUES (?, ?, ?, ?, ?, ?, ?, 'Confirmed')";

ps2 = con.prepareStatement(hotelSql);
ps2.setInt(1, bookingId);
ps2.setInt(2, userId);
ps2.setInt(3, hotelId);
ps2.setString(4, checkin);
ps2.setString(5, checkout);
ps2.setInt(6, guests);
ps2.setDouble(7, total);

ps2.executeUpdate();

con.commit();
return true;

} catch (Exception e) {
try { con.rollback(); } catch (Exception ex) {}
e.printStackTrace();
}
return false;
}


    /* ================= GET BOOKINGS BY USER ================= */
    @Override
    public List<Bookingg> getBookingsByUser(int userId) {

        List<Bookingg> list = new ArrayList<>();

        String sql =
            "SELECT hb.booking_id, hb.user_id, hb.hotel_id, " +
            "hb.check_in, hb.check_out, hb.guests, hb.total_amount, " +
            "hb.booking_date, hb.status, " +          // 🔥 IMPORTANT
            "h.hotel_name, h.near_location " +
            "FROM hotel_booking hb " +
            "JOIN hotel h ON hb.hotel_id = h.hotel_id " +
            "WHERE hb.user_id = ? " +
            "ORDER BY hb.booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bookingg b = new Bookingg();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setHotelId(rs.getInt("hotel_id"));
                b.setCheckin(rs.getString("check_in"));
                b.setCheckout(rs.getString("check_out"));
                b.setGuests(rs.getInt("guests"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setStatus(rs.getString("status"));      // 🔥 FIX
                b.setHotelName(rs.getString("hotel_name"));
                b.setHotelLocation(rs.getString("near_location"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* ================= CANCEL BOOKING ================= */
    @Override
    public void cancelBooking(int bookingId) {

        String sql =
            "UPDATE hotel_booking SET status='Cancelled' WHERE booking_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
