package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import model.Agendamento;

public class AgendamentoDAO {
	public boolean insert(Agendamento a) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			
			String verificaAgendamentoDataLeito = "select co_agendamento, co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento " +
					"from tb_agendamento where co_leito = "+a.getLeito().getCodigoLeito()+" " +
					"and DATE(dt_agendamento) like '"+new SimpleDateFormat("yyyy-MM-dd").format(a.getDataAgendamento())+"' " +
					"and ds_status_agendamento like 'Agendado'";
			Statement smt = con.createStatement();
			ResultSet res = smt.executeQuery(verificaAgendamentoDataLeito);
			
			if (res.next()) {
				return false;
			}
			res.close();
			
			String sqlAgendamento = "insert into tb_agendamento (co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento) values (" +
					a.getLeito().getCodigoLeito()+", " +
					a.getMedico().getCodigoUsuario()+", " +
					a.getPaciente().getCodigoPaciente()+", " +
					new java.sql.Date(a.getDataAgendamento().getTime())+", " +
					"'Agendado'";
			
		    smt.execute(sqlAgendamento);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial, dt_final) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+a.getLeito().getCodigoLeito()+"), " +
					a.getLeito().getCodigoLeito()+", " +
					"5, " +
					a.getDataAgendamento()+", " +
					a.getDataAgendamento()+")";
		    smt.execute(sqlStatusLeito);
		    smt.close();
		    
		    return true;			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean update(Agendamento a) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			
			String verificaAgendamentoDataLeito = "select co_agendamento, co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento " +
					"from tb_agendamento where co_leito = "+a.getLeito().getCodigoLeito()+" " +
					"and DATE(dt_agendamento) like '"+new SimpleDateFormat("yyyy-MM-dd").format(a.getDataAgendamento())+"' " +
					"and ds_status_agendamento like 'Agendado'";
			Statement smt = con.createStatement();
			ResultSet res = smt.executeQuery(verificaAgendamentoDataLeito);
			
			if (res.next()) {
				return false;
			}
			res.close();
			
			String sqlAgendamento = "update tb_agendamento set (co_leito, co_usuario, co_paciente, dt_agendamento, ds_status_agendamento) values (" +
					a.getLeito().getCodigoLeito()+", " +
					a.getMedico().getCodigoUsuario()+", " +
					a.getPaciente().getCodigoPaciente()+", " +
					new java.sql.Date(a.getDataAgendamento().getTime())+", " +
					"'Agendado'";
			
		    smt.execute(sqlAgendamento);
		    
		    String sqlStatusLeito = "insert into tb_status_leito (co_status_leito, co_leito, co_status, dt_inicial, dt_final) values (" +
		    		"(select count(temp.co_leito)+1 from (select co_leito from tb_status_leito) as temp where temp.co_leito = "+a.getLeito().getCodigoLeito()+"), " +
					a.getLeito().getCodigoLeito()+", " +
					"5, " +
					a.getDataAgendamento()+", " +
					a.getDataAgendamento()+")";
		    smt.execute(sqlStatusLeito);
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
			String sqlVerificaPacienteInternado = "select tb_paciente.nr_sus from tb_paciente " +
					"join tb_internacao on tb_paciente.co_paciente = tb_internacao.co_paciente " +
					"where tb_paciente.nr_sus like '"+numeroSus+"' and tb_internacao.dt_final is null";
			ResultSet res = smt.executeQuery(sqlVerificaPacienteInternado);
			if (res.next()) {
				return true;
			}
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}