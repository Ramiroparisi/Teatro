package com.teatro.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnector {
    
    private static DbConnector instance;

    private String driver = "com.mysql.cj.jdbc.Driver";
    private String host = "localhost";
    private String port = "3306";
    private String user = "root";
    private String password = "root";
    private String db = "teatros"; 
    
    private int conectados = 0;
    private Connection conn = null;

    private DbConnector() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el Driver de MySQL.");
            e.printStackTrace();
        }
    }
    
    public static DbConnector getInstancia() {
        if (instance == null) {
            instance = new DbConnector();
        }
        return instance;
    }
    
    public Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                String url = "jdbc:mysql://" + host + ":" + port + "/" + db + 
                             "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                conn = DriverManager.getConnection(url, user, password);
                conectados = 0;
            }
        } catch (SQLException e) {
            System.err.println("Error crítico: No se pudo conectar a la base de datos. Verifique credenciales y nombre de DB.");
            e.printStackTrace();
        }
        conectados++;
        return conn;
    }
    
    public void releaseConn() {
        conectados--;
        try {
            if (conn != null && conectados <= 0) {
                if (!conn.isClosed()) {
                    conn.close();
                }
                conn = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}