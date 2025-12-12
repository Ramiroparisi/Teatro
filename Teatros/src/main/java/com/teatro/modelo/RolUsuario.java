package com.teatro.modelo;

public enum RolUsuario {
	CLIENTE,
    EMPLEADO,
    ADMIN;

    public String toDbString() {
        return this.name().toLowerCase();
    }
}
