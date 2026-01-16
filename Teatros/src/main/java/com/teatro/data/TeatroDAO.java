package com.teatro.data;

import com.teatro.modelo.Teatro;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeatroDAO {
	
	public void add(Teatro t) throws SQLException {
	    String sql = "INSERT INTO teatro (Nombre, Direccion, Pais, Ciudad, capacidad) VALUES (?, ?, ?, ?, ?)";
	    Connection cn = DbConnector.getInstancia().getConn();
	    
	    try (PreparedStatement ps = cn.prepareStatement(sql)) {
	        ps.setString(1, t.getNombre());
	        ps.setString(2, t.getDireccion());
	        ps.setString(3, t.getPais());
	        ps.setString(4, t.getCiudad());
	        ps.setInt(5, t.getCapacidad());
	        
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        System.err.println("Error al insertar teatro: " + e.getMessage());
	        throw e;
	    } finally {
	        DbConnector.getInstancia().releaseConn();
	    }
	}

	public List<Teatro> getAll() throws SQLException {
	    List<Teatro> teatros = new ArrayList<>();
	    String sql = "SELECT ID, Nombre, Direccion, Pais, Ciudad, capacidad FROM teatro";
	    
	    Connection cn = DbConnector.getInstancia().getConn();
	    
	    try (PreparedStatement ps = cn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        
	        while (rs.next()) {
	            Teatro t = new Teatro();
	            t.setId(rs.getInt("ID"));
	            t.setNombre(rs.getString("Nombre"));
	            t.setDireccion(rs.getString("Direccion"));
	            t.setPais(rs.getString("Pais"));
	            t.setCiudad(rs.getString("Ciudad"));
	            t.setCapacidad(rs.getInt("capacidad"));
	            teatros.add(t);
	        }
	    } catch (SQLException e) {
	        System.err.println("Error al obtener la lista de teatros: " + e.getMessage());
	        throw e;
	    } finally {
	        DbConnector.getInstancia().releaseConn();
	    }
	    return teatros;
	}


    public Teatro getById(int id) throws SQLException {
        Teatro t = null;
        String sql = "SELECT * FROM Teatro WHERE ID = ?";
        
        Connection cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    t = new Teatro();
                    t.setId(rs.getInt("ID"));
                    t.setNombre(rs.getString("Nombre"));
                    t.setDireccion(rs.getString("Direccion"));
                    t.setCapacidad(rs.getInt("capacidad"));
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return t;
    }
}