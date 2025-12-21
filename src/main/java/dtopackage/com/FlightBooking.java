package dtopackage.com;

import java.sql.Date;

public class FlightBooking {

    private int bookingId;
    private String airline;
    private String source;
    private String destination;
    private Date travelDate;
    private int seats;
    private double price;

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getAirline() { return airline; }
    public void setAirline(String airline) { this.airline = airline; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public Date getTravelDate() { return travelDate; }
    public void setTravelDate(Date travelDate) { this.travelDate = travelDate; }

    public int getSeats() { return seats; }
    public void setSeats(int seats) { this.seats = seats; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
