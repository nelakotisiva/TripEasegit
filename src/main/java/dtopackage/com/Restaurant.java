package dtopackage.com;

public class Restaurant {
    private int restaurantId;
    private int destinationId;
    private String name;
    private String type;
    private double rating;
    private String contact;
    private double avgPrice;
    private double latitude;
    private double longitude;
    private String imageUrl;  // ✅ NEW

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public double getAvgPrice() { return avgPrice; }
    public void setAvgPrice(double avgPrice) { this.avgPrice = avgPrice; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public String getImageUrl() { return imageUrl; }  // ✅ GET
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; } // ✅ SET
}
