package com.teatro.modelo;

import java.io.Serializable;

public class Asiento implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String fila;
	private int numero;
	private int teatroID;
	
    public Asiento() {
    }

    public Asiento(int numero, int teatroID) {
        this.numero = numero;
        this.teatroID = teatroID;
    }

    public Asiento(int id, int numero, int teatroID) {
        this.id = id;
        this.numero = numero;
        this.teatroID = teatroID;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getFila() {
        return fila;
    }

    public void setFila(String fila) {
        this.fila = fila;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getTeatroID() {
        return teatroID;
    }

    public void setTeatroID(int teatroID) {
        this.teatroID = teatroID;
    }
}
