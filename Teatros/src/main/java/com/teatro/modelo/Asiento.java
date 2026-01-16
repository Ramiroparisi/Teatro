package com.teatro.modelo;

import java.io.Serializable;

public class Asiento implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int filaCoord;
    private int colCoord;
    private String filaNombre;
    private int numero;
    private int teatroID;
    private String tipo;
    
    private boolean ocupado;

    public Asiento() {
    }

    public Asiento(int filaCoord, int colCoord, String filaNombre, int numero, int teatroID) {
        this.filaCoord = filaCoord;
        this.colCoord = colCoord;
        this.filaNombre = filaNombre;
        this.numero = numero;
        this.teatroID = teatroID;
    }

    public int getId() {
    	return id; 
    }
    public void setId(int id) {
    	this.id = id; 
    }

    public int getFilaCoord() { 
    	return filaCoord; 
    }
    public void setFilaCoord(int filaCoord) { 
    	this.filaCoord = filaCoord; 
    }

    public int getColCoord() { 
    	return colCoord; 
    }
    public void setColCoord(int colCoord) { 
    	this.colCoord = colCoord; 
    }

    public String getFilaNombre() { 
    	return filaNombre; 
    }
    public void setFilaNombre(String filaNombre) { 
    	this.filaNombre = filaNombre; 
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

    public String getTipo() { 
    	return tipo; 
    }
    public void setTipo(String tipo) { 
    	this.tipo = tipo; 
    }
    
    public boolean isOcupado() { 
    	return ocupado; 
    }
    public void setOcupado(boolean ocupado) { 
    	this.ocupado = ocupado; 
    }
}