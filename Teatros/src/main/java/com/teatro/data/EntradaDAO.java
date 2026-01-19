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
        String sqlEntrada = "INSERT INTO entrada (FuncionID, AsientoID, ClienteID, estado) VALUES (?, ?, ?, ?)";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try {
            cn.setAutoCommit(false);
            try (PreparedStatement psE = cn.prepareStatement(sqlEntrada)) {
                psE.setInt(1, e.getFuncionID());
                psE.setInt(2, e.getAsientoID());
                psE.setInt(3, e.getClienteID());
                psE.setString(4, e.getEstado() != null ? e.getEstado().name() : "Pagada"); 
                psE.executeUpdate();
            }
            cn.commit();
            System.out.println("Entrada registrada con éxito.");
        } catch (SQLException ex) {
            if (cn != null) cn.rollback();
            throw ex;
        } finally {
            if (cn != null) cn.setAutoCommit(true);
            DbConnector.getInstancia().releaseConn();
        }
    }


    public List<Entrada> getEntradasDetalladasPorUsuario(int usuarioId) throws SQLException {
        List<Entrada> lista = new ArrayList<>();
        String sql = "SELECT e.ID, e.Estado, e.AsientoID, e.FuncionID, " +
                     "f.fecha, f.hora, o.nombre AS nombre_obra, " + 
                     "a.fila_nombre, a.Numero AS asiento_num " +
                     "FROM entrada e " +
                     "JOIN funcion f ON e.FuncionID = f.ID " +
                     "JOIN obra o ON f.ObraID = o.ID " +
                     "JOIN asiento a ON e.AsientoID = a.ID " +
                     "WHERE e.ClienteID = ? " +
                     "ORDER BY f.fecha DESC, f.hora DESC";

        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            
            ps.setInt(1, usuarioId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Entrada e = new Entrada();
                    e.setId(rs.getInt("ID"));
                    String estadoStr = rs.getString("Estado");
                    if (estadoStr != null) {
                        e.setEstado(EstadoEntrada.valueOf(estadoStr));
                    }

                    e.setAsientoID(rs.getInt("AsientoID"));
                    e.setFuncionID(rs.getInt("FuncionID"));
                    e.setNombreObra(rs.getString("nombre_obra"));
                    e.setFecha(rs.getDate("fecha"));
                    e.setHora(rs.getTime("hora"));
                    e.setFilaNombre(rs.getString("fila_nombre"));
                    e.setAsientoNum(rs.getInt("asiento_num"));
                    
                    lista.add(e);
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }
}