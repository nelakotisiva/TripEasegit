package Daopackage.com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utilpackage.com.DBConnection;

public class PackageDAO {
	public List<dtopackage.com.PackageDTO> getByDestination(String dest) {
		List<dtopackage.com.PackageDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM packages WHERE destination = ?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, dest);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					dtopackage.com.PackageDTO p = new dtopackage.com.PackageDTO();
					p.setId(rs.getInt("id"));
					p.setDestination(rs.getString("destination"));
					p.setTitle(rs.getString("title"));
					p.setDescription(rs.getString("description"));
					p.setDays(rs.getInt("days"));
					p.setPrice(rs.getDouble("price"));
					p.setDetails(rs.getString("details"));
					list.add(p);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public dtopackage.com.PackageDTO findById(int id) {
		String sql = "SELECT * FROM packages WHERE id=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					dtopackage.com.PackageDTO p = new dtopackage.com.PackageDTO();
					p.setId(rs.getInt("id"));
					p.setDestination(rs.getString("destination"));
					p.setTitle(rs.getString("title"));
					p.setDescription(rs.getString("description"));
					p.setDays(rs.getInt("days"));
					p.setPrice(rs.getDouble("price"));
					p.setDetails(rs.getString("details"));
					return p;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}