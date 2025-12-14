package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.User;
import utilpackage.com.DBConnection;

public class UserDaoImpl implements UserDao {

    // ✅ Register User
    @Override
    public boolean registerUser(User u) {

        String sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setInt(1, u.getUser_id());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getFull_name());
            ps.setLong(6, u.getPhone());
            ps.setString(7, u.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Login User (FIXED – NO NPE)
    @Override
    public User loginUser(String username, String password) {

        User user = null;
        String sql = "SELECT * FROM user WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return null;

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Get User by ID
    @Override
    public User getid(int id) {

        User user = null;
        String sql = "SELECT * FROM user WHERE user_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return null;

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Update User
    @Override
    public boolean updatedetails(User u) {

        String sql = "UPDATE user SET full_name=?, username=?, email=?, phone=?, role=? WHERE user_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setString(1, u.getFull_name());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getEmail());
            ps.setLong(4, u.getPhone());
            ps.setString(5, u.getRole());
            ps.setInt(6, u.getUser_id());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get All Users
    @Override
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (con == null) return list;

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

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Add User
    @Override
    public boolean addUser(User user) {

        String sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setInt(1, user.getUser_id());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getFull_name());
            ps.setLong(6, user.getPhone());
            ps.setString(7, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete User
    @Override
    public boolean deleteUser(int id) {

        String sql = "DELETE FROM user WHERE user_id=?";

        try (Connection con = DBConnection.getConnector();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
