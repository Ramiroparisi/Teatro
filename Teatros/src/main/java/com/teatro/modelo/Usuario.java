package com.teatro.modelo;

import java.io.Serializable;

public class Usuario implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	
	private int id;
	private String nomYApe;
	private String telefono;
	private String mail;
	private String usuario;
	private String contraseña;
	private RolUsuario rol;
    private Integer teatroID;
    
    public Usuario() {
    }

    public Usuario(int id, String nomYApe, String telefono, String mail, String usuario, String contrasena, RolUsuario rol, Integer teatroID) {
        this.id = id;
        this.nomYApe = nomYApe;
        this.telefono = telefono;
        this.mail = mail;
        this.usuario = usuario;
        this.contraseña = contrasena;
        this.rol = rol;
        this.teatroID = teatroID;
    }


    public Usuario(String nomYApe, String telefono, String mail, String usuario, String contrasena, RolUsuario rol, Integer teatroID) {
        this.nomYApe = nomYApe;
        this.telefono = telefono;
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

    public String getNomYApe() {
        return nomYApe;
    }

    public void setNomYApe(String nomYApe) {
        this.nomYApe = nomYApe;
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
