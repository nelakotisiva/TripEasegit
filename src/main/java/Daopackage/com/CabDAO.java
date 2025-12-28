package Daopackage.com;

import java.sql.*;
import java.util.*;

import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class CabDAO {

    private Connection con = DBConnection.getConnection();

    /* ================= SEARCH BY LOCATION ================= */
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
                cab.setModel(rs.getString("model"));
                cab.setSeaterType(rs.getString("seater_type"));
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

    /* ================= ALL VEHICLES ================= */
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
                cab.setModel(rs.getString("model"));
                cab.setSeaterType(rs.getString("seater_type"));
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

    /* ================= SAVE BOOKING ================= */
    public boolean saveBooking(int userId, int rentalId, int passengers) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO cab_booking " +
                "(user_id, rental_id, model, seater_type, passengers, booking_date, status) " +
                "SELECT ?, rental_id, model, seater_type, ?, NOW(), 'Active' " +
                "FROM cab_rental WHERE rental_id=?"
            );

            ps.setInt(1, userId);
            ps.setInt(2, passengers);
            ps.setInt(3, rentalId);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ================= BOOKED IDS ================= */
    public List<Integer> getBookedVehicleIds(int userId) {
        List<Integer> ids = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT rental_id FROM cab_booking WHERE user_id=? AND status <> 'Cancelled'"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("rental_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }

    /* ================= GET MY BOOKINGS ================= */
    public List<Cab> getMyBookings(int userId) {
        List<Cab> list = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT r.*, b.booking_id, b.status, d.location " +
                "FROM cab_booking b " +
                "JOIN cab_rental r ON b.rental_id = r.rental_id " +
                "JOIN cab_destination d ON r.destination_id = d.destination_id " +
                "WHERE b.user_id = ?"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cab cab = new Cab();
                cab.setBookingId(rs.getInt("booking_id"));
                cab.setRentalId(rs.getInt("rental_id"));
                cab.setModel(rs.getString("model"));
                cab.setSeaterType(rs.getString("seater_type"));
                cab.setPricePerDay(rs.getDouble("price_per_day"));
                cab.setLocation(rs.getString("location"));
                cab.setImageUrl(rs.getString("image_url"));
                cab.setStatus(rs.getString("status"));
                list.add(cab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void cancelCabBooking(int bookingId) {

        String sql1 =
            "UPDATE cab_booking SET status='Cancelled' WHERE booking_id=?";

        String sql2 =
            "UPDATE booking SET status='Cancelled' " +
            "WHERE booking_id=? AND service_type='CAB'";

        try (Connection con = DBConnection.getConnection()) {

            try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
                ps1.setInt(1, bookingId);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                ps2.setInt(1, bookingId);
                ps2.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
