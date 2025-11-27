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
	Connection con=null;
	public RestaurantDAOImpl() {
		 con=DBConnection.getConnector();
	}
	
	private Restaurant maprow(ResultSet rs) {
		Restaurant r =null;
		try {
			r=new Restaurant();
			r.setRestaurantId(rs.getInt("restaurant_id"));
			r.setLatitude(rs.getInt("destination_id"));
	        r.setName(rs.getString("name"));
	        r.setType(rs.getString("type"));
	        r.setRating(rs.getDouble("rating"));
	        r.setContact(rs.getString("contact"));
	        r.setAvgPrice(rs.getDouble("avg_price"));
	        r.setLatitude(rs.getDouble("latitude"));
	        r.setLongitude(rs.getDouble("longitude"));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return r;
	}
	
	@Override
	public List<Restaurant> getRestaurantsByMaxPrice(double budget) {
		List<Restaurant> list=new ArrayList<Restaurant>();
		String sql="select*from restaurant where avg_price<=?";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setDouble(1, budget);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				list.add(maprow(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Restaurant> getAllRestaurants() {
		List<Restaurant> list=new ArrayList<Restaurant>();
        String sql = "SELECT * FROM restaurant";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(maprow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

	}

	@Override
	public boolean addRestaurant(Restaurant r) {
		String sql="insert into restaurant values(?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, r.getRestaurantId());
			ps.setInt(2, r.getDestinationId());
			ps.setString(3, r.getName());
			ps.setString(4, r.getType());
			ps.setDouble(5, r.getRating());
			ps.setString(6, r.getContact());
			ps.setDouble(7, r.getAvgPrice());
			ps.setDouble(8, r.getLatitude());
			ps.setDouble(9, r.getLongitude());
			return ps.executeUpdate()==1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateRestaurant(Restaurant r) {
		String sql="update restaurant set destination_id=?, name=?, type=?, rating=?, contact=?, avg_price=?, latitude=?, longitude=? " + "WHERE restaurant_id=?";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
            ps.setInt(1, r.getDestinationId());
            ps.setString(2, r.getName());
            ps.setString(3, r.getType());
            ps.setDouble(4, r.getRating());
            ps.setString(5, r.getContact());
            ps.setDouble(6, r.getAvgPrice());
            ps.setDouble(7, r.getLatitude());
            ps.setDouble(8, r.getLongitude());
            ps.setInt(9, r.getRestaurantId());
            
            return ps.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteRestaurant(int id) {
		String sql="delete from restaurant where restaurant_id=?";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			return ps.executeUpdate()==1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Restaurant getRestaurantById(int id) {
		String sql="select *from restaurant WHERE restaurant_id=?";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return maprow(rs);
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
