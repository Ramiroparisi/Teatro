package com.teatro.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;

public class DbConnector {

	private static DbConnector instance;

	private String driver = "com.mysql.cj.jdbc.Driver";
	
	private String url;
	private String user;
	private String password;

	private int conectados = 0;
	private Connection conn = null;

	private DbConnector() {
		try {
			Class.forName(driver);
			
			Map<String, String> env = System.getenv();
			this.url = env.get("DB_URL");
			this.user = env.get("DB_USER");
			this.password = env.get("DB_PASS");
			
			if (this.url == null || this.user == null || this.password == null) {
				System.err.println("Advertencia: Faltan variables de entorno de la base de datos (DB_URL, DB_USER, DB_PASS).");
			}
			
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
				conn = DriverManager.getConnection(url, user, password);
				conectados = 0;
			}
		} catch (SQLException e) {
			System.err.println(
					"Error crítico: No se pudo conectar a la base de datos. Verifique credenciales y URL.");
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