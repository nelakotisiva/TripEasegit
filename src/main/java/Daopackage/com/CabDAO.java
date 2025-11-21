package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class CabDAO {

    // Fetch all cab/bike rentals
    public List<Cab> getAllRentals() {
        List<Cab> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnector();
            String query = "SELECT * FROM cab_rental";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Cab(
                    rs.getInt("rental_id"),
                    rs.getInt("destination_id"),
                    rs.getString("vehicle_type"),
                    rs.getString("model"),
                    rs.getDouble("price_per_day"),
                    rs.getString("availability")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // Book: update availability to 'Booked'
    public boolean bookRental(int rentalId) {
        try {
            Connection con = DBConnection.getConnector();
            String query = "UPDATE cab_rental SET availability = 'Booked' WHERE rental_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, rentalId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
