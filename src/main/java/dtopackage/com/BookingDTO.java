package dtopackage.com;

import java.sql.Date;

public class BookingDTO {

    private int id;              // booking_id
    private int userId;          // user_id
    private int destinationId;   // destination_id
    private int travellers;      // num_of_people
    private Date travelDate;     // travel_date

    // UI only
    private String email;
    private String fromLocation;
    private String toLocation;

    // ===== getters & setters =====

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDestinationId() {
        return destinationId;
    }
    public void setDestinationId(int destinationId) {
        this.destinationId = destinationId;
    }

    public int getTravellers() {
        return travellers;
    }
    public void setTravellers(int travellers) {
        this.travellers = travellers;
    }

    public Date getTravelDate() {
        return travelDate;
    }
    public void setTravelDate(Date travelDate) {
        this.travelDate = travelDate;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getFromLocation() {
        return fromLocation;
    }
    public void setFromLocation(String fromLocation) {
        this.fromLocation = fromLocation;
    }

    public String getToLocation() {
        return toLocation;
    }
    public void setToLocation(String toLocation) {
        this.toLocation = toLocation;
    }
}
