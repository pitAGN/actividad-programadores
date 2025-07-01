package dao;

import modelo.Programador;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgramadorDAO {

    public List<Programador> listarTodos() throws Exception {
        List<Programador> lista = new ArrayList<>();
        String sql = "SELECT id_programador, nombre, lenguajeD, lenguajeC, estudiante, password FROM tblprogramadores";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Programador p = new Programador();
                p.setId(rs.getInt("id_programador"));
                p.setNombre(rs.getString("nombre"));
                p.setLenguajeD(rs.getString("lenguajeD"));
                p.setLenguajeC(rs.getInt("lenguajeC"));
                p.setEstudiante(rs.getInt("estudiante"));
                p.setPassword(rs.getString("password"));
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Programador obtenerPorId(int id) throws Exception {
        Programador p = null;
        String sql = "SELECT id_programador, nombre, lenguajeD, lenguajeC, estudiante, password FROM tblprogramadores WHERE id_programador = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Programador();
                    p.setId(rs.getInt("id_programador"));
                    p.setNombre(rs.getString("nombre"));
                    p.setLenguajeD(rs.getString("lenguajeD"));
                    p.setLenguajeC(rs.getInt("lenguajeC"));
                    p.setEstudiante(rs.getInt("estudiante"));
                    p.setPassword(rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public void insertar(Programador p) throws Exception {
        String sql = "INSERT INTO tblprogramadores (nombre, lenguajeD, lenguajeC, password, estudiante) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getLenguajeD());
            ps.setInt(3, p.getLenguajeC());
            ps.setString(4, p.getPassword());
            ps.setInt(5, p.getEstudiante());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void actualizar(Programador p) throws Exception {
        String sql = "UPDATE tblprogramadores SET nombre=?, lenguajeD=?, lenguajeC=?, password=?, estudiante=? WHERE id_programador=?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getLenguajeD());
            ps.setInt(3, p.getLenguajeC());
            ps.setString(4, p.getPassword());
            ps.setInt(5, p.getEstudiante());
            ps.setInt(6, p.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM tblprogramadores WHERE id_programador=?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Programador validarLogin(String nombre, String password) throws Exception {
        Programador p = null;
        String sql = "SELECT id_programador, nombre, lenguajeD, lenguajeC, estudiante, password FROM tblprogramadores WHERE nombre=? AND password=?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, password);

            System.out.println("DEBUG: Intentando login con Nombre: '" + nombre + "' y Password: '" + password + "'");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Programador();
                    p.setId(rs.getInt("id_programador"));
                    p.setNombre(rs.getString("nombre"));
                    p.setLenguajeD(rs.getString("lenguajeD"));
                    p.setLenguajeC(rs.getInt("lenguajeC"));
                    p.setEstudiante(rs.getInt("estudiante"));
                    p.setPassword(rs.getString("password"));
                    System.out.println("DEBUG: Login exitoso para el usuario: " + p.getNombre());
                } else {
                    System.out.println("DEBUG: Credenciales inválidas para Nombre: '" + nombre + "'");
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR SQL en validarLogin: " + e.getMessage());
            e.printStackTrace();
        }
        return p;
    }
}