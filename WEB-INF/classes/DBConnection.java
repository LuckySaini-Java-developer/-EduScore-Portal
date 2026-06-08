import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                // रेंडर की सुरक्षित तिजोरी से क्रेडेंशियल्स उठाना
                String dbHost = System.getenv("DB_HOST");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASSWORD");

                String url = "jdbc:postgresql://" + dbHost + ":5432/neondb?sslmode=require";
                
                // PostgreSQL ड्राइवर लोड करना
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, dbUser, dbPass);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
