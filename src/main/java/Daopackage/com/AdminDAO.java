package Daopackage.com;

import java.sql.*;

import dtopackage.com.Admin;
import utilpackage.com.DBConnection;

public class AdminDAO {

    public Admin adminLogin(String uname, String pass) {
        Admin admin = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin WHERE username=? AND password=?");
            ps.setString(1, uname);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }

    // Dashboard Counts
    public int count(String table) {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM " + table);
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
