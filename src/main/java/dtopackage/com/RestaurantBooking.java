package dtopackage.com;

import java.sql.Timestamp;

public class RestaurantBooking {

    private int bookingId;
    private int userId;
    private int restaurantId;
    private Timestamp bookingDate1;   // ✅ ONLY THIS
    private int numPeople;
    private String status;

    public int getBookingId() {
        return bookingId;
    }
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Timestamp getBookingDate1() {
        return bookingDate1;
    }
    public void setBookingDate1(Timestamp bookingDate1) {
        this.bookingDate1 = bookingDate1;
    }

    public int getNumPeople() {
        return numPeople;
    }
    public void setNumPeople(int numPeople) {
        this.numPeople = numPeople;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
