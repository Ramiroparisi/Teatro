package com.teatro.data;

import com.teatro.modelo.Funcion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionDAO {

    public void add(Funcion f) throws SQLException {
        String sql = "INSERT INTO Funcion (Fecha, Hora, Precio, ObraID, SalaID) VALUES (?, ?, ?, ?, ?)";
        Connection cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDate(1, f.getFecha());
            ps.setTime(2, f.getHora());
            ps.setBigDecimal(3, f.getPrecio());
            
            if (f.getObraID() != null) ps.setInt(4, f.getObraID()); 
            else ps.setNull(4, Types.INTEGER);
            
            if (f.getSalaID() != null) ps.setInt(5, f.getSalaID()); 
            else ps.setNull(5, Types.INTEGER);
            
            ps.executeUpdate();
            
            ResultSet rsID = ps.getGeneratedKeys();
            if (rsID.next()) {
                f.setId(rsID.getInt(1));
            }
        } catch (SQLException e) {
            System.err.println("Error al insertar función: " + e.getMessage());
            throw e; // Excepción para que el Servlet sepa que falló
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }
    
    public void put(Funcion f) {
        String sql = "UPDATE Funcion SET Fecha=?, Hora=?, Precio=?, ObraID=?, SalaID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDate(1, f.getFecha());
            ps.setTime(2, f.getHora());
            ps.setBigDecimal(3, f.getPrecio());
            
            if (f.getObraID() != null) ps.setInt(4, f.getObraID());
            else ps.setNull(4, Types.INTEGER);
            
            if (f.getSalaID() != null) ps.setInt(5, f.getSalaID());
            else ps.setNull(5, Types.INTEGER);
            
            ps.setInt(6, f.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al actualizar función ID " + f.getId() + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }
    
    public List<Funcion> getAll() {
        List<Funcion> lista = new ArrayList<>();
        String sql = "SELECT * FROM Funcion";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearFuncion(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al listar funciones: " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }
    
    public Funcion getByID(int id) {
        return findByColumn("ID", id);
    }
    
    public void delete(int id) {
        String sql = "DELETE FROM Funcion WHERE ID = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al eliminar función ID " + id + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }
    
    private Funcion findByColumn(String columna, Object valor) {
        Funcion f = null;
        String sql = "SELECT * FROM Funcion WHERE " + columna + " = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setObject(1, valor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) f = mapearFuncion(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar función por " + columna + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return f;
    }

    private Funcion mapearFuncion(ResultSet rs) throws SQLException {
        Funcion f = new Funcion();
        try {
            f.setId(rs.getInt("ID"));
            f.setFecha(rs.getDate("Fecha"));
            f.setHora(rs.getTime("Hora"));
            f.setPrecio(rs.getBigDecimal("Precio"));    
              
            int idObra = rs.getInt("ObraID");
            f.setObraID(rs.wasNull() ? null : idObra);
            
            int idSala = rs.getInt("SalaID");
            f.setSalaID(rs.wasNull() ? null : idSala);
        } catch (SQLException e) {
            System.err.println("Error en el mapeo de Funcion: " + e.getMessage());
            throw e;
        }
        return f;
    }
}