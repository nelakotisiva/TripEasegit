package Daopackage.com;
//h
import java.sql.*;
import java.util.*;
import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class CabDAO {

    private Connection con = DBConnection.getConnector();

    // ? SEARCH CABS BY LOCATION (JOIN FIXED)
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

    // ? ALL CABS
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

    // ? SAVE BOOKING
    public boolean saveBooking(int userId, int rentalId, int passengers) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO cab_booking " +
                "(user_id, rental_id, model, seater_type, passengers) " +
                "SELECT ?, rental_id, model, seater_type, ? " +
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

    // ? BOOKED IDS
    public List<Integer> getBookedVehicleIds(int userId) {
        List<Integer> ids = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT rental_id FROM cab_booking WHERE user_id = ?"
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
 // ? GET MY BOOKINGS
    public List<Cab> getMyBookings(int userId) {
        List<Cab> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT r.*, b.booking_id, d.location FROM cab_booking b " +
                "JOIN cab_rental r ON b.rental_id = r.rental_id " +
                "JOIN cab_destination d ON r.destination_id = d.destination_id " +
                "WHERE b.user_id = ?"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cab cab = new Cab();
                cab.setRentalId(rs.getInt("rental_id"));
                cab.setModel(rs.getString("model"));
                cab.setSeaterType(rs.getString("seater_type"));
                cab.setPricePerDay(rs.getDouble("price_per_day"));
                cab.setLocation(rs.getString("location"));
                cab.setImageUrl(rs.getString("image_url"));
                list.add(cab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ? CANCEL BOOKING
    public void cancelBooking(int userId, int rentalId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM cab_booking WHERE user_id=? AND rental_id=?"
            );
            ps.setInt(1, userId);
            ps.setInt(2, rentalId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 // ? GET USER CAB BOOKINGS
    public List<Cab> getUserBookings(int userId) {
        List<Cab> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM cab_booking WHERE user_id=?"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cab cab = new Cab();
                cab.setRentalId(rs.getInt("rental_id"));
                cab.setModel(rs.getString("model"));
                cab.setSeaterType(rs.getString("seater_type"));
                cab.setPricePerDay(rs.getDouble("price"));
                list.add(cab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ? CANCEL CAB BOOKING
    public void cancelBooking(int bookingId) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM cab_booking WHERE booking_id=?"
            );
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Cab> getBookedCabsByUser(int userId) {
        List<Cab> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnector();
            String sql = "SELECT * FROM cab WHERE booked_by = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cab c = new Cab();
                c.setRentalId(userId);
                c.setModel(sql);
                c.setSeaterType(sql);
                c.setPricePerDay(userId);
                c.setImageUrl(rs.getString("image_url"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private int getDestinationIdByRental(int rentalId) {

        String sql = "SELECT destination_id FROM cab_rental WHERE rental_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, rentalId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("destination_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}   

