package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    public static Connection getConnection() {
        Connection con = null;
        try {
            String url = "jdbc:mysql://localhost:3306/programadores";
            String user = "root";
            String password = "";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexión a la base de datos establecida exitosamente.");
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: Driver JDBC de MySQL no encontrado. Asegúrate de tener el JAR en el classpath.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("ERROR: No se pudo conectar a la base de datos. Verifica la URL, usuario, contraseña y que MySQL esté corriendo.");
            System.err.println("Mensaje de error SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("ERROR INESPERADO al intentar conectar a la base de datos.");
            e.printStackTrace();
        }
        return con;
    }
}