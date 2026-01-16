package com.teatro.data;

import com.teatro.modelo.Asiento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsientoDAO {

	public List<Asiento> getEstadoAsientos(int teatroId, int funcionId) throws SQLException {
	    List<Asiento> lista = new ArrayList<>();
	    String sql = "SELECT a.*, (e.ID IS NOT NULL) as ocupado " +
	                 "FROM asiento a " +
	                 "LEFT JOIN entrada e ON a.ID = e.AsientoID AND e.FuncionID = ? " +
	                 "WHERE a.TeatroID = ? " +
	                 "ORDER BY a.fila_coord, a.col_coord";
	    
	    try (Connection cn = DbConnector.getInstancia().getConn();
	         PreparedStatement ps = cn.prepareStatement(sql)) {
	        ps.setInt(1, funcionId);
	        ps.setInt(2, teatroId);
	        
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Asiento a = new Asiento();
	                a.setId(rs.getInt("ID"));
	                a.setFilaCoord(rs.getInt("fila_coord"));
	                a.setColCoord(rs.getInt("col_coord"));
	                a.setFilaNombre(rs.getString("fila_nombre"));
	                a.setNumero(rs.getInt("Numero"));
	                a.setOcupado(rs.getBoolean("ocupado")); 
	                lista.add(a);
	            }
	        }
	    }
	    return lista;
	}
	
    public List<Asiento> getByTeatro(int teatroId) throws SQLException {
        List<Asiento> lista = new ArrayList<>();
        String sql = "SELECT * FROM asiento WHERE TeatroID = ? ORDER BY fila_coord, col_coord";
        
        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            
            ps.setInt(1, teatroId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Asiento a = new Asiento();
                    a.setId(rs.getInt("ID"));
                    a.setFilaCoord(rs.getInt("fila_coord"));
                    a.setColCoord(rs.getInt("col_coord"));
                    a.setFilaNombre(rs.getString("fila_nombre"));
                    a.setNumero(rs.getInt("Numero"));
                    a.setTeatroID(rs.getInt("TeatroID"));
                    lista.add(a);
                }
            }
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
        return lista;
    }


    public void saveDiagrama(int teatroId, List<Asiento> asientos) throws SQLException {
        String deleteSql = "DELETE FROM asiento WHERE TeatroID = ?";
        String insertSql = "INSERT INTO asiento (fila_coord, col_coord, fila_nombre, Numero, TeatroID) VALUES (?, ?, ?, ?, ?)";
        
        Connection cn = DbConnector.getInstancia().getConn();
        try {
            cn.setAutoCommit(false); 

            try (PreparedStatement psDel = cn.prepareStatement(deleteSql)) {
                psDel.setInt(1, teatroId);
                psDel.executeUpdate();
            }

            try (PreparedStatement psIns = cn.prepareStatement(insertSql)) {
                for (Asiento a : asientos) {
                    psIns.setInt(1, a.getFilaCoord());
                    psIns.setInt(2, a.getColCoord());
                    psIns.setString(3, a.getFilaNombre());
                    psIns.setInt(4, a.getNumero());
                    psIns.setInt(5, teatroId);
                    psIns.addBatch();
                }
                psIns.executeBatch();
            }
            
            cn.commit();
        } catch (SQLException e) {
            cn.rollback();
            throw e;
        } finally {
            cn.setAutoCommit(true);
            DbConnector.getInstancia().releaseConn();
        }
    }
    
    public void generarAsientosDeTeatro(int teatroId) throws SQLException {
        String sqlTeatro = "SELECT capacidad FROM teatro WHERE ID = ?";
        int capacidad = 0;
        
        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement psT = cn.prepareStatement(sqlTeatro)) {
            psT.setInt(1, teatroId);
            ResultSet rsT = psT.executeQuery();
            if (rsT.next()) {
                capacidad = rsT.getInt("capacidad");
            }
        }
        int dimension = (int) Math.ceil(Math.sqrt(capacidad));
        String sqlInsert = "INSERT INTO asiento (teatroID, fila_nombre, fila_coord, col_coord, Numero) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection cn = DbConnector.getInstancia().getConn();
             PreparedStatement psI = cn.prepareStatement(sqlInsert)) {
            
            int asientosCreados = 0;
            for (int f = 1; f <= dimension && asientosCreados < capacidad; f++) {
                String letraFila = String.valueOf((char) ('A' + (f - 1)));
                for (int c = 1; c <= dimension && asientosCreados < capacidad; c++) {
                    psI.setInt(1, teatroId);
                    psI.setString(2, letraFila);
                    psI.setInt(3, f);
                    psI.setInt(4, c);
                    psI.setInt(5, c);
                    psI.addBatch();
                    asientosCreados++;
                }
            }
            psI.executeBatch();
        } finally {
            DbConnector.getInstancia().releaseConn();
        }
    }
}