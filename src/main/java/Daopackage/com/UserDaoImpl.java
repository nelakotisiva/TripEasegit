package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.User;
import utilpackage.com.DBConnection;

public class UserDaoImpl implements UserDao {

    Connection con = null;

    @Override
    public boolean registerUser(User u) {
        String iqry = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";
        con = DBConnection.getConnector();

        try {
            PreparedStatement psmt = con.prepareStatement(iqry);
            psmt.setInt(1, u.getUser_id());
            psmt.setString(2, u.getUsername());
            psmt.setString(3, u.getPassword());
            psmt.setString(4, u.getEmail());
            psmt.setString(5, u.getFull_name());
            psmt.setLong(6, u.getPhone());
            psmt.setString(7, u.getRole());
            return psmt.executeUpdate() > 0;

        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public User loginUser(String username, String password) {
        User user = null;

        try (Connection con = DBConnection.getConnector();
             PreparedStatement pst = con.prepareStatement(
                     "SELECT * FROM user WHERE username = ? AND password = ?")) {

            pst.setString(1, username);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getLong("phone"),
                    rs.getString("role")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }

        return user;
    }

    @Override
    public User getid(int id) {
        User user = null;
        String qry = "SELECT * FROM user WHERE user_id = ?";
        con = DBConnection.getConnector();

        try {
            PreparedStatement psmt = con.prepareStatement(qry);
            psmt.setInt(1, id);
            ResultSet rs = psmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getLong("phone"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) { e.printStackTrace(); }

        return user;
    }

    @Override
    public boolean updatedetails(User u) {
        String uqry = "UPDATE user SET full_name=?, username=?, email=?, phone=?, role=? WHERE user_id=?";
        con = DBConnection.getConnector();

        try {
            PreparedStatement psmt = con.prepareStatement(uqry);
            psmt.setString(1, u.getFull_name());
            psmt.setString(2, u.getUsername());
            psmt.setString(3, u.getEmail());
            psmt.setLong(4, u.getPhone());
            psmt.setString(5, u.getRole());
            psmt.setInt(6, u.getUser_id());
            return psmt.executeUpdate() > 0;

        } catch (SQLException e) { e.printStackTrace(); }

        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnector();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM user");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getLong("phone"),
                    rs.getString("role")
                ));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    @Override
    public boolean addUser(User user) {
        try (Connection conn = DBConnection.getConnector();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)")) {

            ps.setInt(1, user.getUser_id());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getFull_name());
            ps.setLong(6, user.getPhone());
            ps.setString(7, user.getRole());
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean deleteUser(int id) {
        try (Connection conn = DBConnection.getConnector();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM user WHERE user_id=?")) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}