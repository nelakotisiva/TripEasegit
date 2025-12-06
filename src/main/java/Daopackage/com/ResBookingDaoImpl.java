package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dtopackage.com.RestaurantBooking;
import utilpackage.com.DBConnection;


public class ResBookingDaoImpl implements ResBookingDAO{
	Connection con=null;
	@Override
	public double getLastBookingAmountRestaurent(int userId) {
		con =DBConnection.getConnector();
		String sql="SELECT p.amount \r\n"
				+ "FROM payment p \r\n"
				+ "JOIN booking b ON p.booking_id=b.booking_id \r\n"
				+ "WHERE b.user_id=? \r\n"
				+ "ORDER BY p.payment_date DESC \r\n"
				+ "LIMIT 1;\r\n"
				+ "";
		try {
			PreparedStatement psmt=con.prepareStatement(sql);
			psmt.setInt(1, userId);
			ResultSet rs=psmt.executeQuery();
			while(rs.next()) {
				return rs.getDouble("amount");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}  
	@Override
	public boolean bookRestaurant(RestaurantBooking rb) {
		 boolean status = false;
	        try (Connection conn = DBConnection.getConnector()) {

	            String sql = "INSERT INTO restaurant_booking(user_id, restaurant_id, booking_date, num_people, status) "
	                       + "VALUES (?, ?, ?, ?, ?)";
	            
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setInt(1, rb.getUserId());
	            ps.setInt(2, rb.getRestaurantId());
	            ps.setDate(3, rb.getBookingDate());
	            ps.setInt(4, rb.getNumPeople());
	            ps.setString(5, rb.getStatus());

	            int rows = ps.executeUpdate();
	            status = rows > 0;

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return status;
	    }

}
