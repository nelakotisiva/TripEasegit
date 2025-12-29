package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.AdminBookingDTO;
import utilpackage.com.DBConnection;

public class AdminBookingDAO {

    public List<AdminBookingDTO> getAllAdminBookings() {

        List<AdminBookingDTO> list = new ArrayList<>();

        String sql =
        	    "SELECT " +
        	    " b.booking_id, " +
        	    " b.user_id, " +
        	    " u.full_name AS user_name, " +
        	    " b.service_type, " +
        	    " b.booking_date, " +

        	    " CASE b.service_type " +
        	    "  WHEN 'HOTEL' THEN hb.check_in " +
        	    "  WHEN 'CAB' THEN cb.booking_date " +
        	    "  ELSE b.travel_date " +
        	    " END AS travel_date, " +

        	    " CASE b.service_type " +
        	    "  WHEN 'HOTEL' THEN hb.guests " +
        	    "  WHEN 'CAB' THEN cb.passengers " +
        	    "  ELSE b.num_of_people " +
        	    " END AS num_of_people, " +

        	    " b.status, " +

        	    " CASE b.service_type " +
        	    "  WHEN 'HOTEL' THEN h.hotel_name " +
        	    "  WHEN 'FLIGHT' THEN f.airline " +
        	    "  WHEN 'CAB' THEN c.model " +
        	    "  WHEN 'RESTAURANT' THEN r.name " +
        	    " END AS title, " +

        	    " CASE b.service_type " +
        	    "  WHEN 'HOTEL' THEN h.near_location " +
        	    "  WHEN 'FLIGHT' THEN CONCAT(f.source,' → ',f.destination) " +
        	    "  WHEN 'CAB' THEN cd.location " +
        	    "  WHEN 'RESTAURANT' THEN d.location " +
        	    " END AS subtitle " +

        	    "FROM booking b " +
        	    "JOIN user u ON b.user_id = u.user_id " +

        	    "LEFT JOIN hotel_booking hb ON b.booking_id = hb.booking_id " +
        	    "LEFT JOIN hotel h ON hb.hotel_id = h.hotel_id " +

        	    "LEFT JOIN flight_booking fb ON b.booking_id = fb.booking_id " +
        	    "LEFT JOIN flight f ON fb.flight_id = f.flight_id " +

        	    "LEFT JOIN cab_booking cb ON b.booking_id = cb.booking_id " +
        	    "LEFT JOIN cab_rental c ON cb.rental_id = c.rental_id " +
        	    "LEFT JOIN cab_destination cd ON c.destination_id = cd.destination_id " +

        	    "LEFT JOIN restaurant_booking rb ON b.booking_id = rb.booking_id " +
        	    "LEFT JOIN restaurant r ON rb.restaurant_id = r.restaurant_id " +
        	    "LEFT JOIN destination d ON r.destination_id = d.destination_id " +

        	    "WHERE b.service_type IS NOT NULL " +
        	    "ORDER BY b.booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                AdminBookingDTO dto = new AdminBookingDTO();

                dto.setBookingId(rs.getInt("booking_id"));
                dto.setUserId(rs.getInt("user_id"));
                dto.setUserName(rs.getString("user_name")); // ✅ FULL NAME
                dto.setServiceType(rs.getString("service_type"));

                dto.setTitle(rs.getString("title"));
                dto.setSubtitle(rs.getString("subtitle"));

                dto.setBookingDate(rs.getDate("booking_date"));
                dto.setTravelDate(rs.getDate("travel_date"));
                dto.setPeople(rs.getInt("num_of_people"));
                dto.setStatus(rs.getString("status"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
