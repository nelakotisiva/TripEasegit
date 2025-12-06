package Daopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class CabDAO {

    private Connection con = DBConnection.getConnector();

    // ✅ SEARCH CABS BY LOCATION (JOIN FIXED)
    public List<Cab> getVehiclesByLocation(String location) {
        List<Cab> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT r.*, d.location FROM cab_rental r " +
                "JOIN cab_destination d ON r.destination_id = d.destination_id " +
                "WHERE d.location LIKE ?"
            );
            ps.setString(1, "%" + location + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cab cab = new Cab();
                cab.setRentalId(rs.getInt("rental_id"));
                cab.setSeaterType(rs.getString("seater_type"));
                cab.setModel(rs.getString("model"));
                cab.setPricePerDay(rs.getDouble("price_per_day"));
                cab.setAvailability(rs.getString("availability"));
                cab.setLocation(rs.getString("location"));
                cab.setImageUrl(rs.getString("image_url"));

                list.add(cab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ ALL CABS
    public List<Cab> getAllVehicles() {
        List<Cab> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT r.*, d.location FROM cab_rental r " +
                "JOIN cab_destination d ON r.destination_id = d.destination_id"
            );
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cab cab = new Cab();
                cab.setRentalId(rs.getInt("rental_id"));
                cab.setSeaterType(rs.getString("seater_type"));
                cab.setModel(rs.getString("model"));
                cab.setPricePerDay(rs.getDouble("price_per_day"));
                cab.setAvailability(rs.getString("availability"));
                cab.setLocation(rs.getString("location"));
                cab.setImageUrl(rs.getString("image_url"));

                list.add(cab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ SAVE BOOKING
    public boolean saveBooking(int userId, int rentalId, int passengers) {
        try {
        	PreparedStatement ps = con.prepareStatement(
        		    "INSERT INTO cab_booking(user_id, rental_id, model, seater_type, passengers, booking_date) " +
        		    "SELECT ?, rental_id, model, seater_type, ?, NOW() FROM cab_rental WHERE rental_id = ?"
        		);

        		ps.setInt(1, userId);
        		ps.setInt(2, passengers);
        		ps.setInt(3, rentalId);


            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ BOOKED IDS
    public List<Integer> getBookedVehicleIds() {
        List<Integer> ids = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT rental_id FROM cab_booking"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("rental_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }
}
