package dtopackage.com;

import java.util.Date;

/**
 * UI DTO for "My Bookings" page
 * Represents ONE booking card shown to the user
 */
public class UserBooking {

    // 🔹 Booking type
    // HOTEL / FLIGHT / CAB / RESTAURANT / TOUR / PLACE
    private String bookingType;

    // 🔹 Main title shown in UI
    // Hotel Name / Flight Route / Cab Model / Restaurant Name
    private String title;

    // 🔹 Subtitle under title
    // Location / Route / Short description
    private String subtitle;

    // 🔹 When booking was made
    private Date bookingDate;

    // 🔹 Travel / usage date
    private Date travelDate;

    // 🔹 Amount paid (0 if free / NA)
    private double amount;

    // 🔹 Status (Confirmed / Cancelled / Pending)
    private String status;

    // 🔹 URL to open booking details page
    private String detailsUrl;

    // -----------------------------
    // Constructors
    // -----------------------------

    public UserBooking() {}

    public UserBooking(String bookingType,
                       String title,
                       String subtitle,
                       Date bookingDate,
                       Date travelDate,
                       double amount,
                       String status,
                       String detailsUrl) {

        this.bookingType = bookingType;
        this.title = title;
        this.subtitle = subtitle;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.amount = amount;
        this.status = status;
        this.detailsUrl = detailsUrl;
    }

    // -----------------------------
    // Getters & Setters
    // -----------------------------

    public String getBookingType() {
        return bookingType;
    }

    public void setBookingType(String bookingType) {
        this.bookingType = bookingType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDetailsUrl() {
        return detailsUrl;
    }

    public void setDetailsUrl(String detailsUrl) {
        this.detailsUrl = detailsUrl;
    }
}
