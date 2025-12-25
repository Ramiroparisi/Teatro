package com.teatro.modelo;

import java.io.Serializable;
import java.math.BigDecimal;

public class DetalleVenta implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int pedidoId;
    private int entradaId;
    private BigDecimal precioUnitario;

    public DetalleVenta() {
    }

    public DetalleVenta(int entradaId, BigDecimal precioUnitario) {
        this.entradaId = entradaId;
        this.precioUnitario = precioUnitario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPedidoId() {
        return pedidoId;
    }

    public void setPedidoId(int pedidoId) {
        this.pedidoId = pedidoId;
    }

    public int getEntradaId() {
        return entradaId;
    }

    public void setEntradaId(int entradaId) {
        this.entradaId = entradaId;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
}