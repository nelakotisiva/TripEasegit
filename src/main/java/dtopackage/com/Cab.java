package dtopackage.com;

public class Cab {
    private int rentalId;
    private int destinationId;
    private String vehicleType;
    private String model;
    private double pricePerDay;
    private String availability;

    public Cab(int rentalId, int destinationId, String vehicleType, String model,
                     double pricePerDay, String availability) {
        this.rentalId = rentalId;
        this.destinationId = destinationId;
        this.vehicleType = vehicleType;
        this.model = model;
        this.pricePerDay = pricePerDay;
        this.availability = availability;
    }

    // Getters
    public int getRentalId() { return rentalId; }
    public int getDestinationId() { return destinationId; }
    public String getVehicleType() { return vehicleType; }
    public String getModel() { return model; }
    public double getPricePerDay() { return pricePerDay; }
    public String getAvailability() { return availability; }

    // Setter for availability
    public void setAvailability(String availability) {
        this.availability = availability;
    }
}
