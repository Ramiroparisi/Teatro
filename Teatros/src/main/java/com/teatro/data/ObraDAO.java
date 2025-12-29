package com.teatro.data;

import com.teatro.modelo.Obra;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObraDAO {

    public void add(Obra o) throws SQLException {
        String sql = "INSERT INTO Obra (Nombre, Descripcion, Duracion, Foto, EmpleadoID) VALUES (?, ?, ?, ?, ?)";
        Connection cn = DbConnector.getInstancia().getConn();
        
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
        } catch (SQLException e) {
            System.err.println("Error al insertar obra '" + o.getNombre() + "': " + e.getMessage());
            throw e; // Lanzo otra ves la excepción para que el Servlet pueda manejarla
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
            System.err.println("Error al actualizar obra ID " + o.getId() + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public List<Obra> getAll() {
        List<Obra> lista = new ArrayList<>();
        String sql = "SELECT * FROM Obra";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearObra(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener todas las obras: " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }

    public Obra getByID(int id) {
        return findByColumn("ID", id);
    }

    public Obra getByNombre(String nombre) {
        return findByColumn("Nombre", nombre);
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
                    lista.add(mapearObra(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar obras del teatro ID " + idTeatro + ": " + e.getMessage());
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
            System.err.println("Error al eliminar obra ID " + id + ": " + e.getMessage());
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
            System.err.println("Error al buscar obra por " + columna + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return o;
    }

    private Obra mapearObra(ResultSet rs) throws SQLException {
        Obra o = new Obra();
        try {
            o.setId(rs.getInt("ID"));
            o.setNombre(rs.getString("Nombre"));
            o.setDescripcion(rs.getString("Descripcion"));
            o.setDuracion(rs.getInt("Duracion"));
            o.setFoto(rs.getBinaryStream("Foto"));
            
            int idEmp = rs.getInt("EmpleadoID");
            o.setEmpleadoID(rs.wasNull() ? null : idEmp);
            
        } catch (SQLException e) {
            System.err.println("Error en mapeo de Obra: " + e.getMessage());
            throw e;
        }
        return o;
    }
}