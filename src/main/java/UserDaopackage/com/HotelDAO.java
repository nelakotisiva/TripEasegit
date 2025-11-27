package UserDaopackage.com;

import java.util.List;

import dtopackage.com.Hotel;

public interface HotelDAO {
    List<Hotel> getAllHotels();
    List<Hotel> getHotelsByLocation(String location);
}

