package model;

import java.util.Date;
import java.util.List;

import dao.InternacaoDAO;

public class Internacao {
	private int codigoInternacao;
	private Paciente paciente;
	private Leito leito;
	private List<Medico> listaMedico;
	private Date dataInicial;
	private Date dataFinal;
	private String descricaoDaAlta;
	
	public int getCodigoInternacao() {
		return codigoInternacao;
	}
	public void setCodigoInternacao(int codigoInternacao) {
		this.codigoInternacao = codigoInternacao;
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
	public List<Medico> getListaMedico() {
		return listaMedico;
	}
	public void setListaMedico(List<Medico> listaMedico) {
		this.listaMedico = listaMedico;
	}
	public Date getDataInicial() {
		return dataInicial;
	}
	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}
	public Date getDataFinal() {
		return dataFinal;
	}
	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}
	public String getDescricaoDaAlta() {
		return descricaoDaAlta;
	}
	public void setDescricaoDaAlta(String descricaoDaAlta) {
		this.descricaoDaAlta = descricaoDaAlta;
	}
	
	public boolean iniciarInternacao() {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.insert(this);
	}
	
	public boolean encerrarInternacao() {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.encerrarInternacao(this);
	}
	
	public boolean remanejarInternacao(int codigoLeitoNovo) {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.remanejarInternacao(this, codigoLeitoNovo);
	}
	
	public boolean darAlta() {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.darAlta(this);
	}
	
	public List<Internacao> getHistoricoInternacao(int codigoPaciente) {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.getHistoricoInternacao(codigoPaciente);
	}
	
	public boolean verificaPacienteInternado(String numeroSus) {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.verificaPacienteInternado(numeroSus);
	}
	
	public Internacao getInternacaoAtiva(String numeroSus) {
		InternacaoDAO idao = new InternacaoDAO();
		return idao.getInternacaoAtiva(numeroSus);
	}
}
