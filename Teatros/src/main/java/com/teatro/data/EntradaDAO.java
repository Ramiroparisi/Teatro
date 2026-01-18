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
    

    public void registrarCompra(Entrada e) throws SQLException {
        String sql = "INSERT INTO entrada (FuncionID, AsientoID, UsuarioID, estado) VALUES (?, ?, ?, ?)";
        Connection cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, e.getFuncionID());
            ps.setInt(2, e.getAsientoID());
            ps.setInt(3, e.getClienteID());
            ps.setString(4, "Pagada"); 
            
            ps.executeUpdate();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }


    public List<Entrada> getEntradasPorUsuario(int usuarioId) throws SQLException {
        List<Entrada> lista = new ArrayList<>();
        String sql = "SELECT * FROM entrada WHERE UsuarioID = ? ORDER BY ID DESC";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Entrada e = new Entrada();
                    e.setId(rs.getInt("ID"));
                    e.setFuncionID(rs.getInt("FuncionID"));
                    e.setAsientoID(rs.getInt("AsientoID"));
                    String estadoBD = rs.getString("estado"); 
                    if (estadoBD != null) {
                        e.setEstado(EstadoEntrada.valueOf(estadoBD.toUpperCase()));
                    }
                    
                    lista.add(e);
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }
}