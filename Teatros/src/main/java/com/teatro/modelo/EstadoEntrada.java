package com.teatro.modelo;

public enum EstadoEntrada {
	RESERVADA,
	PAGADA,
    CANCELADA,
    USADA;
    
    public String toDbString() {
        return this.name();
    }
}
