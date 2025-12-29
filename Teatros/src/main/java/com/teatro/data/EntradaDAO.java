package com.teatro.data;

import com.teatro.modelo.Entrada;
import com.teatro.modelo.EstadoEntrada;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EntradaDAO {

    public List<Entrada> getAllByFuncion(int idFuncion) {
        List<Entrada> lista = new ArrayList<>();
        String sql = "SELECT * FROM Entrada WHERE FuncionID = ? ORDER BY AsientoID";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idFuncion);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearEntrada(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al recuperar entradas de la función " + idFuncion + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }

    public Entrada getById(int idEntrada) {
        Entrada e = null;
        String sql = "SELECT * FROM Entrada WHERE ID = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idEntrada);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    e = mapearEntrada(rs);
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al buscar la entrada con ID " + idEntrada + ": " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return e;
    }

    private Entrada mapearEntrada(ResultSet rs) throws SQLException {
        Entrada e = new Entrada();
        e.setId(rs.getInt("ID"));
        
        String estadoDB = rs.getString("Estado");
        if (estadoDB != null) {
            try {
                e.setEstado(EstadoEntrada.valueOf(estadoDB)); 
            } catch (IllegalArgumentException ex) {
                // Si texto en la bdd no coincide con el Enum, esto hace que la app no explote
                System.err.println("Advertencia: El estado '" + estadoDB + "' no existe en el Enum EstadoEntrada.");
                e.setEstado(null); 
            }
        }
        
        int clienteId = rs.getInt("ClienteID");
        e.setClienteID(rs.wasNull() ? 0 : clienteId);
        
        e.setFuncionID(rs.getInt("FuncionID"));
        e.setAsientoID(rs.getInt("AsientoID"));
        
        return e;
    }
}