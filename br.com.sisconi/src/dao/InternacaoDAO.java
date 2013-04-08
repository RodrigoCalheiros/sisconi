package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import model.Internacao;

public class InternacaoDAO {
	
	public boolean insert(Internacao i) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlInternacao = "insert into tb_internacao (co_leito, co_paciente, dt_inicial) values (" +
					i.getLeito().getCodigoLeito()+", " +
					i.getPaciente().getCodigoPaciente()+", " +
					"NOW())";
			Statement smt = con.createStatement();
		    smt.execute(sqlInternacao, Statement.RETURN_GENERATED_KEYS);
		    
		    ResultSet res = smt.getGeneratedKeys();
		    if (res.next()) {
		    	i.setCodigoInternacao(res.getInt(1));
		    }
		    res.close();
		    
		    for (int j=0; j<i.getListaMedico().size(); j++) {
		    	String sqlMedicoInternacao = "insert into tb_medico_internacao (co_usuario, co_internacao) values (" +
			    		i.getListaMedico().get(j).getCodigoUsuario()+", " +
			    		i.getCodigoInternacao()+")";
			    smt.execute(sqlMedicoInternacao);
		    }
		    
		    String sqlUpdateLeitoAntigo = "update tb_status_leito set " +
					"dt_final = NOW() " + 
					"where co_leito = "+i.getLeito().getCodigoLeito()+" and " +
					"co_status = 3 and " +
					"dt_final is null";
		    
		    smt.executeUpdate(sqlUpdateLeitoAntigo);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+i.getLeito().getCodigoLeito()+"), " +
					""+i.getLeito().getCodigoLeito()+", " +
					"4, " +
					"NOW())";
		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
