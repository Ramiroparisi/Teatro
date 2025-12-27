package com.teatro.data;

import java.sql.Connection;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        Connection cn = DbConnector.getInstancia().getConn();

        try {
            if (cn != null && !cn.isClosed()) {
                System.out.println("Conexión exitosa");
                System.out.println("Conectado a: " + cn.getCatalog());
               
                DbConnector.getInstancia().releaseConn();
                System.out.println("Conexión liberada correctamente.");
            } else {
                System.out.println(" La conexión es nula o está cerrada.");
            }
        } catch (SQLException e) {
            System.out.println(" Error al verificar la conexión.");
            e.printStackTrace();
        }
    }
}