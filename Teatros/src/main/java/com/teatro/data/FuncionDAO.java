package com.teatro.data;

import com.teatro.modelo.Funcion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionDAO {

	public void add(Funcion f) throws SQLException {
		Connection cn = null;
		String sql = "INSERT INTO Funcion (Fecha, Hora, ObraID, SalaID) VALUES (?, ?, ?, ?)";
		cn = DbConnector.getInstancia().getConn();
		
		try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			ps.setDate(1, f.getFecha());
			ps.setTime(2, f.getHora());
			
            if (f.getObraID() != null) {
                ps.setInt(3, f.getObraID());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            if (f.getSalaID() != null) {
                ps.setInt(4, f.getSalaID());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.executeUpdate();
            
            ResultSet rsID = ps.getGeneratedKeys();
            if (rsID.next()) {
                f.setId(rsID.getInt(1));
            }
		}
		
		finally {
            DbConnector.getInstancia().releaseConn();
		}
	}
	
    public void put(Funcion f) {
        String sql = "UPDATE Obra SET Fecha=?, Hora=?, ObraID=?, SalaID=? WHERE ID=?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDate(1, f.getFecha());
            ps.setTime(2, f.getHora());
            
            if (f.getObraID() != null) {
                ps.setInt(3, f.getObraID());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            if (f.getSalaID() != null) {
                ps.setInt(4, f.getSalaID());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.setInt(5, f.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }
    
    private Funcion mapearFuncion(ResultSet rs) throws SQLException {
        Funcion f = new Funcion();
        f.setId(rs.getInt("ID"));
        f.setFecha(rs.getDate("Fecha"));
        f.setHora(rs.getTime("Hora"));
        
        int idObra = rs.getInt("ObraID");
        if (rs.wasNull()) {
            f.setObraID(null);
        } else {
            f.setObraID(idObra);
        }
        
        int idSala = rs.getInt("SalaID");
        if (rs.wasNull()) {
            f.setSalaID(null);
        } else {
            f.setSalaID(idSala);
        }
        
        return f;
    }
    
    public List<Funcion> getAll() {
        List<Funcion> lista = new ArrayList<>();
        String sql = "SELECT * FROM Funcion";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearFuncion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }
    
    public Funcion getByID(int id) {
        return findByColumn("ID", id);
    }

    public Funcion getByNombre(String user) {
        return findByColumn("Fecha", user);
    }
    
    public void delete(int id) {
        String sql = "DELETE FROM Funcion WHERE ID = ?";
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
    
    private Funcion findByColumn(String columna, Object valor) {
        Funcion f = null;
        String sql = "SELECT * FROM Funcion WHERE " + columna + " = ?";
        Connection cn = DbConnector.getInstancia().getConn();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setObject(1, valor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) f = mapearFuncion(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return f;
    }
	
}
