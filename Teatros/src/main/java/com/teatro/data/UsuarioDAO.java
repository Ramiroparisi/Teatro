package com.teatro.data;

import com.teatro.modelo.Usuario;
import com.teatro.modelo.RolUsuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

	public void add(Usuario u) throws SQLException {
	    if (getByMail(u.getMail()) != null) {
	        throw new SQLException("El email '" + u.getMail() + "' ya está registrado.");
	    }
	    if (getByDocumento(u.getDocumento()) != null) {
	        throw new SQLException("El documento '" + u.getDocumento() + "' ya existe.");
	    }

	    String sql = "INSERT INTO Usuario (Nombre, Apellido, TipoDoc, Documento, Telefono, Mail, Contrasena, Rol, TeatroID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    
	    try (Connection cn = DbConnector.getInstancia().getConn();
	         PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	        
	        ps.setString(1, u.getNombre());
	        ps.setString(2, u.getApellido());
	        ps.setString(3, u.getTipoDoc());
	        ps.setString(4, u.getDocumento());
	        ps.setString(5, u.getTelefono());
	        ps.setString(6, u.getMail());
	        ps.setString(7, u.getContrasena());
	        ps.setString(8, u.getRol().toString());
	        
	        if (u.getTeatroID() != null) {
	            ps.setInt(9, u.getTeatroID());
	        } else {
	            ps.setNull(9, java.sql.Types.INTEGER);
	        }
	        
	        ps.executeUpdate();
	        
	        try (ResultSet rsID = ps.getGeneratedKeys()) {
	            if (rsID.next()) u.setId(rsID.getInt(1));
	        }
	    } finally {
	        DbConnector.getInstancia().releaseConn();
	    }
	}
    
    public Usuario login(String identificador, String pass) {
        Usuario u = null;
        Connection cn = DbConnector.getInstancia().getConn();
        
        if (cn == null) {
            System.err.println("ERROR: No se pudo obtener la conexión a la base de datos.");
            return null;
        }

        String sql = "SELECT * FROM usuario WHERE (Mail = ? OR Documento = ?) AND Contrasena = ?";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, identificador);
            ps.setString(2, identificador);
            ps.setString(3, pass);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = mapearUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return u;
    }

    public List<Usuario> getAll() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.*, t.Nombre as nombre_teatro FROM Usuario u " +
                     "LEFT JOIN Teatro t ON u.TeatroID = t.ID";
                     
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = mapearUsuario(rs);
                u.setNombreTeatro(rs.getString("nombre_teatro"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar usuarios con teatro: " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }

    public Usuario getByID(int id) {
        return findByColumn("ID", id);
    }

    public Usuario getByMail(String mail) {
        return findByColumn("Mail", mail);
    }

    public Usuario getByDocumento(String doc) {
        return findByColumn("Documento", doc);
    }

    public void put(Usuario u) {
        String sql = "UPDATE Usuario SET Nombre=?, Apellido=?, TipoDoc=?, Documento=?, Telefono=?, Mail=?, Contrasena=?, Rol=?, TeatroID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getTipoDoc());
            ps.setString(4, u.getDocumento());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getMail());
            ps.setString(7, u.getContrasena());
            ps.setString(8, u.getRol().toString());
            
            if (u.getTeatroID() != null) ps.setInt(9, u.getTeatroID()); 
            else ps.setNull(9, Types.INTEGER);
            
            ps.setInt(10, u.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario ID " + u.getId() + ": " + e.getMessage());
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
            System.err.println("Error al eliminar usuario ID " + id + ": " + e.getMessage());
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
            System.err.println("Error al buscar usuario por " + columna + ": " + e.getMessage());
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return u;
    }

    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        try {
            u.setId(rs.getInt("ID"));
            u.setNombre(rs.getString("Nombre"));
            u.setApellido(rs.getString("Apellido"));
            u.setTipoDoc(rs.getString("TipoDoc"));
            u.setDocumento(rs.getString("Documento"));
            u.setTelefono(rs.getString("Telefono"));
            u.setMail(rs.getString("Mail"));
            u.setContrasena(rs.getString("Contrasena"));

            String rolDB = rs.getString("Rol");
            if (rolDB != null) {
                try {
                    u.setRol(RolUsuario.valueOf(rolDB.trim().toLowerCase())); 
                } catch (IllegalArgumentException ex) {
                    System.err.println("Error: El rol '" + rolDB + "' no coincide con el Enum.");
                }
            }
            
            int teatroId = rs.getInt("TeatroID");
            u.setTeatroID(rs.wasNull() ? null : teatroId);
            
        } catch (SQLException e) {
            System.err.println("Error en mapeo de Usuario: " + e.getMessage());
            throw e;
        }
        return u;
    }
}