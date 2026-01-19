package com.teatro.data;

import com.teatro.modelo.Funcion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionDAO {

	public void add(Funcion f) throws SQLException {
	    String sql = "INSERT INTO funcion (Fecha, Hora, Precio, ObraID, TeatroID) VALUES (?, ?, ?, ?, ?)";
	    Connection cn = DbConnector.getInstancia().getConn();
	    
	    try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	        ps.setDate(1, f.getFecha());
	        ps.setTime(2, f.getHora());
	        ps.setBigDecimal(3, f.getPrecio());
	        ps.setInt(4, f.getObraID());
	        ps.setInt(5, f.getTeatroID());
	        
	        ps.executeUpdate();
	        
	        try (ResultSet rs = ps.getGeneratedKeys()) {
	            if (rs.next()) f.setId(rs.getInt(1));
	        }
	    } finally {
	        DbConnector.getInstancia().releaseConn();
	    }
	}
    
    public void put(Funcion f) {
        String sql = "UPDATE Funcion SET Fecha=?, Hora=?, Precio=?, ObraID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDate(1, f.getFecha());
            ps.setTime(2, f.getHora());
            ps.setBigDecimal(3, f.getPrecio());
            
            if (f.getObraID() != null) ps.setInt(4, f.getObraID());
            else ps.setNull(4, Types.INTEGER);
            
            ps.setInt(5, f.getId());
            
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
    
    public boolean tieneEntradasVendidas(int funcionId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM entrada WHERE FuncionID = ?";
        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, funcionId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM funcion WHERE ID = ?";
        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
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

            // AÑADIR ESTO:
            int idTeatro = rs.getInt("TeatroID");
            f.setTeatroID(rs.wasNull() ? null : idTeatro);

        } catch (SQLException e) {
            System.err.println("Error en el mapeo de Funcion: " + e.getMessage());
            throw e;
        }
        return f;
    }
}