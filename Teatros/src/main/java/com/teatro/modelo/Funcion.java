package com.teatro.modelo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class Funcion implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private Date fecha; 
    private Time hora;
    private int obraID;
    private int salaID;
    
    public Funcion() {
    }

    public Funcion(Date fecha, Time hora, int obraID, int salaID) {
        this.fecha = fecha;
        this.hora = hora;
        this.obraID = obraID;
        this.salaID = salaID;
    }

    public Funcion(int id, Date fecha, Time hora, int obraID, int salaID) {
        this.id = id;
        this.fecha = fecha;
        this.hora = hora;
        this.obraID = obraID;
        this.salaID = salaID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getObraID() {
        return obraID;
    }

    public void setObraID(int obraID) {
        this.obraID = obraID;
    }

    public int getSalaID() {
        return salaID;
    }

    public void setSalaID(int salaID) {
        this.salaID = salaID;
    }
}
