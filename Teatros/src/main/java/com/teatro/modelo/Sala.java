package com.teatro.modelo;

import java.io.Serializable;

public class Sala implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nombre;
	private int capacidad;
	private int teatroID;
	
	public Sala() {
    }

    public Sala(String nombre, int capacidad, int teatroID) {
        this.nombre = nombre;
        this.capacidad = capacidad;
        this.teatroID = teatroID;
    }

    public Sala(int id, String nombre, int capacidad, int teatroID) {
        this.id = id;
        this.nombre = nombre;
        this.capacidad = capacidad;
        this.teatroID = teatroID;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public int getTeatroID() {
        return teatroID;
    }

    public void setTeatroID(int teatroID) {
        this.teatroID = teatroID;
    }
}
