package com.teatro.data;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        System.out.println("--- Iniciando prueba de conexión ---");
        
        try {
            Connection cn = DbConnector.getInstancia().getConn();
            
            if (cn != null && !cn.isClosed()) {
                System.out.println("✅ ¡CONEXIÓN EXITOSA!");
                System.out.println("Conectado a: " + cn.getMetaData().getURL());
                
                DbConnector.getInstancia().releaseConn();
                System.out.println("✅ Conexión cerrada correctamente.");
            } else {
                System.err.println("❌ LA CONEXIÓN ES NULA. Revisa tu DbConnector.");
            }
        } catch (Exception e) {
            System.err.println("❌ OCURRIÓ UN ERROR:");
            e.printStackTrace(); 
        }
    }
}