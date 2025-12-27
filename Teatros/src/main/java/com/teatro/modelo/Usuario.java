package com.teatro.modelo;

import java.io.Serializable;

public class Usuario implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	
	private int id;
	private String nombre;
	private String apellido;
	private String tipoDoc;
	private String documento;
	private String telefono;
	private String mail;
	private String usuario;
	private String contraseña;
	private RolUsuario rol;
    private Integer teatroID;
    
    public Usuario() {
    }

    public Usuario(int id, String nombre, String apellido, String tipoDoc, String documento, String telefono, String mail, String usuario, String contrasena, RolUsuario rol, Integer teatroID) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.tipoDoc = tipoDoc;
        this.documento = documento;
        this.telefono = telefono;
        this.mail = mail;
        this.usuario = usuario;
        this.contraseña = contrasena;
        this.rol = rol;
        this.teatroID = teatroID;
    }


    public Usuario(String nombre,String apellido, String tipoDoc, String documento, String telefono, String mail, String usuario, String contrasena, RolUsuario rol, Integer teatroID) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.tipoDoc = tipoDoc;
        this.documento = documento;
        this.mail = mail;
        this.usuario = usuario;
        this.contraseña = contrasena;
        this.rol = rol;
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

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    
    public String getTipoDoc() {
        return tipoDoc;
    }

    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }
    
    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento= documento;
    }  
    
    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contraseña;
    }

    public void setContrasena(String contrasena) {
        this.contraseña = contrasena;
    }

    public RolUsuario getRol() {
        return rol;
    }

    public void setRol(RolUsuario rol) {
        this.rol = rol;
    }

    public Integer getTeatroID() {
        return teatroID;
    }

    public void setTeatroID(Integer teatroID) {
        this.teatroID = teatroID;
    }
}
