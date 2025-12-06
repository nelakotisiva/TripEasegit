package Daopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class AdminCabDAO {

    // ⭐ Get All Cabs
    public List<Cab> getAllCabs() {
        List<Cab> list = new ArrayList<>();
        String query = "SELECT c.*, d.location FROM cab_rental c " +
                       "JOIN cab_destination d ON c.destination_id = d.destination_id";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cab c = new Cab();
                c.setRentalId(rs.getInt("rental_id"));
                c.setModel(rs.getString("model"));
                c.setSeaterType(rs.getString("seater_type"));
                c.setPricePerDay(rs.getDouble("price_per_day"));
                c.setAvailability(rs.getString("availability"));
                c.setLocation(rs.getString("location"));
                c.setImageUrl(rs.getString("image_url"));
                c.setDestinationId(rs.getInt("destination_id"));
                list.add(c);
            }

        } catch (Exception e) {
            System.out.println("❌ Error in getAllCabs(): " + e.getMessage());
        }
        return list;
    }

    // 🚕 Add Cab
    public boolean addCab(Cab cab) {
        String query = "INSERT INTO cab_rental(seater_type, model, price_per_day, availability, destination_id, image_url) " +
                       "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, cab.getSeaterType());
            ps.setString(2, cab.getModel());
            ps.setDouble(3, cab.getPricePerDay());
            ps.setString(4, cab.getAvailability());
            ps.setInt(5, cab.getDestinationId());
            ps.setString(6, cab.getImageUrl());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error in addCab(): " + e.getMessage());
        }
        return false;
    }

    // ✏ Update Cab
    public boolean updateCab(Cab cab) {
        String query = "UPDATE cab_rental SET seater_type=?, model=?, price_per_day=?, availability=?, destination_id=?, image_url=? " +
                       "WHERE rental_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, cab.getSeaterType());
            ps.setString(2, cab.getModel());
            ps.setDouble(3, cab.getPricePerDay());
            ps.setString(4, cab.getAvailability());
            ps.setInt(5, cab.getDestinationId());
            ps.setString(6, cab.getImageUrl());
            ps.setInt(7, cab.getRentalId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error in updateCab(): " + e.getMessage());
        }
        return false;
    }

    // ❌ Delete Cab
    public boolean deleteCab(int id) {
        String query = "DELETE FROM cab_rental WHERE rental_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("❌ Error in deleteCab(): " + e.getMessage());
        }
        return false;
    }

    // 🔍 Search by Model or Location
    public List<Cab> searchCabs(String keyword) {
        List<Cab> list = new ArrayList<>();
        String query = "SELECT c.*, d.location FROM cab_rental c " +
                       "JOIN cab_destination d ON c.destination_id = d.destination_id " +
                       "WHERE c.model LIKE ? OR d.location LIKE ?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query)) {

            String pat = "%" + keyword + "%";
            ps.setString(1, pat);
            ps.setString(2, pat);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cab c = new Cab();
                    c.setRentalId(rs.getInt("rental_id"));
                    c.setModel(rs.getString("model"));
                    c.setSeaterType(rs.getString("seater_type"));
                    c.setPricePerDay(rs.getDouble("price_per_day"));
                    c.setAvailability(rs.getString("availability"));
                    c.setLocation(rs.getString("location"));
                    c.setDestinationId(rs.getInt("destination_id"));
                    c.setImageUrl(rs.getString("image_url"));
                    list.add(c);
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Error in searchCabs(): " + e.getMessage());
        }
        return list;
    }
}
