package model;

import java.util.Date;

import dao.AgendamentoDAO;

public class Agendamento {
	private int codigoAgendamento;
	private Date dataAgendamento;
	private Paciente paciente;
	private Leito leito;
	private Medico medico;
	private String statusAgendamento;
	
	public int getCodigoAgendamento() {
		return codigoAgendamento;
	}
	public void setCodigoAgendamento(int codigoAgendamento) {
		this.codigoAgendamento = codigoAgendamento;
	}
	public Date getDataAgendamento() {
		return dataAgendamento;
	}
	public void setDataAgendamento(Date dataAgendamento) {
		this.dataAgendamento = dataAgendamento;
	}
	public Paciente getPaciente() {
		return paciente;
	}
	public void setPaciente(Paciente paciente) {
		this.paciente = paciente;
	}
	public Leito getLeito() {
		return leito;
	}
	public void setLeito(Leito leito) {
		this.leito = leito;
	}
	public Medico getMedico() {
		return medico;
	}
	public void setMedico(Medico medico) {
		this.medico = medico;
	}
	public String getStatusAgendamento() {
		return statusAgendamento;
	}
	public void setStatusAgendamento(String statusAgendamento) {
		this.statusAgendamento = statusAgendamento;
	}
	
	public boolean efetuarAgendamento() {
		AgendamentoDAO adao = new AgendamentoDAO();
		return adao.insert(this);
	}
	
	public boolean cancelarAgendamento() {
		AgendamentoDAO adao = new AgendamentoDAO();
		return adao.update(this);
	}
	
	public boolean verificaPacienteAgendado(String numeroSus) {
		AgendamentoDAO adao = new AgendamentoDAO();
		return adao.verificaPacienteAgendado(numeroSus);
	}
	
	public boolean verificaAgendamentoDataLeito(int codigoLeito, java.util.Date data) {
		AgendamentoDAO adao = new AgendamentoDAO();
		return adao.verificaAgendamentoDataLeito(codigoLeito, data);
	}
	
	public Agendamento getAgendamento(String numeroSus) {
		AgendamentoDAO adao = new AgendamentoDAO();
		return adao.select(numeroSus);
	}
}