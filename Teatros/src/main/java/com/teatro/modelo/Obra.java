package com.teatro.modelo;

import java.io.Serializable;
import java.io.InputStream;
import java.util.List; 
import com.teatro.modelo.Funcion;

public class Obra implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nombre;
	private InputStream foto;
	private String descripcion;
	private int duracion;
	private Integer empleadoID;
	private Integer teatroID;
	private String nombreTeatro;
	private List<Funcion> funciones;
	
	public Obra() {
    }

    public Obra(String nombre, String descripcion, int duracion, int empleadoID, InputStream foto, int teatroID) {
        this.nombre = nombre;
        this.foto = foto;
        this.descripcion = descripcion;
        this.duracion = duracion;
        this.empleadoID = empleadoID;
        this.teatroID = teatroID;
    }

    public Obra(int id, String nombre, String descripcion, int duracion, int empleadoID, InputStream foto, int teatroID) {
        this.id = id;
        this.nombre = nombre;
        this.foto = foto;
        this.descripcion = descripcion;
        this.duracion = duracion;
        this.empleadoID = empleadoID;
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

    public Integer getEmpleadoID() {
        return empleadoID;
    }

    public void setEmpleadoID(Integer empleadoID) {
        this.empleadoID = empleadoID;
    }

	public InputStream getFoto() {
		return foto;
	}

	public void setFoto(InputStream foto) {
		this.foto = foto;
	}
	
	public Integer getTeatroID() {
	    return teatroID;
	}

	public void setTeatroID(Integer teatroID) {
	    this.teatroID = teatroID;
	}
	
	public String getNombreTeatro() { 
		return nombreTeatro; 
	}
	public void setNombreTeatro(String nombreTeatro) { 
		this.nombreTeatro = nombreTeatro; 
	}
	
	public List<Funcion> getFunciones() {
        return funciones;
    }

    public void setFunciones(List<Funcion> funciones) {
        this.funciones = funciones;
    }
}
