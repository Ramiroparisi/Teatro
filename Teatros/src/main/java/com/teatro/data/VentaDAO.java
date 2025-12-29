package com.teatro.data;

import com.teatro.modelo.Pedido;
import com.teatro.modelo.DetalleVenta;
import java.sql.*;

public class VentaDAO {

    public void registrarVenta(Pedido p) throws SQLException {
        Connection cn = null;
        try {
            cn = DbConnector.getInstancia().getConn();
            cn.setAutoCommit(false); 

            String sqlPedido = "INSERT INTO Pedido (Fecha, Total, UsuarioID) VALUES (?, ?, ?)";
            int idPedidoGenerado = 0;

            try (PreparedStatement psP = cn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                psP.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
                psP.setBigDecimal(2, p.getTotal());
                psP.setInt(3, p.getUsuarioID());
                psP.executeUpdate();

                ResultSet rs = psP.getGeneratedKeys();
                if (rs.next()) {
                    idPedidoGenerado = rs.getInt(1);
                }
            } catch (SQLException e) {
                System.err.println("Error al insertar la cabecera del Pedido: " + e.getMessage());
                throw e; 
            }

            String sqlDetalle = "INSERT INTO DetalleVenta (PedidoID, EntradaID, PrecioUnitario) VALUES (?, ?, ?)";
            String sqlUpdateEntrada = "UPDATE Entrada SET Estado = 'Vendido' WHERE ID = ?";

            try (PreparedStatement psD = cn.prepareStatement(sqlDetalle);
                 PreparedStatement psU = cn.prepareStatement(sqlUpdateEntrada)) {
                
                for (DetalleVenta dv : p.getDetalles()) {
                    psD.setInt(1, idPedidoGenerado);
                    psD.setInt(2, dv.getEntradaID());
                    psD.setBigDecimal(3, dv.getPrecioUnitario());
                    psD.addBatch();


                    psU.setInt(1, dv.getEntradaID());
                    psU.addBatch();
                }
                
                psD.executeBatch();
                psU.executeBatch();
            } catch (SQLException e) {
                System.err.println("Error al procesar los detalles de venta o actualizar entradas: " + e.getMessage());
                throw e;
            }

            cn.commit(); 
            System.out.println("Venta registrada con éxito. Pedido ID: " + idPedidoGenerado);

        } catch (SQLException e) {
            if (cn != null) {
                try {
                    cn.rollback();
                    System.err.println("Se realizó un ROLLBACK debido a un error en la transacción.");
                } catch (SQLException re) {
                    System.err.println("Error crítico al intentar realizar el rollback: " + re.getMessage());
                }
            }
            throw e;
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                DbConnector.getInstancia().releaseConn();
            }
        }
    }
}