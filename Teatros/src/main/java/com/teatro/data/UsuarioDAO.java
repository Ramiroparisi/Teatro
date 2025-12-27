package com.teatro.data;

import com.teatro.modelo.Usuario;
import com.teatro.modelo.RolUsuario;
import com.teatro.data.DbConnector;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

	public void add(Usuario u) throws SQLException {
    Connection cn = null;
    try {

        if (getByMail(u.getMail()) != null) {
            throw new SQLException("Ya existe una persona con el email: " + u.getMail());
        }

        if (getByDocumento(u.getDocumento()) != null) {
            throw new SQLException("Ya existe una persona con el número de documento: " + u.getDocumento());
        }

        String sql = "INSERT INTO Usuario (Nombre, Apellido, TipoDoc, Documento, Telefono, Mail, Usuario, Contrasena, Rol, TeatroID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        cn = DbConnector.getInstancia().getConn();
        
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getTipoDoc());
            ps.setString(4, u.getDocumento());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getMail());
            ps.setString(7, u.getUsuario());
            ps.setString(8, u.getContrasena());
            ps.setString(9, u.getRol().toString());
            
            if (u.getTeatroID() != null) ps.setInt(10, u.getTeatroID()); 
            else ps.setNull(10, Types.INTEGER);
            
            ps.executeUpdate();
            
            ResultSet rsID = ps.getGeneratedKeys();
            if (rsID.next()) {
                u.setId(rsID.getInt(1));
            }
        }
    } finally {
        DbConnector.getInstancia().releaseConn();
    }
}

    public List<Usuario> getAll() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM Usuario";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearUsuario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }

    public Usuario getByID(int id) {
        return findByColumn("ID", id);
    }

    public Usuario getByUsuario(String user) {
        return findByColumn("Usuario", user);
    }

    public Usuario getByMail(String mail) {
        return findByColumn("Mail", mail);
    }

    public Usuario getByDocumento(String doc) {
        return findByColumn("Documento", doc);
    }

    public void put(Usuario u) {
        String sql = "UPDATE Usuario SET Nombre=?, Apellido=?, TipoDoc=?, Documento=?, Telefono=?, Mail=?, Usuario=?, Contrasena=?, Rol=?, TeatroID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getTipoDoc());
            ps.setString(4, u.getDocumento());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getMail());
            ps.setString(7, u.getUsuario());
            ps.setString(8, u.getContrasena());
            ps.setString(9, u.getRol().toString());
            if (u.getTeatroID() != null) ps.setInt(10, u.getTeatroID()); else ps.setNull(10, Types.INTEGER);
            ps.setInt(11, u.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Usuario WHERE ID = ?";
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

    private Usuario findByColumn(String columna, Object valor) {
        Usuario u = null;
        String sql = "SELECT * FROM Usuario WHERE " + columna + " = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setObject(1, valor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) u = mapearUsuario(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return u;
    }

    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("ID"));
        u.setNombre(rs.getString("Nombre"));
        u.setApellido(rs.getString("Apellido"));
        u.setTipoDoc(rs.getString("TipoDoc"));
        u.setDocumento(rs.getString("Documento"));
        u.setTelefono(rs.getString("Telefono"));
        u.setMail(rs.getString("Mail"));
        u.setUsuario(rs.getString("Usuario"));
        u.setContrasena(rs.getString("Contrasena"));
        // Asumiendo que RolUsuario tiene un método valueOf para convertir String a Enum
        u.setRol(RolUsuario.valueOf(rs.getString("Rol")));
        
        int teatroId = rs.getInt("TeatroID");
        u.setTeatroID(rs.wasNull() ? null : teatroId);
        
        return u;
    }
}