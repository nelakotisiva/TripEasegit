package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Destination;
import utilpackage.com.DBConnection;

public class DestinationDAOImpl implements DestinationDAO {

    // 📌 Get All Destinations
    @Override
    public List<Destination> getAllDestinations() {
        List<Destination> list = new ArrayList<>();
        String query = "SELECT * FROM destination";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Destination d = new Destination();
                d.setDestinationId(rs.getInt("destination_id")); // DB COLUMN
                d.setName(rs.getString("name"));
                d.setLocation(rs.getString("location"));
                d.setDescription(rs.getString("description"));
                d.setImageUrl(rs.getString("image_url")); // DB COLUMN
                d.setPrice(rs.getDouble("price"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔎 Search by name/location
    @Override
    public List<Destination> searchDestinations(String keyword) {
        List<Destination> list = new ArrayList<>();
        String query = "SELECT * FROM destination WHERE name LIKE ? OR location LIKE ?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(query)) {

            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Destination d = new Destination();
                    d.setDestinationId(rs.getInt("destination_id"));
                    d.setName(rs.getString("name"));
                    d.setLocation(rs.getString("location"));
                    d.setDescription(rs.getString("description"));
                    d.setImageUrl(rs.getString("image_url"));
                    d.setPrice(rs.getDouble("price"));
                    list.add(d);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
