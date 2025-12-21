package dtopackage.com;

import java.util.Date;

public class Booking {

    private int bookingId;
    private int userId;
    private int destinationId;
    private Date bookingDate;
    private Date travelDate;
    private String status;
    private int numOfPeople;

    // 🔹 VERY IMPORTANT
    // RESTAURANT / TOUR / PLACE / CAB / HOTEL
    private String serviceType;

    // -------------------------
    // Constructors
    // -------------------------
    public Booking() {}

    public Booking(int bookingId,
                   int userId,
                   int destinationId,
                   Date bookingDate,
                   Date travelDate,
                   String status,
                   int numOfPeople,
                   String serviceType) {

        this.bookingId = bookingId;
        this.userId = userId;
        this.destinationId = destinationId;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.status = status;
        this.numOfPeople = numOfPeople;
        this.serviceType = serviceType;
    }

    // -------------------------
    // Getters & Setters
    // -------------------------
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

    public int getDestinationId() {
        return destinationId;
    }
    public void setDestinationId(int destinationId) {
        this.destinationId = destinationId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Date getTravelDate() {
        return travelDate;
    }
    public void setTravelDate(Date travelDate) {
        this.travelDate = travelDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumOfPeople() {
        return numOfPeople;
    }
    public void setNumOfPeople(int numOfPeople) {
        this.numOfPeople = numOfPeople;
    }

    public String getServiceType() {
        return serviceType;
    }
    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
}
