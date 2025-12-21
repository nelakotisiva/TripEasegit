package UserDaopackage.com;

import java.util.List;
import dtopackage.com.Hotel;

public interface HotelDAO {

    List<Hotel> getHotelsByLocation(String location);

    Hotel getHotelById(int hotelId);

    List<Hotel> getAllHotels();

    boolean addHotel(Hotel h);

    boolean updateHotel(Hotel h);

    boolean deleteHotel(int hotelId);

    List<Hotel> searchHotelsByCity(String cityName);
}
