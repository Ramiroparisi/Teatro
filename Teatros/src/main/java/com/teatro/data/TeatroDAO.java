package com.teatro.data;

import com.teatro.modelo.Teatro;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeatroDAO {

    public List<Teatro> getAll() throws SQLException {
        List<Teatro> teatros = new ArrayList<>();
        String sql = "SELECT ID, Nombre FROM Teatro";
        
        Connection cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Teatro t = new Teatro();
                t.setId(rs.getInt("ID"));
                t.setNombre(rs.getString("Nombre"));
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
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return t;
    }
}