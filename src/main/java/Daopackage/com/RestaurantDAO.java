package Daopackage.com;

import java.util.List;

import dtopackage.com.Restaurant;

public interface RestaurantDAO {
	
	// For user module	
    List<Restaurant> getRestaurantsByMaxPrice(double budget);
    List<Restaurant> getAllRestaurants();
    
    
    // For admin module
    boolean addRestaurant(Restaurant r);
    boolean updateRestaurant(Restaurant r);
    boolean deleteRestaurant(int id);
    Restaurant getRestaurantById(int id);

}
