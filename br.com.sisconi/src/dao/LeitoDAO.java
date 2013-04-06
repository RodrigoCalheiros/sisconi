package dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import model.Leito;

public class LeitoDAO {
	
	public boolean insert(Leito l) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlLeito = "insert into tb_leito (co_leito, co_ala) values (" +
					""+l.getCodigoLeito()+", " +
					""+l.getCodigoAla()+")";
			Statement smt = con.createStatement();
		    smt.execute(sqlLeito);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_leito, co_status, dt_inicial) values (" +
					""+l.getCodigoLeito()+", " +
					""+1+", " +
					""+new java.sql.Date(new java.util.Date().getTime())+")";
		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean update(Leito l) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlUpdateLeitoAntigo = "update tb_status_leito set " +
			"dt_final = '"+new java.sql.Date(new java.util.Date().getTime())+"' " + 
			"where co_leito = "+l.getCodigoLeito()+" and " +
			"dt_final = '";
			Statement smt = con.createStatement();
		    smt.executeUpdate(sqlUpdateLeitoAntigo);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_leito, co_status, dt_inicial) values (" +
					""+l.getCodigoLeito()+", " +
					""+1+", " +
					""+new java.sql.Date(new java.util.Date().getTime())+")";
		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
