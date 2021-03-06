package model;

import java.util.Date;
import java.util.List;

import dao.PacienteDAO;

public class Paciente {
	private int codigoPaciente;
	private String nome;
	private String nomeMae;
	private String cpf;
	private String numeroSus;
	private String enderecoRua;
	private int enderecoNumero;
	private String enderecoBairro;
	private String enderecoCEP;
	private String enderecoComplemento;
	private int enderecoCodigoCidade;
	private String enderecoCidade;
	private int enderecoCodigoEstado;
	private String enderecoEstado;
	private String numeroTelefone;
	private Date dataNascimento;
	
	public int getCodigoPaciente() {
		return codigoPaciente;
	}
	public void setCodigoPaciente(int codigoPaciente) {
		this.codigoPaciente = codigoPaciente;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getNomeMae() {
		return nomeMae;
	}
	public void setNomeMae(String nomeMae) {
		this.nomeMae = nomeMae;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public String getNumeroSus() {
		return numeroSus;
	}
	public void setNumeroSus(String numeroSus) {
		this.numeroSus = numeroSus;
	}
	public String getEnderecoRua() {
		return enderecoRua;
	}
	public void setEnderecoRua(String enderecoRua) {
		this.enderecoRua = enderecoRua;
	}
	public int getEnderecoNumero() {
		return enderecoNumero;
	}
	public void setEnderecoNumero(int enderecoNumero) {
		this.enderecoNumero = enderecoNumero;
	}
	public String getEnderecoBairro() {
		return enderecoBairro;
	}
	public void setEnderecoBairro(String enderecoBairro) {
		this.enderecoBairro = enderecoBairro;
	}
	public String getEnderecoCEP() {
		return enderecoCEP;
	}
	public void setEnderecoCEP(String enderecoCEP) {
		this.enderecoCEP = enderecoCEP;
	}
	public String getEnderecoComplemento() {
		return enderecoComplemento;
	}
	public void setEnderecoComplemento(String enderecoComplemento) {
		this.enderecoComplemento = enderecoComplemento;
	}
	public String getEnderecoCidade() {
		return enderecoCidade;
	}
	public void setEnderecoCidade(String enderecoCidade) {
		this.enderecoCidade = enderecoCidade;
	}
	public String getEnderecoEstado() {
		return enderecoEstado;
	}
	public void setEnderecoEstado(String enderecoEstado) {
		this.enderecoEstado = enderecoEstado;
	}
	public String getNumeroTelefone() {
		return numeroTelefone;
	}
	public void setNumeroTelefone(String numeroTelefone) {
		this.numeroTelefone = numeroTelefone;
	}
	public Date getDataNascimento() {
		return dataNascimento;
	}
	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	public int getEnderecoCodigoCidade() {
		return enderecoCodigoCidade;
	}
	public void setEnderecoCodigoCidade(int enderecoCodigoCidade) {
		this.enderecoCodigoCidade = enderecoCodigoCidade;
	}
	public int getEnderecoCodigoEstado() {
		return enderecoCodigoEstado;
	}
	public void setEnderecoCodigoEstado(int enderecoCodigoEstado) {
		this.enderecoCodigoEstado = enderecoCodigoEstado;
	}
	
	public boolean cadastrarPaciente() {
		PacienteDAO pdao = new PacienteDAO();
		if (pdao.insert(this))
			return true;
		else
			return false;
	}
	
	public Paciente localizarPaciente() {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.select(getNumeroSus());
	}
	
	public boolean atualizarPaciente() {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.update(this);
	}
	
	public List<Estado> getEstados() {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.getEstados();
	}
	
	public List<Cidade> getCidades(int codigoEstado) {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.getCidades(codigoEstado);		
	}
	
	public boolean existeCpfPaciente(String cpf) {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.existeCpfPaciente(cpf);
	}
	
	public boolean existeNumeroSusPaciente(String numeroSus) {
		PacienteDAO pdao = new PacienteDAO();
		return pdao.existeNumeroSusPaciente(numeroSus);
	}
}