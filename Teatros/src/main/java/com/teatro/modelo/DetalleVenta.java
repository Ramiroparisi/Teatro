package com.teatro.modelo;

import java.io.Serializable;
import java.math.BigDecimal;

public class DetalleVenta implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int pedidoID;
    private int entradaID;
    private BigDecimal precioUnitario;

    public DetalleVenta() {
    }

    public DetalleVenta(int entradaId, BigDecimal precioUnitario) {
        this.entradaID = entradaId;
        this.precioUnitario = precioUnitario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPedidoID() {
        return pedidoID;
    }

    public void setPedidoID(int pedidoId) {
        this.pedidoID = pedidoId;
    }

    public int getEntradaID() {
        return entradaID;
    }

    public void setEntradaID(int entradaId) {
        this.entradaID = entradaId;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
}