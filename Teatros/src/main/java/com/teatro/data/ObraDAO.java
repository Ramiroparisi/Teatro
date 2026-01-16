package com.teatro.data;

import com.teatro.modelo.Funcion;
import com.teatro.modelo.Obra;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObraDAO {
    public void add(Obra o) throws SQLException {
        String sql = "INSERT INTO Obra (Nombre, Descripcion, Duracion, Foto, EmpleadoID, TeatroID) VALUES (?, ?, ?, ?, ?, ?)";
        Connection cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, o.getNombre());
            ps.setString(2, o.getDescripcion());
            ps.setInt(3, o.getDuracion());
            
            if (o.getFoto() != null) {
                ps.setBinaryStream(4, o.getFoto());
            } else {
                ps.setNull(4, java.sql.Types.BLOB);
            }
            
            ps.setObject(5, o.getEmpleadoID(), java.sql.Types.INTEGER);
            ps.setObject(6, o.getTeatroID(), java.sql.Types.INTEGER);
            
            ps.executeUpdate();
            
            try (ResultSet rsID = ps.getGeneratedKeys()) {
                if (rsID.next()) o.setId(rsID.getInt(1));
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public void put(Obra o) throws SQLException {
        String sql = "UPDATE Obra SET Nombre=?, Descripcion=?, Duracion=?, Foto=?, EmpleadoID=?, TeatroID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, o.getNombre());
            ps.setString(2, o.getDescripcion());
            ps.setInt(3, o.getDuracion());
            ps.setBinaryStream(4, o.getFoto());
            ps.setObject(5, o.getEmpleadoID(), java.sql.Types.INTEGER);
            ps.setObject(6, o.getTeatroID(), java.sql.Types.INTEGER);
            ps.setInt(7, o.getId());
            
            ps.executeUpdate();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Obra WHERE ID = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }


    public List<Obra> getAllWithFunciones() throws SQLException {
        List<Obra> lista = new ArrayList<>();
        String sqlObras = "SELECT o.*, t.Nombre as nombreTeatro FROM obra o " +
                          "INNER JOIN teatro t ON o.TeatroID = t.ID";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement psObra = cn.prepareStatement(sqlObras);
             ResultSet rsObra = psObra.executeQuery()) {
            
            while (rsObra.next()) {
                Obra o = mapearObra(rsObra);
                o.setNombreTeatro(rsObra.getString("nombreTeatro"));
                o.setFunciones(getFuncionesPorObra(cn, o.getId()));
                
                lista.add(o);
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }


    private List<Funcion> getFuncionesPorObra(Connection cn, int obraID) throws SQLException {
        List<Funcion> funciones = new ArrayList<>();
        String sqlFunc = "SELECT * FROM funcion WHERE ObraID = ? ORDER BY Fecha, Hora";
        try (PreparedStatement psFunc = cn.prepareStatement(sqlFunc)) {
            psFunc.setInt(1, obraID);
            try (ResultSet rsFunc = psFunc.executeQuery()) {
                while (rsFunc.next()) {
                    Funcion f = new Funcion();
                    f.setId(rsFunc.getInt("ID"));
                    f.setFecha(rsFunc.getDate("Fecha"));
                    f.setHora(rsFunc.getTime("Hora"));
                    f.setPrecio(rsFunc.getBigDecimal("Precio"));
                    funciones.add(f);
                }
            }
        }
        return funciones;
    }

    public Obra getByID(int id) throws SQLException {
        Obra o = null;
        String sql = "SELECT o.*, t.Nombre as nombreTeatro FROM Obra o " +
                     "LEFT JOIN teatro t ON o.TeatroID = t.ID WHERE o.ID = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    o = mapearObra(rs);
                    o.setNombreTeatro(rs.getString("nombreTeatro"));
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return o;
    }


    private Obra mapearObra(ResultSet rs) throws SQLException {
        Obra o = new Obra();
        o.setId(rs.getInt("ID"));
        o.setNombre(rs.getString("Nombre"));
        o.setDescripcion(rs.getString("Descripcion"));
        o.setDuracion(rs.getInt("Duracion"));
        o.setFoto(rs.getBinaryStream("Foto"));
        o.setEmpleadoID((Integer) rs.getObject("EmpleadoID"));
        o.setTeatroID((Integer) rs.getObject("TeatroID"));
        
        return o;
    }
}