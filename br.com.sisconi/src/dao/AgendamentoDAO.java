package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import model.Agendamento;
import model.Leito;
import model.Medico;
import model.Paciente;

public class AgendamentoDAO {
	public boolean insert(Agendamento a) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement smt = con.createStatement();
			
			String sqlAgendamento = "insert into tb_agendamento (co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento) values (" +
					a.getLeito().getCodigoLeito()+", " +
					a.getMedico().getCodigoUsuario()+", " +
					a.getPaciente().getCodigoPaciente()+", " +
					"'" + new java.sql.Date(a.getDataAgendamento().getTime())+"', " +
					"'Agendado')";
			System.out.println(sqlAgendamento);
		    smt.execute(sqlAgendamento);
		    
//		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial, dt_final) values (" +
//		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+a.getLeito().getCodigoLeito()+"), " +
//					a.getLeito().getCodigoLeito()+", " +
//					"5, " +
//					a.getDataAgendamento()+", " +
//					a.getDataAgendamento()+")";
//		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public Agendamento select(String numeroSus) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Agendamento a = new Agendamento();			
			Statement smt = con.createStatement();
			
			String sqlAgendamento = "select a.co_agendamento, a.co_leito, a.co_usuario, a.co_paciente, a.dt_agendamento, a.ds_status_agendamento, " +
					"p.nm_paciente, p.nm_mae, p.nr_sus, l.co_ala, ala.ds_ala, u.nm_usuario, m.nr_crm " +
					"from tb_agendamento as a " +
					"join tb_paciente as p on p.co_paciente = a.co_paciente " +
					"join tb_leito as l on l.co_leito = a.co_leito " +
					"join tb_medico as m on m.co_usuario = a.co_usuario " +
					"join tb_ala as ala on l.co_ala = ala.co_ala " +
					"join tb_usuario as u on u.co_usuario = m.co_usuario " +
					"where p.nr_sus like '"+numeroSus+"'";
			
		    ResultSet res = smt.executeQuery(sqlAgendamento);
		    
		    if (res.next()) {
		    	a.setCodigoAgendamento(res.getInt("a.co_agendamento"));
		    	a.setDataAgendamento(res.getDate("a.dt_agendamento"));
		    	a.setStatusAgendamento(res.getString("a.ds_status_agendamento"));
		    	Leito l = new Leito();
		    	l.setCodigoLeito(res.getInt("a.co_leito"));
		    	l.setCodigoAla(res.getInt("l.co_ala"));
		    	l.setDescricaoAla(res.getString("ala.ds_ala"));
		    	a.setLeito(l);
		    	Medico m = new Medico();
		    	m.setCodigoUsuario(res.getInt("a.co_usuario"));
		    	m.setCrm(res.getInt("m.nr_crm"));
		    	m.setNome(res.getString("u.nm_usuario"));		    	
		    	a.setMedico(m);
		    	Paciente p = new Paciente();
		    	p.setCodigoPaciente(res.getInt("a.co_paciente"));
		    	p.setNome(res.getString("p.nm_paciente"));
		    	p.setNomeMae(res.getString("p.nm_mae"));
		    	p.setNumeroSus(res.getString("p.nr_sus"));		    	
		    	a.setPaciente(p);		    	
		    }
		    
		    smt.close();
		    return a;			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public boolean update(Agendamento a) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement smt = con.createStatement();
			
			String sqlCancelarAgendamento = "update tb_agendamento set ds_status_agendamento = 'Cancelado' " +
					"where co_agendamento = "+a.getCodigoAgendamento();
					
		    smt.execute(sqlCancelarAgendamento);
		    smt.close();
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean verificaPacienteAgendado(String numeroSus) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement smt = con.createStatement();
			String sqlVerificaPacienteAgendado = "select p.co_paciente from tb_agendamento as a " +
					"join tb_paciente as p on p.co_paciente = a.co_paciente " +
					"where nr_sus like '"+numeroSus+"' and DATE(a.dt_agendamento) >= CURDATE() and ds_status_agendamento like 'Agendado'";
			ResultSet res = smt.executeQuery(sqlVerificaPacienteAgendado);
			if (res.next()) {
				return true;
			}
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean verificaAgendamentoDataLeito(int codigoLeito, java.util.Date data) {
		try{
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement smt = con.createStatement();
			String sqlVerificaAgendamentoDataLeito = "select co_agendamento, co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento " +
					"from tb_agendamento where co_leito = "+codigoLeito+" " +
					"and DATE(dt_agendamento) like '"+new SimpleDateFormat("yyyy-MM-dd").format(data)+"' " +
					"and ds_status_agendamento like 'Agendado'";
			
			ResultSet res = smt.executeQuery(sqlVerificaAgendamentoDataLeito);
			if (res.next()) {
				return true;
			}
			res.close();
			smt.close();
			return false;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}