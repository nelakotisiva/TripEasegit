package utilpackage.com;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://localhost:3306/tripease" +
        "?useSSL=false&allowPublicKeyRetrieval=true" +
        "&serverTimezone=Asia/Kolkata";

    private static final String USER = "root";

    private static final String PASS = "viswash";


    public static Connection getConnector() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);

        } catch (Exception e) {
            System.out.println("❌ DATABASE CONNECTION FAILED – CHECK MYSQL SERVER");
            e.printStackTrace();
            return null;
        }
    }
}
