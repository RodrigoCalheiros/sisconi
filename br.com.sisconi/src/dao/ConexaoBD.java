package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBD {
	private String url = "jdbc:mysql://localhost/sisconibd";
	private String usuario = "sisconi";
	private String senha = "!S1sC0niK3y%";
	private Connection conexao;
	private static ConexaoBD conexaoBD;
	
	private ConexaoBD() {		 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			this.conexao = DriverManager.getConnection(url, usuario, senha);
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}
	
	public static ConexaoBD getInstancia() {
		if (conexaoBD == null)
			conexaoBD = new ConexaoBD();
		return conexaoBD;
	}
	
	public Connection getConexao() {
		return conexao;
	}
	
	public boolean fecharConexao() {
		boolean retorno = false;
		try {
			conexao.close();
			retorno = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return retorno;
	}
}