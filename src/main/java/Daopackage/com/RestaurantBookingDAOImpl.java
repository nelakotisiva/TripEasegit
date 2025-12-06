package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dtopackage.com.RestaurantBooking;
import utilpackage.com.DBConnection;

public class RestaurantBookingDAOImpl implements RestaurantBookingDAO {
	
	@Override
	public boolean bookRestaurant(RestaurantBooking rb) {
		Connection con=DBConnection.getConnector();
		String sql="insert into restaurant_booking values(?,?,?,?,?)";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, rb.getUserId());
			ps.setInt(2, rb.getRestaurantId());
			ps.setDate(3, rb.getBookingDate());
			ps.setInt(4, rb.getNumPeople());
			ps.setString(5, rb.getStatus());
			return ps.executeUpdate()==1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
