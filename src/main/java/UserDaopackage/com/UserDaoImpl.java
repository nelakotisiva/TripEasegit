package UserDaopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dtopackage.com.User;
import utilpackage.com.DBConnection;

public class UserDaoImpl implements UserDao{
	Connection con=null;
	@Override
	public boolean registerUser(User u) {
		String iqry="insert into user values(?,?,?,?,?,?,?)";
		con=DBConnection.getConnector();
		try {
			PreparedStatement psmt=con.prepareStatement(iqry);
			psmt.setInt(1, u.getUser_id());
			psmt.setString(2,u.getUsername());
			psmt.setString(3, u.getPassword());
			psmt.setString(4, u.getEmail());
			psmt.setString(5, u.getFull_name());
			psmt.setLong(6, u.getPhone());
			psmt.setString(7, u.getRole());
			
			int count=psmt.executeUpdate();
			if (count > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
			
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
