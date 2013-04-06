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
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial) values (" +
		    		"(select count(temp.co_status_leito)+1 from (select co_paciente from tb_endereco) as temp join tb_paciente on tb_paciente.co_paciente=temp.co_paciente where tb_paciente.nr_sus=111111111111111, " +
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
				"dt_final is null";
			Statement smt = con.createStatement();
		    smt.executeUpdate(sqlUpdateLeitoAntigo);
		    
		    String sqlInsertLeitoStatusNovo = "insert into tb_status_leito (co_leito, co_status, dt_inicial) values (" +
					""+l.getCodigoLeito()+", " +
					""+l.getCodigoStatusLeito()+", " +
					""+new java.sql.Date(new java.util.Date().getTime())+")";
		    
		    smt.execute(sqlInsertLeitoStatusNovo);
		    smt.close();
		    
		    return true;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
