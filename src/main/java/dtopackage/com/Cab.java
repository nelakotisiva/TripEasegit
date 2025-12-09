package dtopackage.com;

public class Cab {
    private int rentalId;
    private String model;
    private String seaterType;
    private double pricePerDay;
    private String availability;
    private String location;
    private String imageUrl;
    private int destinationId;

    public int getRentalId() {
        return rentalId;
    }
    public void setRentalId(int rentalId) {
        this.rentalId = rentalId;
    }

    public String getModel() {
        return model;
    }
    public void setModel(String model) {
        this.model = model;
    }

    public String getSeaterType() {
        return seaterType;
    }
    public void setSeaterType(String seaterType) {
        this.seaterType = seaterType;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }
    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public String getAvailability() {
        return availability;
    }
    public void setAvailability(String availability) {
        this.availability = availability;
    }

    // This is from destination table
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getDestinationId() {
        return destinationId;
    }
    public void setDestinationId(int destinationId) {
        this.destinationId = destinationId;
    }
}
