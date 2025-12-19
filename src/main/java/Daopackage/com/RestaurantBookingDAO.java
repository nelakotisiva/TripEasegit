package Daopackage.com;

import java.util.List;

import dtopackage.com.RestaurantBooking;

public interface RestaurantBookingDAO {

    boolean bookRestaurant(RestaurantBooking rb);

    // 🔹 NEW → also save into main booking table
    boolean bookRestaurantAndMainBooking(RestaurantBooking rb);
    
    List<RestaurantBooking> getBookingsByUserId(int userId);
}
