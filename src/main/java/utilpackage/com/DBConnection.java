package utilpackage.com;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnector() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/tripease?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "sql@123"
            );

        } catch (Exception e) {
            System.out.println("❌ DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }

        return con;  // If null → DAO must stop further execution
    }
}
