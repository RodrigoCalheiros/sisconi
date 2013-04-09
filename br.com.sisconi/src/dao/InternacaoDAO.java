package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import model.Internacao;
import model.Leito;
import model.Medico;
import model.Paciente;

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
	
	public boolean encerrarInternacao(Internacao i) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlEncerrarInternacao = "update tb_internacao set dt_final = NOW() " +
					"where co_internacao = "+i.getCodigoInternacao()+" and " +
					"dt_final is null";
			
			Statement smt = con.createStatement();
		    smt.execute(sqlEncerrarInternacao);
		    
		    String sqlUpdateLeitoAntigo = "update tb_status_leito set " +
					"dt_final = NOW() " + 
					"where co_leito = "+i.getLeito().getCodigoLeito()+" and " +
					"co_status = 4 and " +
					"dt_final is null";
		    
		    smt.executeUpdate(sqlUpdateLeitoAntigo);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+i.getLeito().getCodigoLeito()+"), " +
					""+i.getLeito().getCodigoLeito()+", " +
					"2, " +
					"NOW())";
		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean remanejarInternacao(Internacao i, int codigoLeitoNovo) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlRemanejarInternacao = "update tb_internacao set co_leito = "+codigoLeitoNovo+" "+
					"where co_internacao = "+i.getCodigoInternacao()+" and " +
					"dt_final is null";
			
			Statement smt = con.createStatement();
		    smt.execute(sqlRemanejarInternacao);
		    
		    String sqlUpdateLeitoAntigo = "update tb_status_leito set " +
					"dt_final = NOW() " + 
					"where co_leito = "+i.getLeito().getCodigoLeito()+" and " +
					"co_status = 4 and " +
					"dt_final is null";
		    
		    smt.executeUpdate(sqlUpdateLeitoAntigo);
		    
		    String sqlStatusLeitoAntigo = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+i.getLeito().getCodigoLeito()+"), " +
					""+i.getLeito().getCodigoLeito()+", " +
					"2, " +
					"NOW())";
		    smt.execute(sqlStatusLeitoAntigo);
		    
		    String sqlStatusLeitoNovo = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+codigoLeitoNovo+"), " +
					""+codigoLeitoNovo+", " +
					"4, " +
					"NOW())";
		    smt.execute(sqlStatusLeitoNovo);
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean darAlta(Internacao i) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlDarAlta = "update tb_internacao set ds_alta = '"+i.getDescricaoDaAlta()+"' "+
					"where co_internacao = "+i.getCodigoInternacao()+" and " +
					"ds_alta is null and " +
					"dt_final is null";
			
			Statement smt = con.createStatement();
		    smt.execute(sqlDarAlta);		    
		    
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<Internacao> getHistoricoInternacao(Paciente p) {
		try {
			List<Internacao> lin = new ArrayList<Internacao>();
			Connection con = ConexaoBD.getInstancia().getConexao();
			String sqlListarInternacoes = "select i.co_internacao, i.co_leito, l.co_patrimonio, i.co_paciente, p.nm_paciente, i.dt_inicial, i.dt_final, i.ds_alta " +
					"from tb_internacao as i " +
					"join tb_paciente as p on i.co_paciente = p.co_paciente " +
					"join tb_leito as l on i.co_leito = l.co_leito" +
					"where i.co_paciente = "+p.getCodigoPaciente();
						
			Statement smt = con.createStatement();
		    ResultSet res = smt.executeQuery(sqlListarInternacoes);
		    
		    while (res.next()) {
		    	List<Medico> lme = new ArrayList<Medico>();
		    	Internacao i = new Internacao();
		    	i.setCodigoInternacao(res.getInt("i.co_internacao"));
		    	i.setPaciente(p);
		    	Leito l = new Leito();
		    	l.setCodigoLeito(res.getInt("i.co_leito"));
		    	l.setCodigoPatrimonio(res.getInt("i.co_patrimonio"));
		    	i.setLeito(l);		    	
		    	String formatDataInicial = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(res.getDate("i.dt_inicial"));
		    	i.setDataInicial(new SimpleDateFormat("dd/MM/yyyy").parse(formatDataInicial));
		    	String formatDataFinal = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(res.getDate("i.dt_final"));
		    	i.setDataFinal(new SimpleDateFormat("dd/MM/yyyy").parse(formatDataFinal));
		    	i.setDescricaoDaAlta(res.getString("i.ds_alta"));
		    	
		    	String sqlListarMedicosInternacoes = "select u.co_usuario, u.nm_usuario from tb_medico as m " +
		    			"join tb_medico_internacao as mi on m.co_usuario = mi.co_usuario " +
		    			"join tb_usuario as u on m.co_usuario = u.co_usuario " +
		    			"join tb_internacao as i on mi.co_internacao = i.co_internacao " +
		    			"where i.co_internacao = "+i.getCodigoInternacao();
		    	
		    	Statement smt2 = con.createStatement();
		    	ResultSet res2 = smt2.executeQuery(sqlListarMedicosInternacoes);
		    	
		    	while (res2.next()) {
		    		Medico m = new Medico();
		    		m.setCodigoUsuario(res2.getInt("u.co_usuario"));
		    		m.setNome(res2.getString("u.nm_usuario"));
		    		lme.add(m);
		    	}
		    	res2.close();
		    	smt2.close();
		    	i.setListaMedico(lme);
		    	lin.add(i);		    	
		    }
		    
		    smt.close();
		    
		    
		    return lin;			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

}