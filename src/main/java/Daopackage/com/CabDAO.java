package Daopackage.com;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dtopackage.com.Cab;
import utilpackage.com.DBConnection;

public class CabDAO {

    public List<Cab> getAllVehicles() {
        List<Cab> list = new ArrayList<>();
        try{
            Connection con = DBConnection.getConnector();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cab_rental");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(new Cab(
                    rs.getInt("rental_id"),
                    rs.getInt("destination_id"),
                    rs.getString("vehicle_type"),
                    rs.getString("model"),
                    rs.getDouble("price_per_day"),
                    rs.getString("availability")
                ));
            }
        }catch(Exception e){ e.printStackTrace(); }

        return list;
    }

    public List<Integer> getBookedVehicleIds() {
        List<Integer> booked = new ArrayList<>();
        try{
            Connection con = DBConnection.getConnector();
            PreparedStatement ps = con.prepareStatement(
                "SELECT rental_id FROM booking_details WHERE status='Booked'"
            );
            ResultSet rs = ps.executeQuery();
            while(rs.next()) booked.add(rs.getInt(1));
        }catch(Exception e){ e.printStackTrace();}
        return booked;
    }

    public boolean saveBooking(int userId,int rentalId,int passengers){
        try{
            Connection con = DBConnection.getConnector();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO booking_details(user_id,rental_id,passengers,status) VALUES (?,?,?, 'Booked')"
            );
            ps.setInt(1,userId);
            ps.setInt(2,rentalId);
            ps.setInt(3,passengers);

            return ps.executeUpdate() > 0;
        }catch(Exception e){ e.printStackTrace(); return false;}
    }

}
