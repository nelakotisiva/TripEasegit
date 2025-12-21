package dtopackage.com;

public class Cab {
    private int rentalId;
    private String seaterType;
    private String model;
    private double pricePerDay;
    private String availability;
    private String location;
    private String imageUrl;

    public String getImageUrl() {return imageUrl;}
    public void setImageUrl(String imageUrl) {this.imageUrl = imageUrl;}

    public int getRentalId() { return rentalId; }
    public void setRentalId(int rentalId) { this.rentalId = rentalId; }

    public String getSeaterType() { return seaterType; }
    public void setSeaterType(String seaterType) { this.seaterType = seaterType; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
	private String status;
	
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	private int bookingId;

	public int getBookingId() {
	    return bookingId;
	}

	public void setBookingId(int bookingId) {
	    this.bookingId = bookingId;
	}

}