package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Destination;
import utilpackage.com.DBConnection;

public class DestinationDAOImpl implements DestinationDAO {

    private Connection con;

    public DestinationDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public List<Destination> getAllDestinations() {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT destination_id, name FROM destination";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Destination d = new Destination();
                d.setDestinationId(rs.getInt("destination_id"));
                d.setName(rs.getString("name"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
