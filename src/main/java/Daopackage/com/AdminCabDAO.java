package Daopackage.com;

import java.sql.*;
import java.util.*;
import dtopackage.com.Cab;
import jakarta.servlet.http.HttpServletRequest;
import utilpackage.com.DBConnection;

public class AdminCabDAO {

    Connection con = DBConnection.getConnection();

    public List<Cab> getAllCabs() {
        List<Cab> list = new ArrayList<>();

        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT c.*, d.location FROM cab_rental c JOIN cab_destination d ON c.destination_id=d.destination_id"
            );

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cab c = new Cab();
                c.setRentalId(rs.getInt("rental_id"));
                c.setModel(rs.getString("model"));
                c.setSeaterType(rs.getString("seater_type"));
                c.setPricePerDay(rs.getDouble("price_per_day"));
                c.setAvailability(rs.getString("availability"));
                c.setLocation(rs.getString("location"));
                c.setImageUrl(rs.getString("image_url"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
//
    public void addCab(HttpServletRequest req) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO cab_rental(seater_type,model,price_per_day,availability,destination_id,image_url) VALUES (?,?,?,?,?,?)"
            );

            ps.setString(1, req.getParameter("seater"));
            ps.setString(2, req.getParameter("model"));
            ps.setDouble(3, Double.parseDouble(req.getParameter("price")));
            ps.setString(4, "Available");
            ps.setInt(5, Integer.parseInt(req.getParameter("destination")));
            ps.setString(6, req.getParameter("image"));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCab(int id) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM cab_rental WHERE rental_id=?"
            );
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}