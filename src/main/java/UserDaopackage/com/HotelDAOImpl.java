package UserDaopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Hotel;
import utilpackage.com.DBConnection;

public class HotelDAOImpl implements HotelDAO {

    private Connection con;

    public HotelDAOImpl() {
        con = DBConnection.getConnector();
        if (con == null) {
            System.out.println("❌ DB connection failed");
        } else {
            System.out.println("✅ DB connected");
        }
    }

    // ---------------------------------------------------------
    // 1️⃣ GET ALL HOTELS
    // ---------------------------------------------------------
    @Override
    public List<Hotel> getAllHotels() {

        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM hotel";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Hotel h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setDestinationId(rs.getInt("destination_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setContact(rs.getString("contact"));
                h.setNearLocation(rs.getString("near_location"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));
                h.setImageUrl(rs.getString("image_url"));

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ---------------------------------------------------------
    // 2️⃣ GET HOTEL BY ID
    // ---------------------------------------------------------
    @Override
    public Hotel getHotelById(int hotelId) {

        String sql = "SELECT * FROM hotel WHERE hotel_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Hotel h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setDestinationId(rs.getInt("destination_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setContact(rs.getString("contact"));
                h.setNearLocation(rs.getString("near_location"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));
                h.setImageUrl(rs.getString("image_url"));

                return h;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ---------------------------------------------------------
    // 3️⃣ ADD HOTEL
    // ---------------------------------------------------------
    @Override
    public boolean addHotel(Hotel h) {

        String sql =
            "INSERT INTO hotel " +
            "(destination_id, hotel_name, price_per_night, rating, contact, near_location, rooms_available, image_url) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, h.getDestinationId());
            ps.setString(2, h.getHotelName());
            ps.setDouble(3, h.getPricePerNight());

            if (h.getRating() > 0)
                ps.setDouble(4, h.getRating());
            else
                ps.setNull(4, Types.DOUBLE);

            ps.setString(5, h.getContact());
            ps.setString(6, h.getNearLocation());
            ps.setInt(7, h.getRoomsAvailable());
            ps.setString(8, h.getImageUrl());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ---------------------------------------------------------
    // 4️⃣ UPDATE HOTEL
    // ---------------------------------------------------------
    @Override
    public boolean updateHotel(Hotel h) {

        String sql =
            "UPDATE hotel SET destination_id=?, hotel_name=?, price_per_night=?, " +
            "rating=?, contact=?, near_location=?, rooms_available=?, image_url=? " +
            "WHERE hotel_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, h.getDestinationId());
            ps.setString(2, h.getHotelName());
            ps.setDouble(3, h.getPricePerNight());

            if (h.getRating() > 0)
                ps.setDouble(4, h.getRating());
            else
                ps.setNull(4, Types.DOUBLE);

            ps.setString(5, h.getContact());
            ps.setString(6, h.getNearLocation());
            ps.setInt(7, h.getRoomsAvailable());
            ps.setString(8, h.getImageUrl());
            ps.setInt(9, h.getHotelId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ---------------------------------------------------------
    // 5️⃣ DELETE HOTEL
    // ---------------------------------------------------------
    @Override
    public boolean deleteHotel(int hotelId) {

        String sql = "DELETE FROM hotel WHERE hotel_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, hotelId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ---------------------------------------------------------
    // 6️⃣ SEARCH BY CITY ✅ (FIXED)
    // ---------------------------------------------------------
    @Override
    public List<Hotel> searchHotelsByCity(String cityName) {

        List<Hotel> list = new ArrayList<>();

        String sql =
            "SELECT h.* FROM hotel h " +
            "JOIN destination1 d ON h.destination_id = d.destination_id " +
            "WHERE LOWER(d.city_name) = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cityName.toLowerCase().trim());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Hotel h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setDestinationId(rs.getInt("destination_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setNearLocation(rs.getString("near_location"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));
                h.setImageUrl(rs.getString("image_url"));

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------------------------------------------------
    // 7️⃣ SEARCH BY AREA
    // ---------------------------------------------------------
    @Override
    public List<Hotel> getHotelsByLocation(String area) {

        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM hotel WHERE LOWER(near_location) LIKE ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + area.toLowerCase().trim() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Hotel h = new Hotel();
                h.setHotelId(rs.getInt("hotel_id"));
                h.setDestinationId(rs.getInt("destination_id"));
                h.setHotelName(rs.getString("hotel_name"));
                h.setPricePerNight(rs.getDouble("price_per_night"));
                h.setRating(rs.getDouble("rating"));
                h.setNearLocation(rs.getString("near_location"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));
                h.setImageUrl(rs.getString("image_url"));

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
