package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Restaurant;
import dtopackage.com.RestaurantBooking;
import utilpackage.com.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    private Connection con;

    public RestaurantDAOImpl() {
        con = DBConnection.getConnection();
    }

    // -------------------------------
    // MAP RESULTSET → RESTAURANT DTO
    // -------------------------------
    private Restaurant mapRow(ResultSet rs) throws SQLException {
        Restaurant r = new Restaurant();
        r.setRestaurantId(rs.getInt("restaurant_id"));
        r.setDestinationId(rs.getInt("destination_id"));
        r.setName(rs.getString("name"));
        r.setType(rs.getString("type"));
        r.setRating(rs.getDouble("rating"));
        r.setContact(String.valueOf(rs.getLong("contact")));
        r.setAvgPrice(rs.getDouble("avg_price"));
        r.setLatitude(rs.getDouble("latitude"));
        r.setLongitude(rs.getDouble("longitude"));
        r.setImageUrl(rs.getString("image_url"));
        return r;
    }

    // -------------------------------
    // GET ALL RESTAURANTS
    // -------------------------------
    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurant";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // -------------------------------
    // ADD NEW RESTAURANT
    // -------------------------------
    @Override
    public boolean addRestaurant(Restaurant r) {

        String sql =
            "INSERT INTO restaurant " +
            "(destination_id, name, type, rating, contact, avg_price, latitude, longitude, image_url) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getDestinationId());
            ps.setString(2, r.getName());
            ps.setString(3, r.getType());
            ps.setDouble(4, r.getRating());
            ps.setString(5, r.getContact());
            ps.setDouble(6, r.getAvgPrice());
            ps.setDouble(7, r.getLatitude());
            ps.setDouble(8, r.getLongitude());
            ps.setString(9, r.getImageUrl());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // -------------------------------
    // UPDATE RESTAURANT
    // -------------------------------
    @Override
    public boolean updateRestaurant(Restaurant r) {

        String sql =
            "UPDATE restaurant SET " +
            "destination_id=?, name=?, type=?, rating=?, contact=?, avg_price=?, latitude=?, longitude=?, image_url=? " +
            "WHERE restaurant_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getDestinationId());
            ps.setString(2, r.getName());
            ps.setString(3, r.getType());
            ps.setDouble(4, r.getRating());
            ps.setString(5, r.getContact());
            ps.setDouble(6, r.getAvgPrice());
            ps.setDouble(7, r.getLatitude());
            ps.setDouble(8, r.getLongitude());
            ps.setString(9, r.getImageUrl());
            ps.setInt(10, r.getRestaurantId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // -------------------------------
    // DELETE RESTAURANT
    // -------------------------------
    @Override
    public boolean deleteRestaurant(int id) {

        String sql = "DELETE FROM restaurant WHERE restaurant_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // -------------------------------
    // GET RESTAURANT BY ID
    // -------------------------------
    @Override
    public Restaurant getRestaurantById(int id) {

        String sql = "SELECT * FROM restaurant WHERE restaurant_id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // -------------------------------
    // GET RESTAURANTS BY MAX PRICE
    // -------------------------------
    @Override
    public List<Restaurant> getRestaurantsByMaxPrice(double budget) {

        List<Restaurant> list = new ArrayList<>();
        String sql =
            "SELECT * FROM restaurant WHERE avg_price <= ? ORDER BY avg_price ASC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, budget);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // -------------------------------
    // USER RESTAURANT BOOKINGS (JOIN)
    // -------------------------------
    @Override
    public List<RestaurantBooking> getBookingsByUserId(int userId) {

        List<RestaurantBooking> list = new ArrayList<>();

        String sql =
            "SELECT rb.booking_id, rb.user_id, rb.restaurant_id, " +
            "rb.booking_date, rb.num_people, rb.status, " +
            "r.name AS restaurant_name, " +
            "d.location AS location " +
            "FROM restaurant"
            + "_booking rb " +
            "JOIN restaurant r ON rb.restaurant_id = r.restaurant_id " +
            "LEFT JOIN destination d ON r.destination_id = d.destination_id " +
            "WHERE rb.user_id = ? " +
            "ORDER BY rb.booking_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                RestaurantBooking rb = new RestaurantBooking();
                rb.setBookingId(rs.getInt("booking_id"));
                rb.setUserId(rs.getInt("user_id"));
                rb.setRestaurantId(rs.getInt("restaurant_id"));
                rb.setBookingDate1(rs.getTimestamp("booking_date"));
                rb.setNumPeople(rs.getInt("num_people"));
                rb.setStatus(rs.getString("status"));
                rb.setRestaurantName(rs.getString("restaurant_name"));
                rb.setLocation(rs.getString("location"));

                list.add(rb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // -------------------------------
    // LAST BOOKING AMOUNT (BUDGET)
    // -------------------------------
    @Override
    public double getLastBookingAmountRestaurant(int userId) {

        String sql =
            "SELECT r.avg_price " +
            "FROM restaurant_booking rb " +
            "JOIN restaurant r ON rb.restaurant_id = r.restaurant_id " +
            "WHERE rb.user_id = ? " +
            "ORDER BY rb.booking_date DESC " +
            "LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_price");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
