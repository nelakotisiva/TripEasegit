package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dtopackage.com.User;
import utilpackage.com.DBConnection;

public class UserDaoImpl implements UserDao {

	@Override
	public boolean registerUser(User u) {
	    Connection con = null;
	    PreparedStatement pst = null;

	    try {
	        con = DBConnection.getConnector();
	        System.out.println("Connection = " + con);

	        String iqry = "INSERT INTO `user` (user_id, username, password, email, full_name, phone, role) "
	                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";

	        pst = con.prepareStatement(iqry);

	        pst.setInt(1, u.getUser_id());
	        pst.setString(2, u.getUsername());
	        pst.setString(3, u.getPassword());
	        pst.setString(4, u.getEmail());
	        pst.setString(5, u.getFull_name());
	        pst.setLong(6, u.getPhone());
	        pst.setString(7, u.getRole());

	        int rows = pst.executeUpdate();
	        System.out.println("Rows inserted = " + rows);

	        return rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}



	@Override
	public User loginUser(String username, String password) {
	    Connection con = null;
	    PreparedStatement pst = null;
	    User user = null;

	    try {
	        con = DBConnection.getConnector();

	        String sql = "SELECT * FROM `user` WHERE username = ? AND password = ?";
	        pst = con.prepareStatement(sql);
	        pst.setString(1, username);
	        pst.setString(2, password);

	        ResultSet rs = pst.executeQuery();

	        if (rs.next()) {
	            user = new User(
	                rs.getInt("user_id"),
	                rs.getString("username"),
	                rs.getString("email"),
	                rs.getString("password"),
	                rs.getString("full_name"),
	                rs.getLong("phone"),
	                rs.getString("role")
	            );
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}

    }
