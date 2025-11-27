package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dtopackage.com.Restaurant;
import utilpackage.com.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

	@Override
	public List<Restaurant> getAllRestautaurants() {
		List<Restaurant> lst=new ArrayList<Restaurant>();
		Connection con =DBConnection.getConnector();
        String sql = "SELECT * FROM restaurant";
        Restaurant r=null;
		try {
			PreparedStatement psmt=con.prepareStatement(sql);
			ResultSet rs=psmt.executeQuery();
			while(rs.next()) {
				 r=new Restaurant();
				 r.setRestaurantId(rs.getInt("restaurant_id"));
	                r.setDestinationId(rs.getInt("destination_id"));
	                r.setName(rs.getString("name"));
	                r.setType(rs.getString("type"));
	                r.setRating(rs.getDouble("rating"));
	                r.setContact(rs.getLong("contact"));
	                r.setLatitude(rs.getDouble("latitude"));
	                r.setLongitude(rs.getDouble("longitude"));

	                lst.add(r);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

}
