package dtopackage.com;

import java.sql.Timestamp;

public class Bookingg {

    private int bookingId;
    private int userId;
    private int hotelId;
    private String checkin;
    private String checkout;
    private int guests;
    private double totalAmount;
    private Timestamp bookingDate;
    private String hotelName;
    private String hotelLocation;

    // ===== GETTERS =====
    public String getHotelName() {
        return hotelName;
    }

    public String getCheckin() {
        return checkin;
    }

    public String getCheckout() {
        return checkout;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

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

	public int getHotelId() {
		return hotelId;
	}

	public void setHotelId(int hotelId) {
		this.hotelId = hotelId;
	}

	public int getGuests() {
		return guests;
	}

	public void setGuests(int guests) {
		this.guests = guests;
	}

	public Timestamp getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(Timestamp bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getHotelLocation() {
		return hotelLocation;
	}

	public void setHotelLocation(String hotelLocation) {
		this.hotelLocation = hotelLocation;
	}

	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}

	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

}
