package com.teatro.modelo;

public enum EstadoEntrada {
	Reservada,
	Pagada,
    Cancelada,
    Usada;
    
    public String toDbString() {
        return this.name();
    }
}
