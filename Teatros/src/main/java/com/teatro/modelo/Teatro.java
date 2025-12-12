package com.teatro.modelo;

import java.io.Serializable;

public class Teatro implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String nombre;
	private String direccion;
	private String pais;
	private String ciudad;
	
	public Teatro() {
    }

    public Teatro(String nombre, String direccion, String pais, String ciudad) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.pais = pais;
        this.ciudad = ciudad;
    }

    public Teatro(int id, String nombre, String direccion, String pais, String ciudad) {
        this.id = id;
        this.nombre = nombre;
        this.direccion = direccion;
        this.pais = pais;
        this.ciudad = ciudad;
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }
}
