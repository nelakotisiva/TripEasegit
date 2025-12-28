package dtopackage.com;

import java.util.Date;

/**
 * UI DTO for "My Bookings" page
 * Represents ONE booking card shown to the user
 */
public class UserBooking {

    // 🔹 Unique booking id (used for cancel / details)
    private int bookingId;

    // 🔹 Icon shown in UI (🏨 🚕 ✈ 🍽)
    private String icon;

    // 🔹 Booking type
    // HOTEL / FLIGHT / CAB / RESTAURANT
    private String bookingType;

    // 🔹 Main title shown in UI
    private String title;

    // 🔹 Subtitle under title
    private String subtitle;

    // 🔹 When booking was made
    private Date bookingDate;

    // 🔹 Travel / usage date (optional)
    private Date travelDate;

    // 🔹 Amount paid
    private double amount;

    // 🔹 Status (Confirmed / Cancelled / Pending)
    private String status;

    // 🔹 URL to open booking details page
    private String detailsUrl;

    // -----------------------------
    // Constructors
    // -----------------------------
    public UserBooking() {}

    public UserBooking(int bookingId,
                       String icon,
                       String bookingType,
                       String title,
                       String subtitle,
                       Date bookingDate,
                       Date travelDate,
                       double amount,
                       String status,
                       String detailsUrl) {

        this.bookingId = bookingId;
        this.icon = icon;
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

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

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
    
    private String serviceType; // HOTEL / FLIGHT / CAB / RESTAURANT

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

}
