package com.teatro.modelo;

public enum RolUsuario {
	cliente,
    empleado,
    admin;

    public String toDbString() {
        return this.name().toLowerCase();
    }
}
