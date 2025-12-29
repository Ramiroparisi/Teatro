package com.teatro.modelo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Pedido implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date fecha;
    private BigDecimal total;
    private String estado; // 'Pendiente', 'Aprobado', 'Rechazado', 'Cancelado'
    private String metodoPago;
    private String mercadoPagoId;
    private int usuarioId;
    
    private List<DetalleVenta> detalles;


    public Pedido() {
        this.detalles = new ArrayList<>();
        this.total = BigDecimal.ZERO;
        this.estado = "Pendiente";
        this.fecha = new Date();
    }

    public void agregarDetalle(DetalleVenta detalle) {
        this.detalles.add(detalle);
        this.total = this.total.add(detalle.getPrecioUnitario());
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getMercadoPagoId() {
        return mercadoPagoId;
    }

    public void setMercadoPagoId(String mercadoPagoId) {
        this.mercadoPagoId = mercadoPagoId;
    }

    public int getUsuarioID() {
        return usuarioId;
    }

    public void setUsuarioID(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public List<DetalleVenta> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleVenta> detalles) {
        this.detalles = detalles;
    }
}