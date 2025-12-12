package com.teatro.modelo;

import java.io.Serializable;

public class Entrada implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
    private EstadoEntrada estado; 
    private int clienteID;
    private int funcionID;
    private int asientoID;
    
    public Entrada() {
    }

    public Entrada(EstadoEntrada estado, int clienteID, int funcionID, int asientoID) {
        this.estado = estado;
        this.clienteID = clienteID;
        this.funcionID = funcionID;
        this.asientoID = asientoID;
    }

    public Entrada(int id, EstadoEntrada estado, int clienteID, int funcionID, int asientoID) {
        this.id = id;
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
}
