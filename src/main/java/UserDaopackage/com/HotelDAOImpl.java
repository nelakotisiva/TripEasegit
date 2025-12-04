package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Hotel;
import utilpackage.com.DBConnection;

public class HotelDAOImpl implements HotelDAO {

    Connection con;

    public HotelDAOImpl() {
        con = DBConnection.getConnector();
    }

    @Override
    public List<Hotel> getHotelsByLocation(String location) {
        List<Hotel> list = new ArrayList<>();

        String sql = "SELECT * FROM hotel WHERE LOWER(near_location) LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + location.toLowerCase().trim() + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Hotel h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setDestinationId(rs.getInt("destination_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setContact(rs.getString("contact"));
                h.setNearLocation(rs.getString("near_location"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));  // NEW
                list.add(h);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Hotel> getAllHotels() {
        // Not used anymore (we do not show all hotels)
        return new ArrayList<>();
    }
    
    
    
    public Hotel getHotelById(int id) {
        Hotel h = null;

        String sql = "SELECT * FROM hotel WHERE hotel_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setNearLocation(rs.getString("near_location"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return h;
    }

}
