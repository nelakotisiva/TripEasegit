package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Destination;
import utilpackage.com.DBConnection;

public class DestinationDAOImpl implements DestinationDAO {

    @Override
    public List<Destination> getAllDestinations() {

        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destination";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Destination> searchDestinations(String keyword) {

        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destination WHERE name LIKE ? OR location LIKE ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String k = "%" + keyword + "%";
            ps.setString(1, k);
            ps.setString(2, k);

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
    public Destination getDestinationById(int destinationId) {

        String sql = "SELECT * FROM destination WHERE destination_id=?";
        Destination d = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                d = new Destination();
                d.setDestinationId(rs.getInt("destination_id"));
                d.setLocation(rs.getString("location"));
                d.setImageUrl(rs.getString("image_url"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

}
