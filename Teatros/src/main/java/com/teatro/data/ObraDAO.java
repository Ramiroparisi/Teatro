package com.teatro.data;

import com.teatro.modelo.Obra;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObraDAO {

    public void add(Obra o) throws SQLException {
        Connection cn = null;
        String sql = "INSERT INTO Obra (Nombre, Descripcion, Duracion, Foto, EmpleadoID) VALUES (?, ?, ?, ?, ?)";
        cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, o.getNombre());
            ps.setString(2, o.getDescripcion());
            ps.setInt(3, o.getDuracion());
            ps.setBinaryStream(4, o.getFoto()); 
            
            if (o.getEmpleadoID() != null) {
                ps.setInt(5, o.getEmpleadoID());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            
            ps.executeUpdate();
            
            ResultSet rsID = ps.getGeneratedKeys();
            if (rsID.next()) {
                o.setId(rsID.getInt(1));
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public void put(Obra o) {
        String sql = "UPDATE Obra SET Nombre=?, Descripcion=?, Duracion=?, Foto=?, EmpleadoID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, o.getNombre());
            ps.setString(2, o.getDescripcion());
            ps.setInt(3, o.getDuracion());
            ps.setBinaryStream(4, o.getFoto());
            
            if (o.getEmpleadoID() != null) {
                ps.setInt(5, o.getEmpleadoID());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            
            ps.setInt(6, o.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    private Obra mapearObra(ResultSet rs) throws SQLException {
        Obra o = new Obra();
        o.setId(rs.getInt("ID"));
        o.setNombre(rs.getString("Nombre"));
        o.setDescripcion(rs.getString("Descripcion"));
        o.setDuracion(rs.getInt("Duracion"));
        o.setFoto(rs.getBinaryStream("Foto"));
        
        int idEmp = rs.getInt("EmpleadoID");
        if (rs.wasNull()) {
            o.setEmpleadoID(null);
        } else {
            o.setEmpleadoID(idEmp);
        }
        
        return o;
    }

    public List<Obra> getAll() {
        List<Obra> lista = new ArrayList<>();
        String sql = "SELECT * FROM Obra";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearObra(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }

    public Obra getByID(int id) {
        return findByColumn("ID", id);
    }

    public Obra getByNombre(String user) {
        return findByColumn("Nombre", user);
    }

    public List<Obra> getByTeatro(int idTeatro) {
        List<Obra> lista = new ArrayList<>();
        String sql = "SELECT o.* FROM Obra o " +
                     "INNER JOIN Usuario u ON o.EmpleadoID = u.ID " +
                     "WHERE u.TeatroID = ?";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTeatro);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Reutilizamos tu mapeo para llenar la lista
                    lista.add(mapearObra(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }
    
    public void delete(int id) {
        String sql = "DELETE FROM Obra WHERE ID = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    private Obra findByColumn(String columna, Object valor) {
        Obra o = null;
        String sql = "SELECT * FROM Obra WHERE " + columna + " = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setObject(1, valor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) o = mapearObra(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return o;
    }
}