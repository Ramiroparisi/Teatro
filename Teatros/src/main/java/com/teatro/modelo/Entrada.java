package com.teatro.modelo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class Entrada implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private int id;
    private EstadoEntrada estado; 
    private int clienteID;
    private int funcionID;
    private int asientoID;
    

    private String nombreObra;
    private Date fecha;   
    private Time hora;
    private String filaNombre;
    private int asientoNum;
    
    public Entrada() {
    }

    public Entrada(EstadoEntrada estado, int clienteID, int funcionID, int asientoID) {
        this.estado = estado;
        this.clienteID = clienteID;
        this.funcionID = funcionID;
        this.asientoID = asientoID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public EstadoEntrada getEstado() {
        return estado;
    }

    public void setEstado(EstadoEntrada estado) {
        this.estado = estado;
    }

    public int getClienteID() {
        return clienteID;
    }

    public void setClienteID(int clienteID) {
        this.clienteID = clienteID;
    }

    public int getFuncionID() {
        return funcionID;
    }

    public void setFuncionID(int funcionID) {
        this.funcionID = funcionID;
    }

    public int getAsientoID() {
        return asientoID;
    }

    public void setAsientoID(int asientoID) {
        this.asientoID = asientoID;
    }


    
    public String getNombreObra() {
        return nombreObra;
    }

    public void setNombreObra(String nombreObra) {
        this.nombreObra = nombreObra;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Time getHora() {
        return hora;
    }

    public void setHora(Time hora) {
        this.hora = hora;
    }

    public String getFilaNombre() {
        return filaNombre;
    }

    public void setFilaNombre(String filaNombre) {
        this.filaNombre = filaNombre;
    }

    public int getAsientoNum() {
        return asientoNum;
    }

    public void setAsientoNum(int asientoNum) {
        this.asientoNum = asientoNum;
    }
}