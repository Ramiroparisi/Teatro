package com.teatro.modelo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;

public class Funcion implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private Date fecha; 
    private Time hora;
    private BigDecimal precio;
    private Integer obraID;
    private Integer teatroID;
    
    public Funcion() {
    }

    public Funcion(Date fecha, Time hora, int obraID) {
        this.fecha = fecha;
        this.hora = hora;
        this.obraID = obraID;
    }

    public Funcion(int id, Date fecha, Time hora, int obraID) {
        this.id = id;
        this.fecha = fecha;
        this.hora = hora;
        this.obraID = obraID;
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

    
    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }
    public Integer getObraID() {
        return obraID;
    }

    public void setObraID(Integer obraID) {
        this.obraID = obraID;
    }
    
	public Integer getTeatroID() {
	    return teatroID;
	}

	public void setTeatroID(Integer teatroID) {
	    this.teatroID = teatroID;
	}
}
