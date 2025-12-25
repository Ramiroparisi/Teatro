package com.teatro.modelo;

import java.io.Serializable;
import java.io.InputStream;

public class Obra implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nombre;
	private InputStream foto;
	private String descripcion;
	private int duracion;
	private int empleadoID;
	
	public Obra() {
    }

    public Obra(String nombre, String descripcion, int duracion, int empleadoID) {
        this.nombre = nombre;
        this.foto = foto;
        this.descripcion = descripcion;
        this.duracion = duracion;
        this.empleadoID = empleadoID;
    }

    public Obra(int id, String nombre, String descripcion, int duracion, int empleadoID) {
        this.id = id;
        this.nombre = nombre;
        this.foto = foto;
        this.descripcion = descripcion;
        this.duracion = duracion;
        this.empleadoID = empleadoID;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public int getEmpleadoID() {
        return empleadoID;
    }

    public void setEmpleadoID(int empleadoID) {
        this.empleadoID = empleadoID;
    }

	public InputStream getFoto() {
		return foto;
	}

	public void setFoto(InputStream foto) {
		this.foto = foto;
	}
}
