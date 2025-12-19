package Daopackage.com;

import java.util.List;
import dtopackage.com.Restaurant;

public interface RestaurantDAO {
    List<Restaurant> getAllRestaurants();
    Restaurant getRestaurantById(int id);
    boolean addRestaurant(Restaurant r);
    boolean updateRestaurant(Restaurant r);
    boolean deleteRestaurant(int id);
	List<Restaurant> getRestaurantsByMaxPrice(double budget);
	public String[] getRestaurantNameAndLocationById(int restaurantId);

}
