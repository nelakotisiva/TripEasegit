package Daopackage.com;

import dtopackage.com.RestaurantBooking;

public interface ResBookingDAO {
	double getLastBookingAmountRestaurent(int userId);
	 boolean bookRestaurant(RestaurantBooking rb);
}
