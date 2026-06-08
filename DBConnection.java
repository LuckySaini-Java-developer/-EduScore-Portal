import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                // क्लाउड एनवायरनमेंट या डिफ़ॉल्ट Neon क्रेडेंशियल्स उठाना
                String dbHost = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "ep-shiny-cell-aqt8ekq0.us-east-1.aws.neon.tech";
                String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "neondb_owner";
                String dbPass = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "npg_Gtightwla4brC6@ep";

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
